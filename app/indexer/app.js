require('dotenv').config();
const amqp = require('amqplib/callback_api');
const { Client } = require('@elastic/elasticsearch');

const amqpUri = process.env['AMQP_URI']
if (amqpUri == null)
    throw Error('Missing AMQP_URI environment variable.');
const esUri = process.env['ELASTICSEARCH_URI']
if (esUri == null)
    throw Error('Missing ELASTICSEARCH_URI environment variable.');

const esClient = new Client({
    node: esUri,
    maxRetries: 5,
    requestTimeout: 5000,
    sniffOnStart: false,
});

const consumeCreated = async (channel, msg) => {
    try {
        const body = JSON.parse(msg['content'].toString());
        const product = body['product'];
        
        await esClient.index({
            index: 'products',
            id: product['id'],
            body: product,
        });

        console.log('indexed product', product['id']);
        channel.ack(msg);
    } catch (err)  {
        console.error(err);
        channel.nack(msg, false, true);
    }
}

const consumeDeleted = async (channel, msg) => {
    try {
        const body = JSON.parse(msg['content'].toString());
        const productId = body['product_id'];

        await esClient.delete({
            index: 'products',
            id: productId,
        });

        console.log('unindexed product', productId);
        channel.ack(msg);
    } catch (err)  {
        console.error(err);
        channel.nack(msg, false, true);
    }
}

let conn; // Hold the AMQP connection for clean up
amqp.connect(amqpUri, function(error0, connection) {
    if (error0) {
        console.error('Cannot establish AMQP connection:', error0);
        process.exit(1);
    }

    conn = connection; // Assign to the outer scope variable

    connection.createChannel(function(error1, channel) {
        if (error1) {
            console.error('Cannot create channel:', error1);
            process.exit(1);
        }

        const exchangeName = 'product.event';
        const queueName1 = 'create';
        const routingKey1 = 'create';
        const queueName2 = 'delete';
        const routingKey2 = 'delete';

        channel.assertExchange(exchangeName, 'topic', {
            durable: false,
        });

        // create
        channel.assertQueue(queueName1, {
            durable: false,
        });
        channel.bindQueue(queueName1, exchangeName, routingKey1);
        channel.consume(queueName1, (msg) => consumeCreated(channel, msg));

        // delete
        channel.assertQueue(queueName2, {
            durable: false,
        });
        channel.bindQueue(queueName2, exchangeName, routingKey2);
        channel.consume(queueName2, (msg) => consumeDeleted(channel, msg));
    });
});

// On SIGINT/SIGTERM, close connection
process.on('SIGINT', () => {
    if (conn) conn.close();
    process.exit(0);
});
process.on('SIGTERM', () => {
    if (conn) conn.close();
    process.exit(0);
});
