const express = require('express');
const cors = require('cors');
const dotenv = require('dotenv');

// Load environment variables
dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

// Middleware
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Import routes
try {
  const tournamentRoutes = require('./routes/tournaments');
  const indexRoutes = require('./routes/index');

  // Health check endpoint
  app.use('/api/health', indexRoutes);

  // API Routes
  app.use('/api/tournaments', tournamentRoutes);
  
  console.log('✅ Routes loaded successfully');
} catch (error) {
  console.error('❌ Error loading routes:', error);
  throw error;
}

// Root endpoint
app.get('/', (req, res) => {
  res.json({
    name: 'ArenaX Gaming API',
    version: '1.0.0',
    endpoints: {
      health: '/api/health',
      tournaments: '/api/tournaments'
    }
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    message: err.message 
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`🎮 ArenaX Gaming Backend running on port ${PORT}`);
  console.log(`📊 Environment: ${process.env.NODE_ENV}`);
  console.log(`🔗 Health check: http://localhost:${PORT}/api/health`);
  console.log(`📚 API Documentation: http://localhost:${PORT}/`);
});

module.exports = app;
