-- ============================================
-- MAKE USER ADMIN - Quick SQL Script
-- ============================================

-- This makes rkking9921@gmail.com an admin
-- Run this in Supabase SQL Editor

-- Step 1: Update role to admin
UPDATE profiles 
SET role = 'admin' 
WHERE email = 'rkking9921@gmail.com';

-- Step 2: Verify the change
SELECT id, email, full_name, role, created_at 
FROM profiles 
WHERE email = 'rkking9921@gmail.com';

-- ============================================
-- INSTRUCTIONS:
-- ============================================
-- 1. Go to: https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq
-- 2. Click "SQL Editor" → "New Query"
-- 3. Paste this entire script
-- 4. Click "Run" (or Ctrl+Enter)
-- 5. You should see your profile with role = "admin"
-- 6. Refresh your app and go to: http://localhost:3000/admin/dashboard
-- ============================================
