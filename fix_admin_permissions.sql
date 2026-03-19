-- ============================================
-- FIX ADMIN TOURNAMENT CREATION PERMISSIONS
-- ============================================

-- This script ensures admins can create tournaments
-- Run this in Supabase SQL Editor

-- ============================================
-- STEP 1: Verify Your Admin Status
-- ============================================

-- Check if rkking9921@gmail.com is admin
SELECT id, email, role 
FROM profiles 
WHERE email = 'rkking9921@gmail.com';

-- If role is NOT 'admin', run this:
UPDATE profiles 
SET role = 'admin' 
WHERE email = 'rkking9921@gmail.com';

-- ============================================
-- STEP 2: Fix Tournament RLS Policies
-- ============================================

-- Enable RLS on tournaments table
ALTER TABLE tournaments ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to avoid conflicts
DROP POLICY IF EXISTS "Tournaments are viewable by everyone" ON tournaments;
DROP POLICY IF EXISTS "Anyone can view tournaments" ON tournaments;
DROP POLICY IF EXISTS "Admins can create tournaments" ON tournaments;
DROP POLICY IF EXISTS "Admins can update tournaments" ON tournaments;
DROP POLICY IF EXISTS "Admins can delete tournaments" ON tournaments;

-- Policy 1: Anyone authenticated can VIEW tournaments
CREATE POLICY "Anyone authenticated can view tournaments" 
ON tournaments FOR SELECT
TO authenticated
USING (true);

-- Policy 2: Admins can CREATE tournaments
CREATE POLICY "Admins can create tournaments" 
ON tournaments FOR INSERT
TO authenticated
WITH CHECK (
  EXISTS (
    SELECT 1 FROM profiles
    WHERE profiles.id = auth.uid() 
    AND profiles.role = 'admin'
  )
);

-- Policy 3: Admins can UPDATE tournaments
CREATE POLICY "Admins can update tournaments" 
ON tournaments FOR UPDATE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles
    WHERE profiles.id = auth.uid() 
    AND profiles.role = 'admin'
  )
);

-- Policy 4: Admins can DELETE tournaments
CREATE POLICY "Admins can delete tournaments" 
ON tournaments FOR DELETE
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM profiles
    WHERE profiles.id = auth.uid() 
    AND profiles.role = 'admin'
  )
);

-- ============================================
-- STEP 3: Verify Policies Created
-- ============================================

SELECT 
  tablename,
  policyname,
  cmd,
  roles
FROM pg_policies
WHERE tablename = 'tournaments'
ORDER BY policyname;

-- ============================================
-- STEP 4: Test Tournament Creation
-- ============================================

-- This simulates what the frontend does
-- You can test by running this directly in SQL editor

-- First, get your user ID
-- SELECT id FROM profiles WHERE email = 'rkking9921@gmail.com';

-- Then try inserting a test tournament (replace YOUR_USER_ID)
/*
INSERT INTO tournaments (
  title, 
  game, 
  description, 
  entry_fee, 
  prize_pool, 
  max_participants, 
  start_date, 
  created_by, 
  status
) VALUES (
  'Test Tournament',
  'Valorant',
  'Test tournament for admin permissions',
  10,
  1000,
  8,
  NOW() + INTERVAL '7 days',
  'YOUR_USER_ID',  -- Replace with actual UUID from query above
  'upcoming'
);
*/

-- ============================================
-- SUCCESS INDICATORS
-- ============================================
-- After running this script, you should see:
-- ✅ Your role updated to 'admin'
-- ✅ 4 policies created for tournaments table
-- ✅ Can create tournaments from frontend

-- ============================================
-- TROUBLESHOOTING
-- ============================================
-- If still can't create tournaments:

-- 1. Check current user's auth state in browser console:
--    const { data } = await supabase.auth.getUser();
--    console.log(data.user.id);

-- 2. Verify profile exists for that user ID:
--    SELECT * FROM profiles WHERE id = 'YOUR_USER_ID';

-- 3. If profile doesn't exist, re-run database_setup_complete.sql

-- 4. Clear browser cache and localStorage:
--    localStorage.clear();
--    Then logout and login again
