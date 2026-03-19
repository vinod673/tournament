# ⚡ Quick Reference Checklist

## ✅ BEFORE STEP 2 - MUST COMPLETE THESE

### 1. Supabase Setup (5-10 minutes)
```bash
□ Create account at https://supabase.com
□ Create new project: "arenax-gaming"
□ Save database password securely
□ Wait for project to finish setup (2 min)
```

### 2. Get API Keys (2 minutes)
```bash
□ Go to Settings → API in Supabase
□ Copy Project URL
□ Copy anon/public key
□ Copy service_role key (keep secret!)
```

### 3. Configure Environment Variables (3 minutes)

**Edit `frontend/.env.local`:**
```bash
□ Replace: NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
□ Replace: NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key-here
□ Keep: NEXT_PUBLIC_API_URL=http://localhost:5000/api
```

**Edit `backend/.env`:**
```bash
□ Replace: SUPABASE_URL=https://your-project.supabase.co
□ Replace: SUPABASE_ANON_KEY=your-anon-key-here
□ Replace: SUPABASE_SERVICE_KEY=your-service-role-key-here
□ Keep: PORT=5000
□ Keep: NODE_ENV=development
```

### 4. Deploy Database Schema (5 minutes)
```bash
□ Open Supabase Dashboard
□ Navigate to SQL Editor
□ Click "New Query"
□ Open file: database_schema.sql
□ Copy ALL content (Ctrl+A, Ctrl+C)
□ Paste into SQL Editor (Ctrl+V)
□ Click "Run"
□ Verify: "Success. No rows returned"
□ Check tables exist: profiles, tournaments, tournament_participants
```

### 5. Configure Authentication (2 minutes)
```bash
□ Go to Authentication → Providers
□ Enable Email provider
□ Set Site URL: http://localhost:3000
□ Add redirect URL: http://localhost:3000/auth/callback
□ Save changes
```

### 6. Test the Setup (2 minutes)
```bash
□ Open terminal in root folder
□ Run: npm run dev
□ Wait for both servers to start
□ Frontend: http://localhost:3000 (should show Next.js default)
□ Backend: http://localhost:5000/api/health (should show JSON)
□ No errors in console
```

---

## 🎯 ALL CONFIGURED? 

### ✅ If everything works:
**Say: "Proceed to Step 2"**

I'll then build the complete homepage with:
- Modern navbar
- Animated hero section
- Tournament cards
- How it works section
- Footer
- Framer Motion animations
- Responsive design

---

## 🆨 Quick Troubleshooting

### Error: Invalid supabaseUrl
```
✓ Make sure URL starts with https://
✓ No trailing slash at the end
✓ Should look like: https://xxxxx.supabase.co
```

### Port 3000 already in use
```powershell
netstat -ano | findstr :3000
taskkill /PID <NUMBER> /F
```

### Module not found
```bash
cd frontend
npm install

cd ../backend
npm install
```

### Database tables not showing
```
✓ Refresh Supabase dashboard page
✓ Check SQL ran without red errors
✓ Re-run the SQL script if needed
```

### Can't run both servers
```bash
# Try running separately:
# Terminal 1
cd frontend && npm run dev

# Terminal 2
cd backend && npm run dev
```

---

## 📋 File Locations Quick Reference

| File | Purpose | Location |
|------|---------|----------|
| Frontend Env | Supabase + API config | `frontend/.env.local` |
| Backend Env | Supabase + Port config | `backend/.env` |
| Database Schema | SQL for tables | `database_schema.sql` |
| Main Server | Express entry | `backend/server.js` |
| Home Page | Landing page | `frontend/app/page.tsx` |
| Global Styles | CSS + Tailwind | `frontend/app/globals.css` |

---

## 🎮 Development Commands

```bash
# Start both servers together
npm run dev

# Start frontend only
cd frontend && npm run dev

# Start backend only
cd backend && npm run dev

# Install dependencies
npm run install:all

# Build frontend
cd frontend && npm run build

# Lint frontend
cd frontend && npm run lint
```

---

## 📞 Documentation Files

| File | Description |
|------|-------------|
| `README.md` | Main project documentation |
| `QUICKSTART.md` | Quick start instructions |
| `SETUP_STEP1.md` | Detailed Step 1 guide |
| `STEP1_SUMMARY.md` | Step 1 completion summary |
| `PROJECT_OVERVIEW.md` | Complete architecture overview |
| `CHECKLIST.md` | This file |

---

**Last Updated:** Step 1 Complete  
**Next Step:** Home Page UI/UX (Step 2)
