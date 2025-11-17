const express = require('express');
const path = require('path');
const app = express();

// Servir archivos estáticos
app.use(express.static(path.join(__dirname, 'public')));

// Redirigir URL raíz a app-interactiva.html
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Manejo de rutas SPA
app.get('/*', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'app-interactiva.html'));
});

const PORT = process.env.PORT || 3000;

// Health check endpoint para mantener el servidor activo
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', uptime: process.uptime() });
});

const server = app.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════════════╗
║  ✅ Servidor SACE activo y funcionando        ║
╠════════════════════════════════════════════════╣
║  🌍 URL Local:  http://localhost:${PORT}      ║
║  📱 IP Local:   http://192.168.1.37:${PORT}   ║
║  🚀 Online:     Deployar en Railway/Render   ║
║  📊 Health:     GET /health                   ║
╚════════════════════════════════════════════════╝
  `);
});

// Mantener el servidor activo
setInterval(() => {
  // Keep-alive para evitar desconexiones
}, 5 * 60 * 1000);

// Manejo de errores
process.on('uncaughtException', (err) => {
  console.error('Error no capturado:', err);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('Promesa rechazada no manejada:', reason);
});
