-- ============================================
-- FIX RLS POLICIES FOR TOURNAMENT ACCESS
-- ============================================

-- This script ensures users can read their own tournament participations
-- Run this in Supabase SQL Editor if you're getting permission errors

-- 1. Enable RLS on tournament_participants table (if not already enabled)
ALTER TABLE tournament_participants ENABLE ROW LEVEL SECURITY;

-- 2. Drop existing policies if they exist (to avoid conflicts)
DROP POLICY IF EXISTS "Users can view own participations" ON tournament_participants;
DROP POLICY IF EXISTS "Users can insert own participations" ON tournament_participants;
DROP POLICY IF EXISTS "Users can delete own participations" ON tournament_participants;
DROP POLICY IF EXISTS "Admins can view all participations" ON tournament_participants;

-- 3. Create policy: Users can view their own tournament participations
CREATE POLICY "Users can view own participations" ON tournament_participants
  FOR SELECT
  USING (auth.uid() = user_id);

-- 4. Create policy: Users can join tournaments (insert their own participation)
CREATE POLICY "Users can insert own participations" ON tournament_participants
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. Create policy: Users can leave tournaments (delete their own participation)
CREATE POLICY "Users can delete own participations" ON tournament_participants
  FOR DELETE
  USING (auth.uid() = user_id);

-- 6. Create policy: Admins can view all participations
CREATE POLICY "Admins can view all participations" ON tournament_participants
  FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );

-- 7. Ensure tournaments table has proper RLS
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;

-- Drop existing tournament policies
DROP POLICY IF EXISTS "Anyone can view tournaments" ON tournaments;
DROP POLICY IF EXISTS "Admins can manage tournaments" ON tournaments;

-- Policy: Anyone can view tournaments (public reading)
CREATE POLICY "Anyone can view tournaments" ON tournaments
  FOR SELECT
  TO authenticated
  USING (true);

-- Policy: Only admins can create/update/delete tournaments
CREATE POLICY "Admins can manage tournaments" ON tournaments
  FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE profiles.id = auth.uid()
      AND profiles.role = 'admin'
    )
  );

-- 8. Verify policies are created
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd
FROM pg_policies
WHERE tablename IN ('tournaments', 'tournament_participants')
ORDER BY tablename, policyname;

-- ============================================
-- TEST QUERIES
-- ============================================

-- Test 1: Check if current user can see their participations
-- (Run this after logging in to Supabase dashboard)
-- SELECT * FROM tournament_participants WHERE user_id = auth.uid();

-- Test 2: Check user's role
-- SELECT role FROM profiles WHERE id = auth.uid();

-- ============================================
-- USAGE INSTRUCTIONS
-- ============================================
-- 1. Go to Supabase Dashboard → SQL Editor
-- 2. Paste this entire script
-- 3. Click "Run"
-- 4. Refresh your frontend app
-- 5. The error should be resolved
