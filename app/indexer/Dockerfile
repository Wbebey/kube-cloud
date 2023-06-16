FROM node:18

WORKDIR /app

# Copier les fichiers de l'application
COPY . .

# Installer les dépendances
RUN yarn install

# Fetch the script
# ADD https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh /wait-for-it.sh

# # Make it executable
# RUN chmod +x /wait-for-it.sh

# Exposer un port si nécessaire
EXPOSE 9090


# Modify your command to wait for RabbitMQ
# CMD /wait-for-it.sh rabbitmq:5672 -- /wait-for-it.sh elasticsearch:9200 -- npm start
CMD sleep 10 && npm start
