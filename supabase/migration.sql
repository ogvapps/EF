-- ============================================================
-- EF Quest - Esquema completo de base de datos (PostgreSQL)
-- Ejecutar en Supabase Dashboard -> SQL Editor
-- ============================================================

-- 1. Extensions
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- 2. Tabla: users (auth_id = UUID de Supabase Auth)
CREATE TABLE IF NOT EXISTS public.users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  auth_id UUID UNIQUE NOT NULL,           -- Supabase Auth UID (UUID)
  email TEXT,
  display_name TEXT NOT NULL DEFAULT '',
  photo_url TEXT,
  role TEXT NOT NULL DEFAULT 'alumno' CHECK (role IN ('alumno', 'profesor')),
  course TEXT,
  "group" TEXT,
  school_year TEXT,
  xp INTEGER NOT NULL DEFAULT 0,
  level INTEGER NOT NULL DEFAULT 1,
  streak INTEGER NOT NULL DEFAULT 0,
  last_active_date TIMESTAMPTZ,
  avatar_tier TEXT NOT NULL DEFAULT 'rookie',
  avatar_config JSONB DEFAULT '{}'::jsonb,
  attributes JSONB DEFAULT '{"fuerza":0,"resistencia":0,"estrategia":0,"cooperacion":0,"salud":0,"liderazgo":0}'::jsonb,
  current_unit_id TEXT,
  completed_units TEXT[] DEFAULT '{}',
  total_lessons_completed INTEGER NOT NULL DEFAULT 0,
  total_challenges_completed INTEGER NOT NULL DEFAULT 0,
  total_minutes_active INTEGER NOT NULL DEFAULT 0,
  total_sessions INTEGER NOT NULL DEFAULT 0,
  average_daily_steps DOUBLE PRECISION NOT NULL DEFAULT 0,
  coins INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  last_login_at TIMESTAMPTZ
);

-- 3. Tabla: user_progress
CREATE TABLE IF NOT EXISTS public.user_progress (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(auth_id) ON DELETE CASCADE,
  unit_id TEXT NOT NULL,
  ref_id TEXT NOT NULL,
  ref_type TEXT NOT NULL CHECK (ref_type IN ('lesson', 'challenge', 'boss')),
  status TEXT NOT NULL DEFAULT 'available' CHECK (status IN ('available', 'completed', 'failed')),
  score DOUBLE PRECISION,
  stars INTEGER NOT NULL DEFAULT 0 CHECK (stars >= 0 AND stars <= 3),
  time_spent_sec INTEGER NOT NULL DEFAULT 0,
  attempts INTEGER NOT NULL DEFAULT 0,
  completed_at TIMESTAMPTZ,
  quiz_answers JSONB DEFAULT '[]'::jsonb,
  challenge_result JSONB,
  ai_difficulty INTEGER,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  UNIQUE(user_id, ref_id)
);
CREATE INDEX idx_user_progress_user_id ON public.user_progress(user_id);
CREATE INDEX idx_user_progress_unit_id ON public.user_progress(unit_id);
CREATE INDEX idx_user_progress_status ON public.user_progress(status);

-- 4. Tabla: user_achievements
CREATE TABLE IF NOT EXISTS public.user_achievements (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(auth_id) ON DELETE CASCADE,
  achievement_id TEXT NOT NULL,
  unlocked_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  progress INTEGER NOT NULL DEFAULT 0 CHECK (progress >= 0 AND progress <= 100),
  is_complete BOOLEAN NOT NULL DEFAULT false,
  claimed BOOLEAN NOT NULL DEFAULT false,
  UNIQUE(user_id, achievement_id)
);
CREATE INDEX idx_user_achievements_user_id ON public.user_achievements(user_id);

-- 5. Tabla: user_inventory
CREATE TABLE IF NOT EXISTS public.user_inventory (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.users(auth_id) ON DELETE CASCADE,
  item_id TEXT NOT NULL,
  acquired_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  is_equipped BOOLEAN NOT NULL DEFAULT false,
  quantity INTEGER NOT NULL DEFAULT 1,
  UNIQUE(user_id, item_id)
);
CREATE INDEX idx_user_inventory_user_id ON public.user_inventory(user_id);
CREATE INDEX idx_user_inventory_equipped ON public.user_inventory(is_equipped) WHERE is_equipped = true;

