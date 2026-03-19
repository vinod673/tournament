# 🎮 ArenaX Gaming - Complete Setup Guide

## ✅ STEP 1: PROJECT SETUP (COMPLETE)

### Installation Commands

```bash
# 1. Install root dependencies
cd "c:\New folder"
npm install

# 2. Install frontend dependencies
cd frontend
npm install

# 3. Install backend dependencies
cd ../backend
npm install
```

### Project Structure Created

```
arenax-gaming/
├── frontend/                    # Next.js Application
│   ├── app/                     # App Router pages
│   ├── components/              # Reusable components
│   ├── contexts/                # React contexts
│   ├── hooks/                   # Custom hooks
│   ├── lib/                     # Utilities & configs
│   │   ├── api.ts              # API client
│   │   └── supabase.ts         # Supabase client
│   ├── utils/                   # Utility functions
│   ├── public/                  # Static assets
│   ├── types/                   # TypeScript types
│   ├── .env.local               # Frontend environment
│   ├── .env.example             # Environment template
│   ├── next.config.ts           # Next.js config
│   ├── package.json             # Frontend dependencies
│   └── tsconfig.json            # TypeScript config
│
├── backend/                     # Express.js Server
│   ├── config/                  # Configuration files
│   ├── controllers/             # Route controllers
│   ├── middleware/              # Custom middleware
│   │   └── errorHandler.js      # Error handling
│   ├── models/                  # Database models
│   ├── routes/                  # API routes
│   │   └── index.js             # Main routes
│   ├── .env                     # Backend environment
│   ├── .env.example             # Environment template
│   ├── server.js                # Entry point
│   └── package.json             # Backend dependencies
│
├── database_schema.sql          # Supabase database schema
├── .env.example                 # Root environment template
└── package.json                 # Root package config
```

### Dependencies Installed

**Frontend:**
- ✅ Next.js 16 (App Router)
- ✅ React 19
- ✅ TypeScript
- ✅ Tailwind CSS v4
- ✅ Framer Motion
- ✅ Axios
- ✅ Supabase JS Client

**Backend:**
- ✅ Express.js v5
- ✅ Node.js
- ✅ Supabase JS Client
- ✅ CORS
- ✅ dotenv
- ✅ nodemon (dev)

**Root:**
- ✅ concurrently (for running both servers)

---

## 🔧 NEXT STEPS - SUPABASE CONFIGURATION

### 1. Create Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up / Log in
3. Click "New Project"
4. Fill in:
   - **Name**: arenax-gaming
   - **Database Password**: Choose a strong password
   - **Region**: Select closest to you
5. Click "Create new project"

### 2. Get API Keys

Once project is created:
1. Go to **Settings** → **API**
2. Copy these values:
   - **Project URL** → `NEXT_PUBLIC_SUPABASE_URL`
   - **anon/public key** → `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - **service_role key** → `SUPABASE_SERVICE_KEY` ⚠️ (Keep secret!)

### 3. Configure Environment Variables

**Frontend** (`frontend/.env.local`):
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_API_URL=http://localhost:5000/api
```

**Backend** (`backend/.env`):
```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_KEY=your-service-role-key
PORT=5000
NODE_ENV=development
```

### 4. Setup Database Schema

1. Go to your Supabase project dashboard
2. Navigate to **SQL Editor**
3. Click **"New Query"**
4. Copy entire content from `database_schema.sql`
5. Paste and click **"Run"**
6. Verify tables are created:
   - ✅ profiles
   - ✅ tournaments
   - ✅ tournament_participants

### 5. Enable Authentication

In Supabase Dashboard:
1. Go to **Authentication** → **Providers**
2. Enable **Email** provider
3. Configure email templates (optional)
4. Set site URL to: `http://localhost:3000`
5. Add redirect URLs:
   - `http://localhost:3000/auth/callback`
   - `http://localhost:3000/dashboard`

---

## 🚀 RUNNING THE APPLICATION

### Option 1: Run Both Together (Recommended)

From root directory:
```bash
npm run dev
```

This runs both frontend (port 3000) and backend (port 5000) concurrently.

### Option 2: Run Separately

**Terminal 1 - Frontend:**
```bash
cd frontend
npm run dev
```

**Terminal 2 - Backend:**
```bash
cd backend
npm run dev
```

### Verify Setup

1. **Frontend**: Open http://localhost:3000
   - Should see homepage (once we build it in Step 2)
   
2. **Backend**: Open http://localhost:5000/api/health
   - Should return: `{"status": "OK", "message": "ArenaX Gaming API is running"}`

---

## 📋 CHECKLIST - Step 1 Complete

- ✅ Next.js app with Tailwind CSS configured
- ✅ Express.js backend setup
- ✅ Supabase client configured (frontend & backend)
- ✅ Folder structure created
- ✅ Dependencies installed
- ✅ Environment variable templates created
- ✅ Database schema ready
- ✅ Basic server configuration complete

---

## 🎨 DESIGN TOKENS (White + Yellow Theme)

**Colors:**
- Primary Background: `#FFFFFF` (White)
- Secondary Background: `#F9FAFB` (Light Gray)
- Primary Accent: `#FCD34D` (Yellow)
- Secondary Accent: `#FBBF24` (Dark Yellow)
- Text Primary: `#171717` (Near Black)
- Text Secondary: `#6B7280` (Gray)

**Fonts:**
- Sans-serif: System fonts (Arial fallback)
- Mono: System fonts

---

## 🔒 SECURITY NOTES

1. Never commit `.env` files to Git
2. Keep `SUPABASE_SERVICE_KEY` secret (backend only)
3. Use `NEXT_PUBLIC_SUPABASE_ANON_KEY` for frontend (safe to expose)
4. Enable Row Level Security (RLS) in Supabase (already in schema)
5. Validate all inputs on backend

---

## 📝 TROUBLESHOOTING

**Port already in use?**
```bash
# Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F

# Change port in package.json if needed
```

**Supabase connection issues?**
- Check URLs have `https://` not `http://`
- Verify keys are correct (no extra spaces)
- Ensure RLS policies are set up correctly

**Build errors?**
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install
```

---

## ➡️ READY FOR STEP 2

Once you have:
- ✅ All dependencies installed
- ✅ Supabase project created
- ✅ Environment variables configured
- ✅ Database schema deployed

You're ready to proceed to **STEP 2: HOME PAGE UI/UX**!
