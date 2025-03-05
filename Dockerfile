# Basis-Image mit Node.js zum Bauen der App
FROM node:20 AS build

# Arbeitsverzeichnis setzen
WORKDIR /app

# Abhängigkeiten installieren und die App bauen
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

# Produktions-Image mit Nginx
FROM nginx:alpine

# Build-Output in Nginx-Webroot kopieren
COPY --from=build /app/build /usr/share/nginx/html

# Nginx-Standardport
EXPOSE 80

# Nginx starten
CMD ["nginx", "-g", "daemon off;"]