-- 6. Tabla: units
CREATE TABLE IF NOT EXISTS public.units (
  id TEXT PRIMARY KEY,
  course TEXT NOT NULL,
  trimester INTEGER NOT NULL CHECK (trimester >= 1 AND trimester <= 3),
  "order" INTEGER NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  duration_weeks INTEGER NOT NULL DEFAULT 1,
  narrative_title TEXT NOT NULL DEFAULT '',
  boss_name TEXT,
  total_xp INTEGER NOT NULL DEFAULT 0,
  required_xp INTEGER NOT NULL DEFAULT 0,
  boss_xp INTEGER NOT NULL DEFAULT 0,
  attribute_focus JSONB DEFAULT '{}'::jsonb,
  saber_basico TEXT[] DEFAULT '{}',
  competencias TEXT[] DEFAULT '{}',
  criterios_eval TEXT[] DEFAULT '{}',
  icon_url TEXT NOT NULL DEFAULT '',
  color_hex TEXT NOT NULL DEFAULT '#4CAF50',
  is_locked BOOLEAN NOT NULL DEFAULT false,
  prerequisite_unit TEXT,
  is_active BOOLEAN NOT NULL DEFAULT true,
  is_final BOOLEAN NOT NULL DEFAULT false,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_units_course ON public.units(course);
CREATE INDEX idx_units_order ON public.units("order");

-- 7. Tabla: lessons
CREATE TABLE IF NOT EXISTS public.lessons (
  id TEXT PRIMARY KEY,
  unit_id TEXT NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  "order" INTEGER NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('video', 'reading', 'quiz', 'interactive')),
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  duration_sec INTEGER NOT NULL DEFAULT 0,
  video_url TEXT,
  content_html TEXT,
  quiz_data JSONB,
  xp_reward INTEGER NOT NULL DEFAULT 0,
  attribute_rewards JSONB DEFAULT '{}'::jsonb,
  coin_reward INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_lessons_unit_id ON public.lessons(unit_id);

-- 8. Tabla: challenges
CREATE TABLE IF NOT EXISTS public.challenges (
  id TEXT PRIMARY KEY,
  unit_id TEXT NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  "order" INTEGER NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('steps', 'reps', 'timer', 'heartrate')),
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  difficulty TEXT NOT NULL DEFAULT 'medio',
  goal_type TEXT NOT NULL DEFAULT '',
  goal_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  min_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  max_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  adaptive_enabled BOOLEAN NOT NULL DEFAULT false,
  adaptive_base_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  adaptive_increment DOUBLE PRECISION NOT NULL DEFAULT 0,
  adaptive_max_value DOUBLE PRECISION NOT NULL DEFAULT 0,
  xp_reward INTEGER NOT NULL DEFAULT 0,
  xp_three_stars INTEGER NOT NULL DEFAULT 0,
  attribute_rewards JSONB DEFAULT '{}'::jsonb,
  intro_text TEXT NOT NULL DEFAULT '',
  success_text TEXT NOT NULL DEFAULT '',
  fail_text TEXT NOT NULL DEFAULT '',
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_challenges_unit_id ON public.challenges(unit_id);

-- 9. Tabla: minigames
CREATE TABLE IF NOT EXISTS public.minigames (
  id TEXT PRIMARY KEY,
  unit_id TEXT NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  "order" INTEGER NOT NULL,
  type TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  config JSONB DEFAULT '{}'::jsonb,
  levels JSONB DEFAULT '[]'::jsonb,
  xp_reward INTEGER NOT NULL DEFAULT 0,
  coin_reward INTEGER NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_minigames_unit_id ON public.minigames(unit_id);

-- 10. Tabla: boss
CREATE TABLE IF NOT EXISTS public.boss (
  id TEXT DEFAULT 'boss',
  unit_id TEXT NOT NULL REFERENCES public.units(id) ON DELETE CASCADE,
  title TEXT NOT NULL DEFAULT '',
  description TEXT NOT NULL DEFAULT '',
  xp_reward INTEGER NOT NULL DEFAULT 0,
  coin_reward INTEGER NOT NULL DEFAULT 0,
  is_final_boss BOOLEAN NOT NULL DEFAULT false,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  PRIMARY KEY (id, unit_id)
);
CREATE INDEX idx_boss_unit_id ON public.boss(unit_id);

-- 11. Tabla: classes
CREATE TABLE IF NOT EXISTS public.classes (
  id TEXT PRIMARY KEY,
  teacher_id TEXT NOT NULL,
  course TEXT NOT NULL,
  "group" TEXT NOT NULL DEFAULT '',
  school_year TEXT NOT NULL DEFAULT '',
  students TEXT[] DEFAULT '{}',
  custom_challenges JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_classes_teacher_id ON public.classes(teacher_id);

-- 12. Tabla: achievements
CREATE TABLE IF NOT EXISTS public.achievements (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  icon_url TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT '',
  rarity TEXT NOT NULL DEFAULT 'comun',
  condition JSONB DEFAULT '{}'::jsonb,
  xp_reward INTEGER NOT NULL DEFAULT 0,
  coin_reward INTEGER NOT NULL DEFAULT 0,
  attribute_reward JSONB DEFAULT '{}'::jsonb,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 13. Tabla: shop_items
CREATE TABLE IF NOT EXISTS public.shop_items (
  id TEXT PRIMARY KEY,
  type TEXT NOT NULL CHECK (type IN ('outfit', 'accessory', 'boost', 'theme')),
  name TEXT NOT NULL,
  description TEXT NOT NULL DEFAULT '',
  image_url TEXT NOT NULL DEFAULT '',
  price INTEGER NOT NULL DEFAULT 0,
  tier TEXT NOT NULL DEFAULT 'basico',
  is_limited BOOLEAN NOT NULL DEFAULT false,
  available_until TIMESTAMPTZ,
  is_active BOOLEAN NOT NULL DEFAULT true,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_shop_items_type ON public.shop_items(type);

-- 14. Enable Row Level Security (RLS)
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_inventory ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.units ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.challenges ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.minigames ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.boss ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.classes ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.shop_items ENABLE ROW LEVEL SECURITY;

-- 15. RLS Policies (auth.uid() es UUID, auth_id es UUID, comparación directa)
CREATE POLICY users_select_own ON public.users
  FOR SELECT USING (
    auth_id = auth.uid()
    OR EXISTS (SELECT 1 FROM public.users u WHERE u.auth_id = auth.uid() AND u.role = 'profesor')
    OR role = 'alumno'
  );
CREATE POLICY users_insert_own ON public.users
  FOR INSERT WITH CHECK (auth_id = auth.uid());
CREATE POLICY users_update_own ON public.users
  FOR UPDATE USING (auth_id = auth.uid()) WITH CHECK (auth_id = auth.uid());

CREATE POLICY user_progress_select ON public.user_progress
  FOR SELECT USING (user_id = auth.uid());
CREATE POLICY user_progress_insert ON public.user_progress
  FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY user_progress_update ON public.user_progress
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY user_achievements_select ON public.user_achievements
  FOR SELECT USING (user_id = auth.uid());
CREATE POLICY user_achievements_insert ON public.user_achievements
  FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY user_achievements_update ON public.user_achievements
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY user_inventory_select ON public.user_inventory
  FOR SELECT USING (user_id = auth.uid());
CREATE POLICY user_inventory_insert ON public.user_inventory
  FOR INSERT WITH CHECK (user_id = auth.uid());
CREATE POLICY user_inventory_update ON public.user_inventory
  FOR UPDATE USING (user_id = auth.uid());

CREATE POLICY units_select ON public.units FOR SELECT USING (true);
CREATE POLICY lessons_select ON public.lessons FOR SELECT USING (true);
CREATE POLICY challenges_select ON public.challenges FOR SELECT USING (true);
CREATE POLICY minigames_select ON public.minigames FOR SELECT USING (true);
CREATE POLICY boss_select ON public.boss FOR SELECT USING (true);

CREATE POLICY classes_select ON public.classes
  FOR SELECT USING (teacher_id = auth.uid()::text OR auth.uid()::text = ANY(students));
CREATE POLICY classes_insert ON public.classes
  FOR INSERT WITH CHECK (teacher_id = auth.uid()::text);
CREATE POLICY classes_update ON public.classes
  FOR UPDATE USING (teacher_id = auth.uid()::text);
CREATE POLICY classes_delete ON public.classes
  FOR DELETE USING (teacher_id = auth.uid()::text);

CREATE POLICY achievements_select ON public.achievements FOR SELECT USING (true);
CREATE POLICY shop_items_select ON public.shop_items FOR SELECT USING (true);

-- 16. Función para updated_at automático
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_users_updated_at BEFORE UPDATE ON public.users
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER set_user_progress_updated_at BEFORE UPDATE ON public.user_progress
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER set_units_updated_at BEFORE UPDATE ON public.units
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER set_classes_updated_at BEFORE UPDATE ON public.classes
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

-- 17. Función: calcular nivel basado en XP
CREATE OR REPLACE FUNCTION public.calculate_level(xp INTEGER)
RETURNS INTEGER AS $$
BEGIN
  RETURN GREATEST(1, (xp / 500) + 1);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

-- 18. Trigger: crear perfil automáticamente al registrar un usuario en auth.users
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.users (
    auth_id, email, display_name, role, course, photo_url,
    created_at, updated_at, last_active_date, last_login_at, is_active
  ) VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data ->> 'display_name', 'Usuario'),
    COALESCE(NEW.raw_user_meta_data ->> 'role', 'alumno')::TEXT,
    COALESCE(NEW.raw_user_meta_data ->> 'course', '1_eso'),
    NEW.raw_user_meta_data ->> 'avatar_url',
    NOW(), NOW(), NOW(), NOW(), true
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- 19. Función RPC: upsert perfil de usuario (para usuarios existentes sin perfil)
CREATE OR REPLACE FUNCTION public.upsert_user_profile(
  p_display_name TEXT DEFAULT NULL,
  p_role TEXT DEFAULT 'alumno',
  p_course TEXT DEFAULT '1_eso',
  p_photo_url TEXT DEFAULT NULL,
  p_email TEXT DEFAULT NULL
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  result JSONB;
  v_auth_id UUID;
BEGIN
  v_auth_id := auth.uid();
  IF v_auth_id IS NULL THEN
    RAISE EXCEPTION 'No autenticado';
  END IF;

  INSERT INTO public.users (auth_id, email, display_name, role, course, photo_url, created_at, updated_at, last_active_date, last_login_at)
  VALUES (v_auth_id, p_email, p_display_name, p_role, p_course, p_photo_url, NOW(), NOW(), NOW(), NOW())
  ON CONFLICT (auth_id) DO UPDATE SET
    email = COALESCE(p_email, users.email),
    display_name = COALESCE(p_display_name, users.display_name),
    photo_url = COALESCE(p_photo_url, users.photo_url),
    role = COALESCE(p_role::TEXT, users.role),
    course = COALESCE(p_course, users.course),
    last_login_at = NOW(),
    is_active = true,
    updated_at = NOW()
  RETURNING row_to_json(users.*) INTO result;

  RETURN result;
END;
$$;

-- 20. Función RPC: incremento atómico de XP y nivel
CREATE OR REPLACE FUNCTION public.increment_user_xp(p_amount INTEGER)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_uid UUID;
BEGIN
  v_uid := auth.uid();
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'No autenticado';
  END IF;

  UPDATE public.users
  SET
    xp = GREATEST(0, xp + p_amount),
    level = GREATEST(1, ((xp + p_amount) / 500) + 1),
    updated_at = NOW()
  WHERE auth_id = v_uid;
END;
$$;

-- 21. Función RPC: incremento atómico de monedas
CREATE OR REPLACE FUNCTION public.increment_user_coins(p_amount INTEGER)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_uid UUID;
BEGIN
  v_uid := auth.uid();
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'No autenticado';
  END IF;

  UPDATE public.users
  SET
    coins = GREATEST(0, coins + p_amount),
    updated_at = NOW()
  WHERE auth_id = v_uid;
END;
$$;

-- 22. Función RPC: compra atómica en tienda (transacción)
CREATE OR REPLACE FUNCTION public.purchase_shop_item(p_item_id TEXT)
RETURNS BOOLEAN
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_uid UUID;
  v_price INTEGER;
  v_coins INTEGER;
  v_existing UUID;
BEGIN
  v_uid := auth.uid();
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'No autenticado';
  END IF;

  -- Comprobar si ya tiene el ítem
  SELECT id INTO v_existing FROM public.user_inventory
  WHERE user_id = v_uid AND item_id = p_item_id;

  IF v_existing IS NOT NULL THEN
    RETURN FALSE;
  END IF;

  -- Obtener precio del ítem
  SELECT price INTO v_price FROM public.shop_items
  WHERE id = p_item_id AND is_active = true;

  IF v_price IS NULL THEN
    RETURN FALSE;
  END IF;

  -- Obtener monedas del usuario
  SELECT coins INTO v_coins FROM public.users
  WHERE auth_id = v_uid;

  IF v_coins IS NULL OR v_coins < v_price THEN
    RETURN FALSE;
  END IF;

  -- Deducir monedas e insertar ítem en una sola transacción
  UPDATE public.users
  SET coins = coins - v_price, updated_at = NOW()
  WHERE auth_id = v_uid;

  INSERT INTO public.user_inventory (user_id, item_id, acquired_at, is_equipped, quantity)
  VALUES (v_uid, p_item_id, NOW(), false, 1);

  RETURN TRUE;
END;
$$;

-- 23. Función RPC: eliminación segura de cuenta de usuario
CREATE OR REPLACE FUNCTION public.delete_user_account()
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_uid UUID;
BEGIN
  v_uid := auth.uid();
  IF v_uid IS NULL THEN
    RAISE EXCEPTION 'No autenticado';
  END IF;

  DELETE FROM public.users WHERE auth_id = v_uid;
  DELETE FROM auth.users WHERE id = v_uid;
END;
$$;
