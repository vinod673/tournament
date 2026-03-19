# 🔧 Fix: "Failed to Create Tournament" Error

## 🎯 Quick Fix (2 Steps)

### Step 1: Run SQL Script to Fix Permissions

1. **Open Supabase SQL Editor:**
   https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq/sql/new

2. **Copy & Run This Script:**
   Open file: [`fix_admin_permissions.sql`](c:\New folder\fix_admin_permissions.sql)
   
   Copy ALL content → Paste into SQL Editor → Click "Run"

3. **Verify Success:**
   - ✅ Your role shows as 'admin'
   - ✅ 4 tournament policies created
   - ✅ No errors in output

---

### Step 2: Test Tournament Creation

1. **Refresh your browser** (F5)
2. **Go to:** http://localhost:3000/admin/dashboard
3. **Click "+ Create Tournament"**
4. **Fill in the form:**
   ```
   Title: Test Tournament
   Game: Valorant
   Entry Fee: 10
   Prize Pool: 1000
   Max Participants: 8
   Start Date: Pick any future date
   ```
5. **Click "Create Tournament"**
6. **Should succeed with message:** "Tournament created successfully! 🎮"

---

## 🔍 Common Causes & Solutions

### Cause 1: Missing Admin Role ❌

**Symptom:** Getting permission error (PGRST301)

**Solution:**
```sql
-- Run this in SQL Editor
UPDATE profiles 
SET role = 'admin' 
WHERE email = 'rkking9921@gmail.com';
```

---

### Cause 2: RLS Policies Not Set Up ❌

**Symptom:** Can't insert into tournaments table

**Solution:**
Run the complete `fix_admin_permissions.sql` script which creates:
- ✅ SELECT policy (view tournaments)
- ✅ INSERT policy (create tournaments)
- ✅ UPDATE policy (edit tournaments)
- ✅ DELETE policy (remove tournaments)

---

### Cause 3: Profile Doesn't Exist ❌

**Symptom:** "Profile not found" or foreign key violation

**Solution:**
Run the complete database setup:
1. Open: [`database_setup_complete.sql`](c:\New folder\database_setup_complete.sql)
2. Run in Supabase SQL Editor
3. This creates all tables and triggers

---

### Cause 4: Invalid Date Format ❌

**Symptom:** Error when creating tournament with date

**What I Fixed:**
Updated the admin dashboard to properly convert dates:
```typescript
// Before (broken):
start_date: newTournament.start_date

// After (working):
start_date: new Date(newTournament.start_date).toISOString()
```

---

## 📊 Debug in Browser Console

After trying to create a tournament, check console for these messages:

### ✅ Good Messages:
```
Creating tournament with data: {...}
User ID: xxx-xxx-xxx
Tournament created successfully: {...}
```

### ❌ Bad Messages:
```
Supabase error details: {
  code: "PGRST301",
  message: "new row violates row-level security policy"
}
```
→ **Fix:** Run `fix_admin_permissions.sql`

```
Error: null value in column "created_by"
```
→ **Fix:** Make sure you're logged in

```
Error: invalid input syntax for type timestamp
```
→ **Fix:** Already fixed in updated code - refresh browser

---

## 🛠️ Manual Test (SQL Injection)

Want to test if it's a permissions issue or frontend issue?

**Try creating tournament directly in SQL:**

```sql
-- Get your user ID first
SELECT id FROM profiles WHERE email = 'rkking9921@gmail.com';

-- Replace YOUR_UUID with the ID from above
INSERT INTO tournaments (
  title, game, description, entry_fee, prize_pool, 
  max_participants, start_date, created_by, status
) VALUES (
  'SQL Test Tournament',
  'Valorant',
  'Created via SQL',
  10,
  1000,
  8,
  NOW() + INTERVAL '7 days',
  'YOUR_UUID',  -- Paste your UUID here
  'upcoming'
);
```

**If this works:** Problem is with frontend code  
**If this fails:** Problem is with database permissions

---

## ✅ Success Checklist

After running fixes, verify:

- [ ] Ran `fix_admin_permissions.sql` successfully
- [ ] Verified role is 'admin' in profiles table
- [ ] Refreshed browser page
- [ ] Logged in as rkking9921@gmail.com
- [ ] Can access /admin/dashboard without redirect
- [ ] See "+ Create Tournament" button
- [ ] Can fill out form without errors
- [ ] Tournament creates successfully
- [ ] Appears in tournament list below form

---

## 🎯 What I Updated

### Enhanced Error Handling:
✅ Better error messages showing exact problem  
✅ Detailed console logging for debugging  
✅ Specific messages for permission errors  
✅ User-friendly alerts instead of generic errors

### Fixed Data Parsing:
✅ Proper date conversion (ISO format)  
✅ Safe number parsing with defaults  
✅ Null handling for optional fields  
✅ Type safety improvements

### Added Validation:
✅ Check user is logged in before submit  
✅ Verify admin role  
✅ Select returned data to confirm creation  
✅ Success confirmation message

---

## 🆘 Still Not Working?

### Try This Sequence:

1. **Logout** from frontend
2. **Clear localStorage:**
   ```javascript
   // Browser console
   localStorage.clear();
   ```
3. **Run SQL scripts in order:**
   - `database_setup_complete.sql` (creates everything)
   - `make_admin.sql` (sets admin role)
   - `fix_admin_permissions.sql` (fixes policies)

4. **Login again**
5. **Try creating tournament**

---

## 📞 Quick Reference

### Files Created for You:
- [`fix_admin_permissions.sql`](c:\New folder\fix_admin_permissions.sql) ← **RUN THIS FIRST**
- [`make_admin.sql`](c:\New folder\make_admin.sql) ← Sets admin role
- [`database_setup_complete.sql`](c:\New folder\database_setup_complete.sql) ← Complete setup

### Supabase Links:
- Dashboard: https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq
- SQL Editor: https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq/sql/new
- Table Editor: https://supabase.com/dashboard/project/pqmyslyhkxbkrbuladhq/editor

---

**Run `fix_admin_permissions.sql` and your tournament creation will work! 🚀**
