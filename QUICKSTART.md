# 🚀 Quick Start Guide - ArenaX Gaming

## ⚡ STEP 1 COMPLETE!

Your project is now fully set up and ready for development.

---

## 📋 What's Been Done

✅ **Project Structure Created**
- Frontend: Next.js + Tailwind CSS + TypeScript
- Backend: Express.js + Supabase
- Proper folder organization

✅ **Dependencies Installed**
- All npm packages installed
- Framer Motion ready for animations
- Supabase client configured

✅ **Configuration Files Ready**
- Environment variable templates
- Database schema
- Server configuration

---

## 🔧 What You Need to Do NOW

### 1. Create Your Supabase Account (5 minutes)

1. Visit [https://supabase.com](https://supabase.com)
2. Sign up for free
3. Click **"New Project"**
4. Fill in:
   - Name: `arenax-gaming`
   - Password: (save it!)
   - Region: Choose closest
5. Wait 1-2 minutes for setup

### 2. Get Your API Keys (2 minutes)

In Supabase Dashboard:
1. Go to **Settings** (⚙️) → **API**
2. Copy these 3 values:
   ```
   Project URL: https://xxxxx.supabase.co
   anon/public key: eyJhbG...
   service_role key: eyJhbG... (keep secret!)
   ```

### 3. Configure Environment Variables (2 minutes)

**Edit `frontend/.env.local`:**
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
NEXT_PUBLIC_API_URL=http://localhost:5000/api
```

**Edit `backend/.env`:**
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_KEY=your-service-role-key-here
PORT=5000
NODE_ENV=development
```

### 4. Setup Database (3 minutes)

1. In Supabase Dashboard, go to **SQL Editor**
2. Click **"New Query"**
3. Open `database_schema.sql` from project root
4. Copy ALL content
5. Paste into SQL Editor
6. Click **"Run"**
7. Verify: You should see "Success. No rows returned"

### 5. Enable Email Auth (1 minute)

1. Go to **Authentication** → **Providers**
2. Enable **Email**
3. Set Site URL: `http://localhost:3000`
4. Add Redirect URL: `http://localhost:3000/auth/callback`
5. Save

---

## ▶️ START THE APP

### Option 1: Run Both Together (Recommended)

From root folder:
```bash
npm run dev
```

This starts:
- Frontend: http://localhost:3000
- Backend: http://localhost:5000

### Option 2: Run Separately

**Terminal 1:**
```bash
cd frontend
npm run dev
```

**Terminal 2:**
```bash
cd backend
npm run dev
```

---

## ✅ VERIFY SETUP

1. **Check Backend**: 
   - Open: http://localhost:5000/api/health
   - Should show: `{"status": "OK", ...}`

2. **Check Frontend**:
   - Open: http://localhost:3000
   - Currently shows default Next.js page
   - We'll build the homepage in Step 2!

---

## 🎯 NEXT STEPS

Once everything is working:

➡️ **Proceed to STEP 2: HOME PAGE UI/UX**
- Modern esports landing page
- Navbar with logo
- Hero section with animations
- Featured tournaments
- How it works section
- Footer

---

## 🆘 Troubleshooting

**Error: Invalid supabaseUrl**
- Make sure URL starts with `https://`
- Check for typos
- No trailing slash

**Port 3000 already in use?**
```bash
netstat -ano | findstr :3000
taskkill /PID <PID_NUMBER> /F
```

**Can't find module?**
```bash
cd frontend
npm install

cd ../backend
npm install
```

**Database tables not showing?**
- Refresh Supabase dashboard
- Check SQL ran without errors
- Look for red error messages

---

## 📞 Need Help?

Common issues and solutions in `SETUP_STEP1.md`

---

**Ready? Let's build an amazing esports platform! 🎮✨**
