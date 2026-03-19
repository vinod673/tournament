-- Quick Fix Script for Tournament Participants Table
-- Run this in Supabase SQL Editor if you're experiencing issues

-- Check if tournament_participants table exists
SELECT EXISTS (
  SELECT FROM information_schema.tables 
  WHERE table_schema = 'public' 
  AND table_name = 'tournament_participants'
) as table_exists;

-- If table doesn't exist, create it:
/*
CREATE TABLE IF NOT EXISTS public.tournament_participants (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  tournament_id UUID REFERENCES public.tournaments(id) ON DELETE CASCADE NOT NULL,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  joined_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'eliminated', 'winner')),
  UNIQUE(tournament_id, user_id)
);

-- Create index for better performance
CREATE INDEX IF NOT EXISTS idx_tournament_participants_user ON public.tournament_participants(user_id);
CREATE INDEX IF NOT EXISTS idx_tournament_participants_tournament ON public.tournament_participants(tournament_id);

-- Enable RLS
ALTER TABLE public.tournament_participants ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist and recreate
DROP POLICY IF EXISTS "Participants are viewable by everyone" ON public.tournament_participants;
DROP POLICY IF EXISTS "Authenticated users can join tournaments" ON public.tournament_participants;

-- Create policies
CREATE POLICY "Participants are viewable by everyone"
  ON public.tournament_participants FOR SELECT
  USING (true);

CREATE POLICY "Authenticated users can join tournaments"
  ON public.tournament_participants FOR INSERT
  WITH CHECK (
    auth.uid() = user_id AND
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid()
    )
  );
*/
