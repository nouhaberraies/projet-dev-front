# Étape 1 : Construire l'application
FROM node:18 AS build

# Créer un répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier package.json et package-lock.json pour installer les dépendances
COPY package*.json ./

# Installer les dépendances de l'application React
RUN npm install

# Copier tout le reste du code source
COPY . .

# Construire l'application React
RUN npm run build

# Étape 2 : Configurer Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers de build générés dans l'étape précédente vers le répertoire de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80, par défaut pour Nginx
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
