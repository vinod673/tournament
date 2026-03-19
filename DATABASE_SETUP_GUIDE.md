# 🗄️ Database Setup - Quick Guide

## ⚠️ You're Getting This Error Because:
The `tournament_participants` table doesn't exist in your Supabase database yet.

---

## ✅ SOLUTION: Run Complete Database Setup

### Step 1: Open Supabase SQL Editor
1. Go to: https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq
2. Click **"SQL Editor"** in the left sidebar
3. Click **"New Query"**

### Step 2: Run the Setup Script
1. Open file: `database_setup_complete.sql` (in this project folder)
2. Copy **ALL** the content
3. Paste into Supabase SQL Editor
4. Click **"Run"** button (or press Ctrl+Enter)

### Step 3: Verify Success
You should see output showing:
- ✅ Tables created: `profiles`, `tournaments`, `tournament_participants`
- ✅ Indexes created
- ✅ RLS policies created
- ✅ Trigger created

### Step 4: Refresh Your App
1. Go back to your browser
2. Refresh the page (F5)
3. Navigate to My Tournaments
4. The error should be GONE! 🎉

---

## 📊 What This Script Does:

### Creates 3 Tables:
1. **profiles** - User profiles linked to Supabase auth
2. **tournaments** - Tournament information
3. **tournament_participants** - Links users to tournaments they joined

### Adds Security:
- Enables Row Level Security (RLS) on all tables
- Creates policies so users can only see their own participations
- Admin policies for tournament management

### Automation:
- Creates trigger to auto-create profile when user signs up

---

## 🧪 After Running: Test Everything

### Test 1: Check Tables Exist
In Supabase Dashboard → Table Editor, you should see:
- ✅ profiles
- ✅ tournaments  
- ✅ tournament_participants

### Test 2: My Tournaments Page
Navigate to: http://localhost:3000/dashboard/my-tournaments

**Expected:**
- No console errors
- Shows "No Tournaments Yet" (if you haven't joined any)
- OR shows list of tournaments you've joined

### Test 3: Join a Tournament
1. Go to homepage: http://localhost:3000
2. Scroll to Featured Tournaments
3. Click "Join Tournament" on any card
4. Should successfully join!

---

## 🔍 Troubleshooting

### If Script Fails:
1. Check you're logged into Supabase dashboard
2. Make sure you copied the ENTIRE script
3. Try running it again (it uses `IF NOT EXISTS` so safe to re-run)

### If Still Getting Errors:
1. Check Supabase logs: Dashboard → Logs
2. Verify database schema is correct
3. Make sure extensions are enabled

### Manual Verification Queries:
```sql
-- Check tables
SELECT * FROM pg_tables WHERE schemaname = 'public';

-- Check policies
SELECT * FROM pg_policies WHERE schemaname = 'public';

-- Check your profile exists
SELECT * FROM profiles WHERE email = 'your-email@example.com';
```

---

## 📝 Important Notes

### Why This Happens:
- The database schema needs to be manually created in Supabase
- It doesn't auto-create from your code
- This is a one-time setup step

### When to Run This:
- ✅ First time setting up the project
- ✅ When you see "relation does not exist" error
- ✅ When tables are missing

### Safe to Re-run:
Yes! The script uses:
- `CREATE TABLE IF NOT EXISTS` - Won't duplicate tables
- `DROP POLICY IF EXISTS` - Cleans up old policies first
- All operations are idempotent

---

## 🎯 Next Steps After Database Setup

1. ✅ Create admin role (optional):
```sql
UPDATE profiles SET role = 'admin' WHERE email = 'your-email@example.com';
```

2. ✅ Test the full flow:
   - Signup → Login → Browse → Join → View My Tournaments

3. ✅ Add some test data (optional):
```sql
INSERT INTO tournaments (title, game, entry_fee, prize_pool, max_participants, start_date)
VALUES ('Test Tournament', 'Valorant', 10, 100, 8, NOW() + INTERVAL '7 days');
```

---

**Your database will be fully set up after running this script! 🚀**
