# FASE 1: "Builder" - Costruisce l'applicazione
# Usa un'immagine leggera (alpine) per ridurre le dimensioni
FROM node:20-alpine AS builder

WORKDIR /app

# Copia solo package.json per sfruttare la cache di Docker
COPY package*.json ./

# Installa tutte le dipendenze (incluse quelle di sviluppo)
RUN npm install

# Copia il resto del codice sorgente
COPY . .

# Esegue il build per SSR, che compila sia il frontend che il server
RUN npm run build:ssr


# FASE 2: "Runner" - Esegue l'applicazione
# Ripartiamo da un'immagine pulita e ancora più leggera
FROM node:20-alpine

WORKDIR /usr/src/app

# Copia solo i file di dipendenza dalla fase di build
COPY --from=builder /app/package*.json ./

# Installa SOLO le dipendenze di produzione
RUN npm install --only=production

# Copia l'applicazione compilata dalla fase di build
COPY --from=builder /app/dist ./dist

# Esponi la porta su cui il server ascolterà (standard per Cloud Run e App Runner)
EXPOSE 8080

# Comando standard per avviare l'applicazione Node.js
CMD [ "npm", "start" ]