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
app.listen(PORT, () => {
  console.log(`
╔════════════════════════════════════════════════╗
║  ✅ Servidor SACE activo y funcionando        ║
╠════════════════════════════════════════════════╣
║  🌍 URL Local:  http://localhost:${PORT}      ║
║  📱 IP Local:   http://192.168.1.37:${PORT}   ║
║  🚀 Online:     Usar LocalTunnel o similar   ║
╚════════════════════════════════════════════════╝
  `);
});
