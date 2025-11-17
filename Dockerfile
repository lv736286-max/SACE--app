FROM node:18-alpine

WORKDIR /app

# Copiar archivos
COPY package*.json ./
COPY server.js ./
COPY public ./public

# Instalar dependencias
RUN npm install --production

# Exponer puerto
EXPOSE 3000

# Iniciar servidor
CMD ["npm", "start"]
