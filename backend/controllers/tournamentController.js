const { supabase } = require('../config/database');

// Get all tournaments
exports.getAllTournaments = async (req, res) => {
  try {
    if (!supabase) {
      return res.status(500).json({
        success: false,
        error: 'Configuration Error',
        message: 'Supabase client not initialized. Check environment variables.'
      });
    }

    const { data, error } = await supabase
      .from('tournaments')
      .select('*')
      .order('start_date', { ascending: true });

    if (error) throw error;

    res.json({
      success: true,
      count: data.length,
      data
    });
  } catch (error) {
    console.error('Get all tournaments error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch tournaments',
      message: error.message
    });
  }
};

// Get single tournament by ID
exports.getTournamentById = async (req, res) => {
  try {
    const { id } = req.params;

    const { data, error } = await supabase
      .from('tournaments')
      .select('*')
      .eq('id', id)
      .single();

    if (error || !data) {
      return res.status(404).json({
        success: false,
        error: 'Tournament not found'
      });
    }

    res.json({
      success: true,
      data
    });
  } catch (error) {
    console.error('Get tournament by ID error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch tournament',
      message: error.message
    });
  }
};

// Create new tournament (Admin only)
exports.createTournament = async (req, res) => {
  try {
    const {
      title,
      game,
      description,
      entry_fee,
      prize_pool,
      max_participants,
      start_date,
      end_date
    } = req.body;

    // Validate required fields
    if (!title || !game || !start_date) {
      return res.status(400).json({
        success: false,
        error: 'Validation failed',
        message: 'Title, game, and start date are required'
      });
    }

    const tournamentData = {
      title,
      game,
      description: description || null,
      entry_fee: parseFloat(entry_fee) || 0,
      prize_pool: parseFloat(prize_pool) || null,
      max_participants: parseInt(max_participants) || 8,
      current_participants: 0,
      status: 'upcoming',
      start_date,
      end_date: end_date || null,
      created_by: req.user.id
    };

    const { data, error } = await supabase
      .from('tournaments')
      .insert([tournamentData])
      .select()
      .single();

    if (error) throw error;

    res.status(201).json({
      success: true,
      message: 'Tournament created successfully',
      data
    });
  } catch (error) {
    console.error('Create tournament error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create tournament',
      message: error.message
    });
  }
};

// Update tournament (Admin only)
exports.updateTournament = async (req, res) => {
  try {
    const { id } = req.params;
    const updateData = req.body;

    // Remove fields that shouldn't be updated
    delete updateData.created_by;
    delete updateData.current_participants;

    const { data, error } = await supabase
      .from('tournaments')
      .update(updateData)
      .eq('id', id)
      .select()
      .single();

    if (error || !data) {
      return res.status(404).json({
        success: false,
        error: 'Tournament not found or update failed'
      });
    }

    res.json({
      success: true,
      message: 'Tournament updated successfully',
      data
    });
  } catch (error) {
    console.error('Update tournament error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update tournament',
      message: error.message
    });
  }
};

// Delete tournament (Admin only)
exports.deleteTournament = async (req, res) => {
  try {
    const { id } = req.params;

    const { error } = await supabase
      .from('tournaments')
      .delete()
      .eq('id', id);

    if (error) throw error;

    res.json({
      success: true,
      message: 'Tournament deleted successfully'
    });
  } catch (error) {
    console.error('Delete tournament error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete tournament',
      message: error.message
    });
  }
};

// Join tournament (Authenticated users)
exports.joinTournament = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    // Check if already joined
    const { data: existing } = await supabase
      .from('tournament_participants')
      .select('id')
      .eq('tournament_id', id)
      .eq('user_id', userId)
      .single();

    if (existing) {
      return res.status(400).json({
        success: false,
        error: 'Already joined',
        message: 'You have already joined this tournament'
      });
    }

    // Check if tournament is full
    const { data: tournament } = await supabase
      .from('tournaments')
      .select('current_participants, max_participants')
      .eq('id', id)
      .single();

    if (!tournament) {
      return res.status(404).json({
        success: false,
        error: 'Tournament not found'
      });
    }

    if (tournament.current_participants >= tournament.max_participants) {
      return res.status(400).json({
        success: false,
        error: 'Tournament is full',
        message: 'This tournament has reached maximum capacity'
      });
    }

    // Add participant
    const { data, error } = await supabase
      .from('tournament_participants')
      .insert([
        {
          tournament_id: id,
          user_id: userId,
          status: 'active'
        }
      ])
      .select()
      .single();

    if (error) throw error;

    // Update tournament participant count
    await supabase
      .from('tournaments')
      .update({ 
        current_participants: tournament.current_participants + 1 
      })
      .eq('id', id);

    res.status(201).json({
      success: true,
      message: 'Successfully joined tournament',
      data
    });
  } catch (error) {
    console.error('Join tournament error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to join tournament',
      message: error.message
    });
  }
};

// Leave tournament (Authenticated users)
exports.leaveTournament = async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user.id;

    const { error } = await supabase
      .from('tournament_participants')
      .delete()
      .eq('tournament_id', id)
      .eq('user_id', userId);

    if (error) throw error;

    // Decrement participant count
    const { data: tournament } = await supabase
      .from('tournaments')
      .select('current_participants')
      .eq('id', id)
      .single();

    if (tournament && tournament.current_participants > 0) {
      await supabase
        .from('tournaments')
        .update({ 
          current_participants: tournament.current_participants - 1 
        })
        .eq('id', id);
    }

    res.json({
      success: true,
      message: 'Successfully left tournament'
    });
  } catch (error) {
    console.error('Leave tournament error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to leave tournament',
      message: error.message
    });
  }
};

// Get tournament participants (Admin only)
exports.getParticipants = async (req, res) => {
  try {
    const { id } = req.params;

    const { data, error } = await supabase
      .from('tournament_participants')
      .select(`
        *,
        profiles:user_id (
          id,
          email,
          full_name,
          username
        )
      `)
      .eq('tournament_id', id);

    if (error) throw error;

    res.json({
      success: true,
      count: data.length,
      data
    });
  } catch (error) {
    console.error('Get participants error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch participants',
      message: error.message
    });
  }
};
