# Stage 1: Construction de l'application
FROM node:14.20.0 AS node
WORKDIR /app

# Copier les fichiers de configuration des dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm ci

# Copier les fichiers sources de l'application
COPY . .

# Construire l'application
RUN npm run build --prod

# Stage 2: Serveur HTTP léger
FROM nginx:alpine

ENV NODE_ENV dev

# Copier les fichiers construits
COPY --from=node /app/dist/front /usr/share/nginx/html

# Configuration Nginx personnalisée si nécessaire
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exposer le port 80
EXPOSE 80

# Démarrer le serveur Nginx
CMD ["nginx", "-g", "daemon off;"]
