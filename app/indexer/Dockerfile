FROM node:14-alpine

WORKDIR /app

# Copier les fichiers de l'application
COPY app.js package.json yarn.lock ./

# Installer les dépendances
RUN yarn install

# Exposer un port si nécessaire
# EXPOSE 3000

# Démarrer l'application
CMD ["node", "app.js"]