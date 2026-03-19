const express = require('express');
const router = express.Router();
const tournamentController = require('../controllers/tournamentController');
const { authenticateUser, requireAdmin } = require('../middleware/auth');

// Public routes - No authentication required
router.get('/', tournamentController.getAllTournaments);
router.get('/:id', tournamentController.getTournamentById);

// Protected routes - Authentication required
router.post('/:id/join', authenticateUser, tournamentController.joinTournament);
router.delete('/:id/leave', authenticateUser, tournamentController.leaveTournament);

// Admin routes - Admin access required
router.post('/', authenticateUser, requireAdmin, tournamentController.createTournament);
router.put('/:id', authenticateUser, requireAdmin, tournamentController.updateTournament);
router.delete('/:id', authenticateUser, requireAdmin, tournamentController.deleteTournament);
router.get('/:id/participants', authenticateUser, requireAdmin, tournamentController.getParticipants);

module.exports = router;
