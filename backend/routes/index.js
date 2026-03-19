const express = require('express');

const router = express.Router();

// Health check endpoint
router.get('/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    message: 'ArenaX Gaming API is running',
    timestamp: new Date().toISOString()
  });
});

module.exports = router;
