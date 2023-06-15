# Utilise l'image de base Go
FROM golang:1.18

# Définit le répertoire de travail à l'intérieur du conteneur
WORKDIR /app

# Copie les fichiers source de l'application dans le conteneur
COPY . .

# Construit l'application Go
RUN go build -o app

# Définit le point d'entrée de l'application
CMD ["./app"]