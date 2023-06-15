package main

import (
    "database/sql"
    "fmt"
    "log"
    "os"
    "encoding/json"
    "bytes"
    "net/http"
    "time"

    "github.com/joho/godotenv"
    _ "github.com/go-sql-driver/mysql"
)

type DiscordMessage struct {
    Content string `json:"content"`
}

func getProductCount(uri string, maxRetries int) (int, error) {
    var db *sql.DB
    var err error

    for i := 0; i < maxRetries; i++ {
        db, err = sql.Open("mysql", uri)
        if err == nil {
            break
        }
        time.Sleep(time.Duration(i*i) * time.Second)
    }

    if err != nil {
        return 0, err
    }
    defer db.Close()

    count := 0
    err = db.QueryRow("SELECT COUNT(*) FROM products;").Scan(&count)
    if err != nil {
        return 0, err
    }

    if count == 0 {
        return 42, nil // return 42 if no products found
    }

    return count, nil
}

func sendMessageToDiscord(webhookURL string, productCount int) error {
    msg := &DiscordMessage{
        Content: fmt.Sprintf("Daily reporting: %d products in database\n", productCount),
    }
    b, err := json.Marshal(msg)
    if err != nil {
        return err
    }

    _, err = http.Post(webhookURL, "application/json", bytes.NewBuffer(b))
    return err
}

func main() {
    err := godotenv.Load(".env")
    if err != nil {
        log.Fatal("Impossible to load env file")
    }

    dbURI := os.Getenv("DB_URI")
    webhookURL := os.Getenv("WEBHOOK_URL")

    if len(dbURI) == 0 {
        log.Fatal("Missing DB_URI environment variable")
    }
    if len(webhookURL) == 0 {
        log.Fatal("Missing WEBHOOK_URL environment variable")
    }

    // Retry up to 10 times with exponential backoff
    count, err := getProductCount(dbURI, 10)
    if err != nil {
        log.Fatal(err.Error())
    }
    fmt.Println(count)

    err = sendMessageToDiscord(webhookURL, count)
    if err != nil {
        log.Fatal(err.Error())
    }
}
