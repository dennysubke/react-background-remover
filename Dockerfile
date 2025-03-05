# Basis-Image mit Node.js zum Bauen der App
FROM node:20 AS build

# Arbeitsverzeichnis setzen
WORKDIR /app

# package.json und package-lock.json (falls vorhanden) kopieren und Abhängigkeiten installieren
COPY package.json ./
# Falls du auch package-lock.json hast, entkommentiere die nächste Zeile:
# COPY package-lock.json ./
RUN npm install

# Quellcode in das Image kopieren
COPY . .

# Die App bauen
RUN npm run build

# Produktions-Image mit Nginx
FROM nginx:alpine

# Build-Output in Nginx-Webroot kopieren
COPY --from=build /app/build /usr/share/nginx/html

# Nginx-Standardport
EXPOSE 80

# Nginx starten
CMD
