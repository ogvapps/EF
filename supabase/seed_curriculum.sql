-- ============================================================
-- EF Quest - Seed completo del curriculum ESO (LOMLOE)
-- 4 cursos x 3 trimestres x 5 unidades = 60 unidades
-- Basado en las programaciones del Colegio Madre Matilde (Plasencia)
-- ============================================================

-- Eliminar datos existentes para reinsercion limpia
DELETE FROM user_progress;
DELETE FROM user_achievements;
DELETE FROM user_inventory;
DELETE FROM boss;
DELETE FROM challenges;
DELETE FROM lessons;
DELETE FROM units;
DELETE FROM achievements;
DELETE FROM shop_items;

-- ============================================================
-- UNIDADES DIDACTICAS - 1o ESO (Tema: El Despertar del Heroe)
-- ============================================================

INSERT INTO units (id, course, trimester, "order", title, subtitle, description, duration_weeks, narrative_title, boss_name, total_xp, required_xp, boss_xp, attribute_focus, saber_basico, competencias, criterios_eval, icon_url, color_hex, is_final, is_active, created_at, updated_at) VALUES

-- 1o ESO - Trimestre 1 (11 semanas, 22 sesiones)
('1eso_t1_u1', '1_eso', 1, 1,
'Entreno mi cuerpo, cuido mi salud',
'Calentamiento y habitos saludables',
'Aprenderas la importancia del calentamiento y las rutinas saludables para prevenir lesiones y mejorar tu rendimiento. Descubriras como preparar tu cuerpo antes de cualquier actividad fisica.',
2,
'El Despertar del Heroe',
'El Guardian del Calentamiento',
500, 300, 150,
'{"fuerza": 1, "resistencia": 1, "salud": 3, "estrategia": 1, "cooperacion": 1, "liderazgo": 0}',
'{"Vida activa y saludable: calentamiento general y habitos", "Organizacion y gestion: rutinas de activacion", "Autorregulacion emocional: escucha corporal y prevencion"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia en conciencia y expresion cultural"}',
'{"Realiza un calentamiento general con autonomia", "Reconoce la importancia del calentamiento para la salud", "Identifica habitos saludables relacionados con la actividad fisica"}',
'directions_run', '#7C4DFF', false, true, NOW(), NOW()),

('1eso_t1_u2', '1_eso', 1, 2,
'Conozco mi maquina: aparato locomotor',
'Huesos, musculos y articulaciones',
'Descubriras como funciona tu cuerpo por dentro: los huesos que te sostienen, los musculos que te mueven y las articulaciones que te permiten flexionarte. Aprenderas a identificar las partes principales de tu aparato locomotor.',
2,
'El Templo del Cuerpo',
'El Esqueleto Viviente',
500, 300, 150,
'{"fuerza": 2, "resistencia": 1, "salud": 2, "estrategia": 1, "cooperacion": 0, "liderazgo": 0}',
'{"Vida activa y saludable: reconocimiento del propio cuerpo", "Resolucion de problemas: adaptacion de movimientos", "Organizacion y gestion: postura correcta y alineacion corporal"}',
'{"Competencia matematica y en ciencia", "Competencia personal, social y de aprender a aprender"}',
'{"Localiza los principales huesos y musculos del cuerpo", "Relaciona cada estructura con su funcion en el movimiento", "Adopta posturas correctas durante la actividad fisica"}',
'accessibility_new', '#00D4FF', false, true, NOW(), NOW()),

('1eso_t1_u3', '1_eso', 1, 3,
'Desafio de resistencia y velocidad',
'Capacidades fisicas basicas I',
'Pon a prueba tu resistencia y velocidad a traves de juegos y circuitos. Aprenderas a medir tu esfuerzo, controlar tu respiracion y superar tus propias marcas.',
2,
'La Pista de los Records',
'El Cronometrador Implacable',
550, 350, 180,
'{"fuerza": 1, "resistencia": 3, "salud": 2, "estrategia": 1, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: carreras y juegos de velocidad", "Vida activa: medicion del esfuerzo y recuperacion", "Autorregulacion emocional: superacion y tolerancia a la fatiga"}',
'{"Competencia matematica y en ciencia", "Competencia personal, social y de aprender a aprender"}',
'{"Mantiene una carrera continua durante al menos 5 minutos", "Mejora su tiempo en pruebas de velocidad", "Registra y valora su progreso fisico personal"}',
'sprint', '#FF6B9D', false, true, NOW(), NOW()),

('1eso_t1_u4', '1_eso', 1, 4,
'Fuerza y flexibilidad en accion',
'Capacidades fisicas basicas II',
'Desarrolla tu fuerza y flexibilidad a traves de ejercicios y juegos. Aprenderas a fortalecer tu cuerpo y a ganar amplitud de movimiento de forma segura y divertida.',
2,
'El Bosque de los Estiramientos',
'El Arbol de la Flexibilidad',
550, 350, 180,
'{"fuerza": 3, "resistencia": 1, "salud": 2, "estrategia": 1, "cooperacion": 1, "liderazgo": 0}',
'{"Resolucion de problemas: circuitos de fuerza y flexibilidad", "Vida activa: tonificacion y elasticidad muscular", "Organizacion y gestion: ejecucion segura de ejercicios"}',
'{"Competencia matematica y en ciencia", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta ejercicios basicos de fuerza con tecnica correcta", "Mejora su amplitud en ejercicios de flexibilidad", "Reconoce la importancia de la fuerza y flexibilidad para la salud"}',
'fitness_center', '#00E676', false, true, NOW(), NOW()),

('1eso_t1_u5', '1_eso', 1, 5,
'Jugamos como antes: juegos tradicionales',
'Juegos populares y cooperativos',
'Exploraras juegos populares y tradicionales de Extremadura mientras aprendes a trabajar en equipo. Desarrollaras habilidades sociales basicas a traves del juego limpio y la cooperacion.',
3,
'La Alianza de los Juglares',
'El Dragon del Juego Sucio',
600, 350, 200,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: juegos y actividades cooperativas", "Autorregulacion emocional: respeto de normas y turnos", "Manifestaciones culturales: juegos tradicionales extremenos"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Participa activamente en juegos cooperativos respetando las normas", "Valora el juego limpio como herramienta de convivencia", "Conoce y practica juegos tradicionales de su entorno"}',
'groups', '#FF9800', false, true, NOW(), NOW()),

-- 1o ESO - Trimestre 2 (10 semanas, 20 sesiones)
('1eso_t2_u1', '1_eso', 2, 1,
'Gimnastas en accion',
'Habilidades gimnasticas basicas',
'Aprenderas habilidades gimnasticas basicas: volteos, equilibrios y apoyos. Desarrollaras tu coordinacion, confianza y seguridad a traves de retos individuales y en pareja.',
2,
'El Gimnasio Encantado',
'El Acrobata Invisible',
500, 300, 150,
'{"fuerza": 2, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: habilidades gimnasticas elementales", "Autorregulacion emocional: confianza y superacion de miedos", "Organizacion y gestion: seguridad y ayuda entre companeros"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia en conciencia y expresion cultural"}',
'{"Realiza giros y equilibrios basicos con control", "Coopera en la ayuda y seguridad de sus companeros", "Supera retos gimnasticos individuales con confianza"}',
'accessibility_new', '#E040FB', false, true, NOW(), NOW()),

('1eso_t2_u2', '1_eso', 2, 2,
'Bailamos juntos: expresion y ritmo',
'Expresion corporal y coreografias',
'Descubriras como tu cuerpo puede expresar emociones, ideas y sentimientos a traves del ritmo y la musica. Crearas coreografias grupales y aprenderas a coordinarte con tus companeros.',
2,
'El Teatro de las Emociones',
'La Sombra Silenciosa',
500, 300, 150,
'{"fuerza": 0, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 3}',
'{"Manifestaciones culturales: expresion corporal y danza", "Autorregulacion emocional: control escenico y superacion de verguenza", "Interaccion social: creacion artistica colectiva"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Utiliza el cuerpo como medio de expresion y comunicacion", "Participa en coreografias grupales mostrando creatividad", "Coordina sus movimientos con el ritmo musical"}',
'face', '#FF6B9D', false, true, NOW(), NOW()),

('1eso_t2_u3', '1_eso', 2, 3,
'Socorristas en accion: primeros auxilios',
'Conducta PAS y emergencias',
'Aprenderas la conducta PAS (Proteger, Avisar, Socorrer) y las actuaciones basicas ante accidentes. Te convertiras en un pequeno heroe capaz de ayudar en emergencias.',
2,
'La Base de los Heroes',
'El Guardian de la Seguridad',
450, 250, 130,
'{"fuerza": 0, "resistencia": 0, "salud": 3, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Vida activa y saludable: seguridad y autoproteccion", "Autorregulacion emocional: control en situaciones de emergencia", "Interaccion social: responsabilidad y ayuda a los demas"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Identifica los pasos de la conducta PAS", "Participa en simulaciones de accidentes con responsabilidad", "Aplica medidas basicas de seguridad en la actividad fisica"}',
'local_hospital', '#00E676', false, true, NOW(), NOW()),

('1eso_t2_u4', '1_eso', 2, 4,
'Deportes de equipo: jugamos todos',
'Iniciacion a deportes colectivos',
'Descubriras los fundamentos basicos de deportes colectivos como baloncesto, futbol sala y voleibol. Aprenderas a pasar, recibir, lanzar y jugar en equipo con reglas adaptadas.',
2,
'La Arena de los Equipos',
'El Titan de las Reglas',
550, 350, 180,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 2}',
'{"Resolucion de problemas: fundamentos tacticos colectivos", "Autorregulacion: aceptacion del resultado deportivo", "Interaccion social: trabajo en equipo y roles"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Aplica gestos tecnicos basicos en situaciones de juego", "Respeta las reglas basicas de los deportes trabajados", "Participa activamente mostrando actitud deportiva"}',
'sports_volleyball', '#00D4FF', false, true, NOW(), NOW()),

('1eso_t2_u5', '1_eso', 2, 5,
'Jugamos en equipo: torneo deportivo',
'Deportes colectivos y competicion',
'Aplica lo aprendido en un mini-torneo de deportes colectivos. Desarrollaras estrategias simples, comunicacion en equipo y espiritu deportivo mientras compites de forma saludable.',
2,
'El Torneo de los Elementos',
'El Estratega del Balon',
550, 350, 180,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 2}',
'{"Resolucion de problemas: estrategias de juego en equipo", "Autorregulacion: gestion emocional en competicion", "Interaccion social: comunicacion y roles en equipo"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Aplica estrategias basicas en situaciones de juego real", "Respeta a companeros, rivales y decisiones arbitrales", "Asume diferentes roles dentro del equipo deportivo"}',
'sports_handball', '#FF9800', false, true, NOW(), NOW()),

-- 1o ESO - Trimestre 3 (10 semanas, 20 sesiones)
('1eso_t3_u1', '1_eso', 3, 1,
'Deportes alternativos: jugamos diferente',
'Ultimate, colpbol y datchball',
'Descubriras deportes alternativos que fomentan la participacion, la inclusion y la cooperacion. Aprenderas nuevas formas de jugar donde todos tienen un papel importante.',
2,
'El Mundo de los Nuevos Juegos',
'El Inventor de Deportes',
500, 300, 150,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 1}',
'{"Resolucion de problemas: deportes alternativos y creativos", "Interaccion social: inclusion y participacion activa", "Manifestaciones culturales: nuevas tendencias deportivas"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Se adapta a las normas de deportes alternativos", "Participa activamente fomentando la inclusion de todos", "Muestra iniciativa y creatividad en el juego"}',
'sports_kabaddi', '#4CAF50', false, true, NOW(), NOW()),

('1eso_t3_u2', '1_eso', 3, 2,
'Badminton en accion',
'Iniciacion al deporte de raqueta',
'Descubriras el badminton, un divertido deporte de raqueta. Aprenderas los golpeos basicos, el saque y los desplazamientos en la pista mientras desarrollas tu punteria y reflejos.',
2,
'El Volante Magico',
'El Saque Imparable',
500, 300, 150,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: deportes de raqueta y anticipacion", "Vida activa: mejora de reflejos y agilidad", "Autorregulacion: gestion emocional en la competicion individual"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Ejecuta los gestos basicos de badminton con correccion", "Participa en mini-partidos aplicando las reglas", "Muestra esfuerzo y actitud positiva en el aprendizaje"}',
'sports_tennis', '#00D4FF', false, true, NOW(), NOW()),

('1eso_t3_u3', '1_eso', 3, 3,
'Orientacion: me muevo y me ubico',
'Iniciacion a la orientacion',
'Aprenderas a orientarte usando mapas sencillos, puntos de referencia y pistas. Descubriras como moverte con seguridad en diferentes espacios mientras trabajas en equipo.',
2,
'El Mapa del Tesoro',
'El Guardian del Norte',
500, 300, 150,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Interaccion con el entorno: orientacion y mapas", "Resolucion de problemas: busqueda de puntos y rutas", "Vida activa: desplazamientos activos y sostenibles"}',
'{"Competencia matematica (orientacion espacial)", "Competencia personal, social y de aprender a aprender"}',
'{"Utiliza mapas sencillos para encontrar puntos de control", "Coopera en actividades de orientacion en equipo", "Respeta las normas de seguridad en los desplazamientos"}',
'explore', '#FF9800', false, true, NOW(), NOW()),

('1eso_t3_u4', '1_eso', 3, 4,
'Aventura en la naturaleza',
'Senderismo y medio natural',
'Te iniciaras en actividades en el medio natural: senderismo, juegos en la naturaleza y cuidado del entorno. Aprenderas a respetar y disfrutar del medio ambiente mientras te mueves.',
2,
'El Bosque Encantado',
'El Espiritu del Bosque',
550, 350, 200,
'{"fuerza": 1, "resistencia": 2, "salud": 2, "estrategia": 1, "cooperacion": 1, "liderazgo": 1}',
'{"Interaccion con el entorno: actividades en la naturaleza", "Vida activa: desplazamientos y habitos sostenibles", "Organizacion: preparacion de salidas y material basico"}',
'{"Competencia matematica (orientacion espacial)", "Competencia personal, social y de aprender a aprender"}',
'{"Realiza desplazamientos en la naturaleza de forma segura", "Respeta y cuida el medio ambiente durante las actividades", "Participa activamente en juegos y dinamicas naturales"}',
'terrain', '#4CAF50', false, true, NOW(), NOW()),

('1eso_t3_u5', '1_eso', 3, 5,
'Fiesta deportiva de fin de curso',
'Jornada ludico-deportiva',
'Organizaras y participaras en una mini-jornada deportiva con juegos alternativos, badminton y actividades recreativas. Celebraras todo lo aprendido durante el curso.',
2,
'La Fiesta del Heroe',
'El Maestro de Ceremonias',
600, 350, 200,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 3}',
'{"Organizacion: gestion de eventos deportivos escolares", "Interaccion social: participacion y cooperacion", "Autorregulacion: actitud de respeto y disfrute colectivo"}',
'{"Competencia ciudadana", "Competencia emprendedora"}',
'{"Propone y organiza actividades para la jornada deportiva", "Participa de forma activa respetando normas y companeros", "Demuestra actitud de cooperacion y deportividad"}',
'celebration', '#FFD700', false, true, NOW(), NOW()),

-- ============================================================
-- UNIDADES DIDACTICAS - 2o ESO (Tema: La Forja del Guerrero)
-- ============================================================

-- 2o ESO - Trimestre 1 (11 semanas, 22 sesiones)
('2eso_t1_u1', '2_eso', 1, 1,
'Caliento para rendir y prevenir',
'Calentamiento general y especifico',
'Aprenderas a disenar y realizar calentamientos generales y especificos segun la actividad. Comprenderas la importancia del calentamiento para el rendimiento y la prevencion de lesiones.',
2,
'La Forja del Guerrero',
'El Maestro del Fuego',
550, 350, 180,
'{"fuerza": 1, "resistencia": 1, "salud": 3, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Vida activa y saludable: fases y tipos de calentamiento", "Organizacion y gestion: diseno de calentamientos especificos", "Autorregulacion: relacion calentamiento-rendimiento-salud"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia matematica y en ciencia"}',
'{"Realiza calentamientos completos (general + especifico)", "Explica la utilidad del calentamiento en la practica fisica", "Disena un calentamiento adaptado a un deporte concreto"}',
'sync', '#7C4DFF', false, true, NOW(), NOW()),

('2eso_t1_u2', '2_eso', 1, 2,
'El cuerpo en movimiento',
'Aparato locomotor funcional',
'Profundizaras en el conocimiento del aparato locomotor, relacionando huesos y musculos con la practica deportiva. Aprenderas a identificar que musculos trabajan en cada movimiento.',
2,
'El Motor Interior',
'El Pulso de Acero',
550, 350, 180,
'{"fuerza": 2, "resistencia": 1, "salud": 2, "estrategia": 1, "cooperacion": 0, "liderazgo": 0}',
'{"Vida activa y saludable: anatomia funcional basica", "Resolucion de problemas: identificacion muscular en acciones deportivas", "Organizacion: registro de datos corporales"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Localiza los principales musculos y huesos en accion", "Relaciona la funcion muscular con movimientos especificos", "Reconoce la importancia del aparato locomotor en el deporte"}',
'favorite', '#00D4FF', false, true, NOW(), NOW()),

('2eso_t1_u3', '2_eso', 1, 3,
'Mi reto fisico: mejoro mis capacidades',
'Capacidades fisicas basicas',
'Evaluaras y entrenaras tus capacidades fisicas basicas (resistencia, velocidad, fuerza, flexibilidad) con tests y circuitos. Registraras tu progreso y te marcara metas personales.',
3,
'El Templo de las Marcas',
'El Cronometrador de Almas',
650, 400, 220,
'{"fuerza": 2, "resistencia": 3, "salud": 2, "estrategia": 1, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: metodos de entrenamiento basicos", "Vida activa: tests de condicion fisica y registro", "Autorregulacion: percepcion del esfuerzo y dosificacion"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Mejora su ejecucion en pruebas fisicas basicas", "Registra y analiza su progreso personal", "Participa con constancia y esfuerzo en las actividades"}',
'trending_up', '#E040FB', false, true, NOW(), NOW()),

('2eso_t1_u4', '2_eso', 1, 4,
'Nuevos horizontes: deportes alternativos I',
'Frisbee, colpbol y datchball',
'Descubriras deportes alternativos como ultimate frisbee, colpbol y datchball. Fomentaras la inclusion, la cooperacion y el disfrute mientras aprendes nuevas formas de jugar.',
2,
'El Horizonte Deportivo',
'El Pionero del Juego',
550, 350, 180,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: normas de deportes alternativos", "Interaccion social: inclusion y participacion activa", "Manifestaciones culturales: nuevas tendencias deportivas"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Se adapta a las normas de deportes alternativos", "Participa con actitud de cooperacion y respeto", "Valora la diversidad en las practicas deportivas"}',
'public', '#FF6B9D', false, true, NOW(), NOW()),

('2eso_t1_u5', '2_eso', 1, 5,
'Jugamos diferente: deportes alternativos II',
'Creacion de juegos y torneos alternativos',
'Crearas tus propios juegos alternativos en grupo, disenando reglamentos y organizando torneos. Desarrollaras la creatividad, el trabajo en equipo y el respeto por normas diversas.',
2,
'La Fabrica de Juegos',
'El Creador de Reglas',
600, 350, 200,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 3}',
'{"Resolucion de problemas: diseno de juegos y reglamentos", "Organizacion: gestion de torneos alternativos", "Interaccion social: liderazgo y creatividad colectiva"}',
'{"Competencia emprendedora", "Competencia ciudadana"}',
'{"Crea un juego alternativo con reglamento propio", "Organiza y participa en torneos con actitud deportiva", "Respeta las normas creadas por otros grupos"}',
'sports_esports', '#00E676', false, true, NOW(), NOW()),

-- 2o ESO - Trimestre 2 (10 semanas, 20 sesiones)
('2eso_t2_u1', '2_eso', 2, 1,
'Gimnastas en accion II',
'Habilidades gimnasticas avanzadas',
'Ampliaras tus destrezas gimnasticas con equilibrios, giros y apoyos mas complejos. Trabajaras la seguridad y la ayuda mutua mientras superas nuevos retos.',
2,
'El Circo de las Maravillas',
'El Equilibrista del Abismo',
550, 350, 180,
'{"fuerza": 2, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: habilidades gimnasticas combinadas", "Autorregulacion: confianza y superacion", "Interaccion social: seguridad y ayuda entre companeros"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia en conciencia y expresion cultural"}',
'{"Realiza secuencias basicas en el suelo con control", "Coopera en la ayuda y seguridad de sus companeros", "Combina volteos, equilibrios y apoyos en secuencias"}',
'accessibility_new', '#E040FB', false, true, NOW(), NOW()),

('2eso_t2_u2', '2_eso', 2, 2,
'Construimos juntos: acrosport',
'Figuras, piramides y portes',
'Descubriras el acrosport: figuras humanas, piramides y portes. Desarrollaras la fuerza, el equilibrio, la confianza y el trabajo en equipo a traves de la construccion colectiva.',
2,
'La Torre Humana',
'El Coloso de Fuerza',
550, 350, 180,
'{"fuerza": 3, "resistencia": 1, "salud": 2, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Manifestaciones culturales: acrosport y expresion artistica", "Resolucion de problemas: construccion de figuras colectivas", "Autorregulacion: confianza y superacion de miedos"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Construye figuras de acrosport con seguridad y tecnica", "Colabora activamente en la creacion de composiciones grupales", "Muestra confianza en sus companeros durante los portes"}',
'accessibility_new', '#FF9800', false, true, NOW(), NOW()),

('2eso_t2_u3', '2_eso', 2, 3,
'Bailes del mundo',
'Danzas tradicionales y modernas',
'Aprenderas pasos basicos de bailes modernos y tradicionales de diferentes culturas. Crearas coreografias en grupo y descubriras el baile como forma de expresion y convivencia.',
2,
'La Vuelta al Mundo en 20 Bailes',
'El Ritmo del Mundo',
500, 300, 150,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 3}',
'{"Manifestaciones culturales: danzas multiculturales", "Vida activa: coordinacion y ritmo", "Autorregulacion: expresion emocional a traves del movimiento"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Integra ritmo, coordinacion y expresion en los bailes", "Coopera en la construccion de coreografias grupales", "Respeta y valora las danzas de diferentes culturas"}',
'music_note', '#FF6B9D', false, true, NOW(), NOW()),

('2eso_t2_u4', '2_eso', 2, 4,
'Salvando vidas: primeros auxilios',
'Conducta PAS y vendajes basicos',
'Profundizaras en la conducta PAS (Proteger, Avisar, Socorrer) y practicaras actuaciones basicas ante accidentes: vendajes, posicion lateral de seguridad y atencion a heridas leves.',
2,
'La Clinica del Heroe',
'El Angel Guardian',
500, 300, 150,
'{"fuerza": 0, "resistencia": 0, "salud": 3, "estrategia": 2, "cooperacion": 2, "liderazgo": 2}',
'{"Vida activa y saludable: primeros auxilios basicos", "Autorregulacion: control en emergencias", "Interaccion social: responsabilidad ciudadana"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Identifica y aplica los pasos de la conducta PAS", "Ejecuta correctamente vendajes basicos y posicion lateral", "Participa en simulaciones con responsabilidad"}',
'local_hospital', '#00E676', false, true, NOW(), NOW()),

('2eso_t2_u5', '2_eso', 2, 5,
'Deportes colectivos: mas alla del juego',
'Baloncesto, futbol sala y voleibol',
'Profundizaras en deportes colectivos con mayor exigencia tecnica y tactica. Aprenderas sistemas de juego basicos, transiciones y comunicacion en equipo.',
2,
'La Arena de los Equipos II',
'El Estratega de Cinco Anillos',
650, 400, 220,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 3, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: fundamentos tacticos colectivos", "Autorregulacion: gestion de la competicion", "Interaccion social: roles y comunicacion en equipo"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Aplica fundamentos tacticos basicos en deportes de equipo", "Se comunica eficazmente con sus companeros durante el juego", "Asume diferentes roles dentro del equipo deportivo"}',
'groups', '#00D4FF', false, true, NOW(), NOW()),

-- 2o ESO - Trimestre 3 (10 semanas, 20 sesiones)
('2eso_t3_u1', '2_eso', 3, 1,
'Juegos que nos unen',
'Juegos recreativos y cooperativos',
'Participaras en juegos recreativos y cooperativos que fomentan la convivencia y la cohesion del grupo. Aprenderas que jugar juntos es mas divertido que competir.',
2,
'El Circulo de la Amistad',
'El Guardian de la Union',
450, 250, 130,
'{"fuerza": 0, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: juegos de cooperacion y oposicion", "Interaccion social: valores del juego y convivencia", "Autorregulacion: inclusion y respeto"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Coopera en juegos colectivos respetando normas y roles", "Participa activamente con actitud positiva e inclusiva", "Valora el juego como herramienta de convivencia"}',
'diversity_3', '#4CAF50', false, true, NOW(), NOW()),

('2eso_t3_u2', '2_eso', 3, 2,
'Raquetas en juego: badminton',
'Perfeccionamiento del badminton',
'Perfeccionaras tus fundamentos de badminton: saque, golpeos, desplazamientos y estrategia. Participaras en mini-ligas internas y torneos por parejas.',
2,
'El Torneo de los Volantes',
'El Saque Imparable',
550, 350, 180,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: tecnica y tactica en badminton", "Vida activa: mejora de la condicion especifica", "Autorregulacion: gestion emocional en competicion"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Ejecuta con eficacia saque, golpeo y recepcion en badminton", "Participa en partidos respetando las reglas", "Aplica estrategias basicas en situaciones reales de juego"}',
'sports_tennis', '#00D4FF', false, true, NOW(), NOW()),

('2eso_t3_u3', '2_eso', 3, 3,
'Nuevos deportes, nuevas emociones',
'Colpbol, ultimate e indiaca',
'Exploraras deportes alternativos como colpbol, ultimate e indiaca que favorecen la inclusion y la creatividad. Disfrutaras de nuevas experiencias deportivas mas alla de los deportes tradicionales.',
2,
'El Laboratorio de Deportes',
'El Inventor de Juegos',
500, 300, 150,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 2}',
'{"Resolucion de problemas: deportes alternativos y creativos", "Interaccion social: inclusion y participacion", "Manifestaciones culturales: nuevas tendencias deportivas"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Se adapta a reglamentos alternativos con flexibilidad", "Coopera y disfruta en deportes diferentes a los tradicionales", "Muestra creatividad en la adaptacion a nuevos juegos"}',
'sports_kabaddi', '#FF6B9D', false, true, NOW(), NOW()),

('2eso_t3_u4', '2_eso', 3, 4,
'Aventura en la naturaleza: orientacion',
'Mapas, brujulas y rutas',
'Participaras en actividades de orientacion y juegos al aire libre. Aprenderas a usar mapas y brujulas, a planificar rutas y a disfrutar de la naturaleza de forma segura y respetuosa.',
2,
'Expedicion al Valle Perdido',
'El Yeti del Valle Olvidado',
550, 350, 200,
'{"fuerza": 1, "resistencia": 2, "salud": 2, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Interaccion con el entorno: orientacion con mapas y brujula", "Organizacion: planificacion de rutas", "Vida activa: seguridad en la naturaleza"}',
'{"Competencia matematica (orientacion y escalas)", "Competencia personal, social y de aprender a aprender"}',
'{"Utiliza mapas y brujulas para orientarse en el medio", "Planifica una ruta con los recursos necesarios", "Aplica normas de seguridad y respeto ambiental"}',
'explore', '#FF9800', false, true, NOW(), NOW()),

('2eso_t3_u5', '2_eso', 3, 5,
'Copa final: mini-olimpiadas',
'Jornada deportiva de cierre',
'Organizaras y participaras en una jornada deportiva final que integra juegos, deportes colectivos, alternativos y badminton. Celebraras tus logros y el trabajo en equipo.',
2,
'Las Mini-Olimpiadas',
'El Espiritu Olimpico',
600, 400, 250,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 3}',
'{"Organizacion: gestion de eventos deportivos escolares", "Interaccion social: participacion y deportividad", "Autorregulacion: celebracion y cierre reflexivo"}',
'{"Competencia ciudadana", "Competencia emprendedora"}',
'{"Propone y organiza actividades para la jornada deportiva", "Participa con actitud deportiva y cooperativa", "Demuestra los aprendizajes adquiridos durante el curso"}',
'celebration', '#FFD700', false, true, NOW(), NOW()),


-- ============================================================
-- UNIDADES DIDACTICAS - 3o ESO (Tema: El Camino del Maestro)
-- ============================================================

-- 3o ESO - Trimestre 1 (11 semanas, 22 sesiones)
('3eso_t1_u1', '3_eso', 1, 1,
'Diseno mi calentamiento',
'Planificacion autonoma del calentamiento',
'Aprenderas a planificar calentamientos generales y especificos segun la actividad deportiva. Disenaras y dirigiras calentamientos completos, argumentando su importancia para la salud y el rendimiento.',
2,
'El Disenador de Rutinas',
'El Maestro del Calor',
550, 350, 180,
'{"fuerza": 1, "resistencia": 1, "salud": 3, "estrategia": 2, "cooperacion": 1, "liderazgo": 2}',
'{"Vida activa y saludable: tipos y fases del calentamiento", "Organizacion y gestion: diseno autonomo de calentamientos", "Autorregulacion: relacion calentamiento-prevencion"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia digital"}',
'{"Disena y dirige un calentamiento completo (general + especifico)", "Argumenta la importancia del calentamiento para la salud", "Evalua la calidad de los calentamientos de sus companeros"}',
'directions_run', '#7C4DFF', false, true, NOW(), NOW()),

('3eso_t1_u2', '3_eso', 1, 2,
'Mi cuerpo en accion',
'Aparato locomotor avanzado',
'Profundizaras en el conocimiento del aparato locomotor relacionando musculos, huesos y articulaciones con gestos tecnicos deportivos. Analizaras movimientos y preveniras lesiones.',
2,
'El Anatomista',
'El Guardian de las Articulaciones',
550, 350, 180,
'{"fuerza": 2, "resistencia": 1, "salud": 2, "estrategia": 2, "cooperacion": 0, "liderazgo": 0}',
'{"Vida activa y saludable: anatomia funcional avanzada", "Resolucion de problemas: biomecanica basica del movimiento", "Organizacion: prevencion de lesiones"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Identifica musculos y huesos implicados en gestos deportivos", "Analiza movimientos deportivos y su ejecucion correcta", "Relaciona la anatomia funcional con la prevencion de lesiones"}',
'fitness_center', '#00D4FF', false, true, NOW(), NOW()),

('3eso_t1_u3', '3_eso', 1, 3,
'Entreno mi cuerpo',
'Metodos de entrenamiento y capacidades fisicas',
'Entrenaras tus capacidades fisicas aplicando distintos metodos: intervalos, circuitos y repeticiones. Registraras tu evolucion y aprenderas a dosificar el esfuerzo.',
3,
'El Gimnasio del Maestro',
'El Titan de la Intensidad',
700, 450, 250,
'{"fuerza": 3, "resistencia": 3, "salud": 2, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: metodos de entrenamiento (intervalos, circuitos)", "Vida activa: mejora de la condicion fisica", "Autorregulacion: dosificacion del esfuerzo y recuperacion"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Aplica correctamente metodos de entrenamiento adaptados a su nivel", "Registra y valora su evolucion en pruebas fisicas", "Dosifica el esfuerzo segun sus posibilidades"}',
'trending_up', '#E040FB', false, true, NOW(), NOW()),

('3eso_t1_u4', '3_eso', 1, 4,
'Soy mi propio entrenador',
'Diseno de rutinas personales',
'Aprenderas a disenar y ejecutar rutinas de entrenamiento personal con objetivos claros. Aplicaras los principios del entrenamiento: progresion, especificidad y recuperacion.',
2,
'El Arquitecto Fisico',
'El Planificador Infinito',
600, 400, 220,
'{"fuerza": 2, "resistencia": 2, "salud": 2, "estrategia": 3, "cooperacion": 0, "liderazgo": 1}',
'{"Organizacion y gestion: principios del entrenamiento", "Resolucion de problemas: diseno de planes basicos", "Autorregulacion: autonomia y responsabilidad"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia emprendedora"}',
'{"Elabora una rutina de entrenamiento con objetivos claros", "Ejecuta la rutina con autonomia y correccion tecnica", "Evalua y ajusta su plan segun su progreso"}',
'fitness_center', '#00E676', false, true, NOW(), NOW()),

('3eso_t1_u5', '3_eso', 1, 5,
'Deportes alternativos: otra forma de competir',
'Colpbol, ultimate y kin-ball adaptado',
'Experimentaras con deportes alternativos como colpbol, ultimate frisbee y kin-ball adaptado. Descubriras formas ludicas e inclusivas de competir donde todos participan activamente.',
2,
'El Torneo de los Nuevos Mundos',
'El Arbitro Invisible',
650, 400, 220,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: deportes alternativos y reglamentos", "Interaccion social: inclusion y cooperacion", "Manifestaciones culturales: nuevas tendencias deportivas"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Se adapta a los reglamentos de deportes alternativos", "Coopera y participa activamente con actitud positiva", "Valora la inclusion como principio del juego"}',
'sports_kabaddi', '#FF6B9D', false, true, NOW(), NOW()),

-- 3o ESO - Trimestre 2 (10 semanas, 20 sesiones)
('3eso_t2_u1', '3_eso', 2, 1,
'Gimnastas en evolucion',
'Secuencias gimnasticas avanzadas',
'Ampliaras tus destrezas gimnasticas con secuencias mas complejas: volteos, equilibrios y apoyos dinamicos. Crearas mini-rutinas combinando elementos con fluidez y control.',
2,
'El Circo de los Suenos',
'El Malabarista del Tiempo',
550, 350, 180,
'{"fuerza": 2, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: secuencias gimnasticas combinadas", "Autorregulacion: confianza y creatividad motriz", "Interaccion social: seguridad y ayuda mutua"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia en conciencia y expresion cultural"}',
'{"Realiza secuencias gimnasticas combinando elementos con fluidez", "Coopera en la ayuda y seguridad de companeros", "Crea mini-rutinas con creatividad y control"}',
'accessibility_new', '#E040FB', false, true, NOW(), NOW()),

('3eso_t2_u2', '3_eso', 2, 2,
'Expresamos con el cuerpo',
'Bailes modernos y urbanos',
'Experimentaras con diferentes estilos de baile moderno y urbano. Crearas coreografias grupales y desarrollaras tu creatividad, coordinacion y expresion artistica.',
2,
'El Estudio de Baile',
'El Coreografo Virtual',
500, 300, 150,
'{"fuerza": 1, "resistencia": 2, "salud": 1, "estrategia": 1, "cooperacion": 2, "liderazgo": 3}',
'{"Manifestaciones culturales: bailes modernos y urbanos", "Vida activa: coordinacion y expresion ritmica", "Autorregulacion: creatividad y desinhibicion"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Integra ritmo y coordinacion en coreografias modernas", "Coopera en la elaboracion de montajes grupales", "Muestra creatividad en la expresion corporal"}',
'music_note', '#FF6B9D', false, true, NOW(), NOW()),

('3eso_t2_u3', '3_eso', 2, 3,
'Acrosport creativo',
'Figuras grupales y transiciones',
'A traves del trabajo cooperativo, disenaras y ejecutaras figuras de acrosport y secuencias colectivas que combinan fuerza, equilibrio y creatividad.',
2,
'La Piramide Humana',
'El Coloso de los Portes',
600, 400, 220,
'{"fuerza": 3, "resistencia": 1, "salud": 2, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Manifestaciones culturales: acrosport creativo", "Resolucion de problemas: diseno de figuras y transiciones", "Autorregulacion: confianza y seguridad en portes"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta figuras grupales de acrosport con seguridad", "Participa en la creacion de secuencias con transiciones fluidas", "Asume diferentes roles (portor, agil, ayudante) con responsabilidad"}',
'accessibility_new', '#FF9800', false, true, NOW(), NOW()),

('3eso_t2_u4', '3_eso', 2, 4,
'Heroes de la vida: RCP y emergencias',
'Reanimacion cardiopulmonar',
'Te entrenaras en reanimacion cardiopulmonar (RCP) y en la actuacion ante emergencias reales. Aprenderas a salvar vidas con la secuencia basica de RCP y la conducta PAS.',
2,
'La Sala de Emergencias',
'El Guardian de las Vidas',
550, 350, 180,
'{"fuerza": 0, "resistencia": 0, "salud": 3, "estrategia": 3, "cooperacion": 2, "liderazgo": 2}',
'{"Vida activa y saludable: RCP y emergencias", "Autorregulacion: control en situaciones criticas", "Interaccion social: responsabilidad ciudadana"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Ejecuta correctamente la secuencia basica de RCP", "Participa en simulaciones de emergencia con responsabilidad", "Aplica la conducta PAS en situaciones de emergencia simulada"}',
'local_hospital', '#00E676', false, true, NOW(), NOW()),

('3eso_t2_u5', '3_eso', 2, 5,
'Deportes individuales: compito conmigo mismo',
'Atletismo, tenis de mesa y badminton',
'Participaras en deportes individuales como atletismo, tenis de mesa y badminton avanzado. Buscaras superar tus propios retos personales y mejorar tu tecnica.',
2,
'El Duelo Personal',
'El Espejo del Esfuerzo',
600, 400, 220,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: tecnica en deportes individuales", "Vida activa: mejora del rendimiento personal", "Autorregulacion: autosuperacion y esfuerzo"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Aplica correctamente gestos tecnicos en deportes individuales", "Muestra esfuerzo y actitud de superacion personal", "Respeta las reglas de competicion individual"}',
'sports_tennis', '#00D4FF', false, true, NOW(), NOW()),

-- 3o ESO - Trimestre 3 (10 semanas, 20 sesiones)
('3eso_t3_u1', '3_eso', 3, 1,
'Juegos que cohesionan',
'Juegos recreativos y de confianza',
'Participaras en juegos recreativos y cooperativos que refuerzan la cohesion grupal y la confianza entre companeros. Descubriras el valor del juego como herramienta de integracion.',
2,
'El Circulo de Confianza',
'El Guardian de la Amistad',
450, 250, 130,
'{"fuerza": 0, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: juegos de cooperacion y confianza", "Interaccion social: cohesion grupal e inclusion", "Autorregulacion: respeto y empatia"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Coopera en juegos colectivos con actitud inclusiva", "Respeta normas y roles establecidos", "Participa activamente generando un ambiente positivo"}',
'diversity_3', '#4CAF50', false, true, NOW(), NOW()),

('3eso_t3_u2', '3_eso', 3, 2,
'Predeportes: un paso hacia el juego real',
'Juegos modificados y habilidades previas',
'Desarrollaras habilidades basicas que serviran de base para los deportes colectivos a traves de juegos modificados. Trabajaras pase, bote, recepcion y tiro en situaciones simplificadas.',
2,
'El Campo de Entrenamiento',
'El Instructor de Habilidades',
500, 300, 150,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: fundamentos tecnicos predeportivos", "Interaccion social: juegos modificados y trabajo en equipo", "Autorregulacion: respeto de normas adaptadas"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta fundamentos basicos (pase, bote, tiro, recepcion)", "Participa en juegos modificados aplicando reglas simplificadas", "Muestra progresion en la ejecucion tecnica"}',
'sports_handball', '#00E676', false, true, NOW(), NOW()),

('3eso_t3_u3', '3_eso', 3, 3,
'Grandes deportes: futbol y baloncesto',
'Tecnica y tactica en deportes colectivos',
'Profundizaras en futbol y baloncesto con mayor exigencia tecnica y tactica. Mejoraras tu lectura del juego, tus decisiones en equipo y tu capacidad de ejecucion bajo presion.',
3,
'El Estadio de los Grandes',
'El General del Juego',
700, 450, 250,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 3, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: sistemas tacticos en futbol y baloncesto", "Autorregulacion: liderazgo y toma de decisiones", "Interaccion social: comunicacion tactica y roles"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Demuestra fundamentos tecnicos avanzados en futbol y baloncesto", "Aplica principios tacticos basicos en situaciones de juego", "Ejerce liderazgo y comunicacion efectiva en el equipo"}',
'sports_basketball', '#FF9800', false, true, NOW(), NOW()),

('3eso_t3_u4', '3_eso', 3, 4,
'Deportes alternativos: nueva mirada',
'Ultimate, colpbol y datchball avanzado',
'Practicaras deportes alternativos con mayor profundidad tactica. Desarrollaras estrategias de equipo y crearas tus propias variantes de juegos alternativos.',
2,
'El Torneo Alternativo',
'El Innovador de Reglas',
550, 350, 180,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: estrategias en deportes alternativos", "Interaccion social: cooperacion y liderazgo", "Manifestaciones culturales: creacion de nuevas practicas deportivas"}',
'{"Competencia ciudadana", "Competencia emprendedora"}',
'{"Se adapta a reglamentos alternativos con autonomia", "Coopera activamente en la creacion de nuevas variantes", "Muestra liderazgo y creatividad en el juego alternativo"}',
'sports_kabaddi', '#FF6B9D', false, true, NOW(), NOW()),

('3eso_t3_u5', '3_eso', 3, 5,
'Orientacion y aventura',
'Planificacion de rutas y orientacion',
'Participaras en actividades de orientacion mas complejas, planificando rutas y utilizando mapas detallados. Realizaras una salida a un entorno natural cercano si es posible.',
2,
'La Gran Expedicion',
'El Espiritu de la Montana',
600, 400, 220,
'{"fuerza": 1, "resistencia": 2, "salud": 2, "estrategia": 2, "cooperacion": 2, "liderazgo": 2}',
'{"Interaccion con el entorno: orientacion avanzada y planificacion", "Organizacion: seguridad en actividades al aire libre", "Vida activa: respeto y conservacion del medio natural"}',
'{"Competencia matematica y en ciencia", "Competencia personal, social y de aprender a aprender"}',
'{"Utiliza mapas detallados para planificar rutas de orientacion", "Coopera en la organizacion de salidas al entorno natural", "Respeta y valora el medio ambiente en sus practicas"}',
'terrain', '#4CAF50', true, true, NOW(), NOW()),

-- ============================================================
-- UNIDADES DIDACTICAS - 4o ESO (Tema: El Legado del Heroe)
-- ============================================================

-- 4o ESO - Trimestre 1 (11 semanas, 22 sesiones)
('4eso_t1_u1', '4_eso', 1, 1,
'Lideres del calentamiento',
'Diseno y direccion de calentamientos',
'Asumiras un rol activo disenando y dirigiendo calentamientos generales y especificos adaptados a distintos deportes. Justificaras la relacion entre calentamiento, salud y rendimiento.',
2,
'El Mentor del Calor',
'El Maestro de Ceremonias',
600, 400, 220,
'{"fuerza": 1, "resistencia": 1, "salud": 3, "estrategia": 2, "cooperacion": 1, "liderazgo": 3}',
'{"Vida activa y saludable: diseno autonomo de calentamientos", "Organizacion y gestion: direccion de grupos", "Autorregulacion: liderazgo y responsabilidad"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia emprendedora"}',
'{"Disena y dirige un calentamiento completo justificando cada fase", "Evalua la calidad de los calentamientos de sus companeros", "Asume el rol de lider con responsabilidad"}',
'groups', '#7C4DFF', false, true, NOW(), NOW()),

('4eso_t1_u2', '4_eso', 1, 2,
'Mi cuerpo en detalle',
'Aparato locomotor y prevencion de lesiones',
'Profundizaras en la relacion entre el aparato locomotor y la practica deportiva. Analizaras lesiones frecuentes, sus causas y las medidas de prevencion mas efectivas.',
2,
'El Anatomista Avanzado',
'El Sanador de Musculos',
600, 400, 220,
'{"fuerza": 2, "resistencia": 1, "salud": 3, "estrategia": 2, "cooperacion": 0, "liderazgo": 1}',
'{"Vida activa y saludable: anatomia funcional y prevencion", "Resolucion de problemas: analisis de lesiones deportivas", "Autorregulacion: habitos saludables y autocuidado"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Identifica musculos, huesos y articulaciones implicados en gestos deportivos", "Reconoce lesiones frecuentes y sus medidas de prevencion", "Analiza criticamente la ejecucion de movimientos deportivos"}',
'fitness_center', '#00D4FF', false, true, NOW(), NOW()),

('4eso_t1_u3', '4_eso', 1, 3,
'Reto fisico avanzado',
'Capacidades fisicas y metodos de entrenamiento',
'Evaluaras y entrenaras tus capacidades fisicas con metodos mas avanzados: HIIT, circuitos funcionales y entrenamiento intervalico. Buscaras la mejora y el autoconocimiento de tu condicion fisica.',
3,
'El Laboratorio del Rendimiento',
'El Monitor de Intensidad',
800, 550, 300,
'{"fuerza": 3, "resistencia": 3, "salud": 3, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: metodos avanzados de entrenamiento", "Vida activa: HIIT, circuitos y entrenamiento funcional", "Autorregulacion: autoconocimiento y dosificacion del esfuerzo"}',
'{"Competencia matematica y en ciencia", "Competencia digital"}',
'{"Aplica metodos de entrenamiento avanzados adaptados a su nivel", "Mejora sus registros en pruebas fisicas comparativas", "Autoevalua su esfuerzo y progreso con honestidad"}',
'trending_up', '#E040FB', false, true, NOW(), NOW()),

('4eso_t1_u4', '4_eso', 1, 4,
'Mis cualidades motrices en juego',
'Coordinacion, equilibrio, agilidad y ritmo',
'Desarrollaras las cualidades motrices basicas a traves de juegos y circuitos especificos. Mejoraras tu coordinacion, equilibrio, agilidad y sentido del ritmo de forma ludica y desafiante.',
2,
'El Parque de las Habilidades',
'El Guardian del Equilibrio',
600, 400, 220,
'{"fuerza": 1, "resistencia": 1, "salud": 2, "estrategia": 2, "cooperacion": 1, "liderazgo": 1}',
'{"Resolucion de problemas: coordinacion, equilibrio y agilidad", "Vida activa: mejora de cualidades motrices", "Organizacion: circuitos de habilidades"}',
'{"Competencia matematica y en ciencia", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta tareas que implican coordinacion, equilibrio y agilidad", "Participa activamente en juegos y retos motrices", "Muestra progresion en el desarrollo de sus cualidades motrices"}',
'accessibility_new', '#00E676', false, true, NOW(), NOW()),

('4eso_t1_u5', '4_eso', 1, 5,
'Entrenadores en practica',
'Planificacion de entrenamiento personal',
'Aplicaras principios de entrenamiento disenando y ejecutando rutinas personalizadas. Comprenderas la importancia de la progresion, la especificidad y la recuperacion en tu propio plan.',
3,
'El Arquitecto de Ti Mismo',
'El Planificador Infinito',
700, 500, 300,
'{"fuerza": 2, "resistencia": 2, "salud": 2, "estrategia": 3, "cooperacion": 0, "liderazgo": 2}',
'{"Organizacion y gestion: principios del entrenamiento avanzados", "Resolucion de problemas: diseno de planes personalizados", "Autorregulacion: autonomia y evaluacion"}',
'{"Competencia digital (apps y wearables)", "Competencia emprendedora"}',
'{"Disena un plan de entrenamiento personalizado con objetivos", "Ejecuta el plan con autonomia y responsabilidad", "Evalua criticamente su progreso y ajusta su plan"}',
'fitness_center', '#FF9800', false, true, NOW(), NOW()),

-- 4o ESO - Trimestre 2 (10 semanas, 20 sesiones)
('4eso_t2_u1', '4_eso', 2, 1,
'Gimnasia en progresion',
'Secuencias gimnasticas avanzadas',
'Afianzaras tus destrezas gimnasticas con secuencias mas elaboradas combinando volteos, apoyos y equilibrios dinamicos. Crearas rutinas por parejas garantizando la seguridad.',
2,
'El Templo del Movimiento',
'El Acrobata Maestro',
600, 400, 220,
'{"fuerza": 2, "resistencia": 1, "salud": 2, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: secuencias gimnasticas elaboradas", "Autorregulacion: creatividad y control corporal", "Interaccion social: seguridad y ayuda avanzada"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia en conciencia y expresion cultural"}',
'{"Realiza secuencias combinadas en suelo con fluidez y control", "Coopera garantizando la seguridad en la practica", "Crea rutinas por parejas con elementos variados"}',
'accessibility_new', '#E040FB', false, true, NOW(), NOW()),

('4eso_t2_u2', '4_eso', 2, 2,
'Cuerpos que cuentan historias',
'Teatro fisico y dramatizacion',
'A traves de dinamicas de teatro fisico y expresion corporal, desarrollaras la creatividad y la comunicacion no verbal. Crearas montajes teatrales breves usando el cuerpo como medio de expresion.',
2,
'El Gran Escenario',
'El Director de Escena',
600, 400, 220,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 3, "liderazgo": 3}',
'{"Manifestaciones culturales: teatro fisico y dramatizacion", "Autorregulacion: expresion y comunicacion escenica", "Interaccion social: creacion artistica colectiva"}',
'{"Competencia en conciencia y expresion cultural", "Competencia personal, social y de aprender a aprender"}',
'{"Representa escenas breves usando el cuerpo como medio de expresion", "Coopera en la elaboracion de montajes teatrales grupales", "Muestra creatividad y desinhibicion en la expresion corporal"}',
'theater_comedy', '#FF6B9D', false, true, NOW(), NOW()),

('4eso_t2_u3', '4_eso', 2, 3,
'Primeros auxilios: se actuar',
'RCP, atragantamientos y lesiones deportivas',
'Ampliaras tus conocimientos de primeros auxilios con atencion a situaciones avanzadas: RCP en adultos, maniobra de Heimlich y actuacion ante lesiones deportivas comunes.',
2,
'La Sala de Urgencias',
'El Angel de la Guarda',
550, 350, 180,
'{"fuerza": 0, "resistencia": 0, "salud": 3, "estrategia": 3, "cooperacion": 2, "liderazgo": 2}',
'{"Vida activa y saludable: RCP y emergencias avanzadas", "Autorregulacion: control en situaciones criticas", "Interaccion social: responsabilidad y liderazgo en emergencias"}',
'{"Competencia personal, social y de aprender a aprender", "Competencia ciudadana"}',
'{"Ejecuta correctamente maniobras de RCP y desobstruccion", "Aplica medidas basicas ante lesiones deportivas", "Participa en simulaciones mostrando liderazgo y responsabilidad"}',
'local_hospital', '#00E676', false, true, NOW(), NOW()),

('4eso_t2_u4', '4_eso', 2, 4,
'Deportes colectivos: tactica y estrategia',
'Sistemas de juego y roles de equipo',
'Practicaras deportes colectivos incorporando nociones tacticas y roles de equipo. Mejoraras tu lectura del juego, tu capacidad de anticipacion y tu comunicacion en la cancha.',
2,
'El Tablero Deportivo',
'El General de la Cancha',
700, 450, 250,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 3, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: sistemas tacticos colectivos avanzados", "Autorregulacion: liderazgo y toma de decisiones", "Interaccion social: comunicacion tactica y roles"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta fundamentos tecnicos y tacticos en deportes colectivos", "Toma decisiones tacticas adecuadas durante el juego", "Asume diferentes roles con responsabilidad y liderazgo"}',
'sports_volleyball', '#00D4FF', false, true, NOW(), NOW()),

('4eso_t2_u5', '4_eso', 2, 5,
'Torneo de deportes colectivos',
'Competicion y juego limpio',
'Aplicaras todo lo aprendido en un torneo de deportes colectivos. Demostraras tu capacidad de trabajo en equipo, tu espiritu deportivo y tu habilidad para competir con respeto.',
2,
'La Copa de los Equipos',
'El Espiritu Deportivo',
700, 450, 250,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 3, "cooperacion": 3, "liderazgo": 3}',
'{"Resolucion de problemas: competicion y estrategia", "Autorregulacion: gestion emocional en la competicion", "Interaccion social: deportividad y respeto"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Compite respetando normas, rivales y decisiones arbitrales", "Demuestra trabajo en equipo y comunicacion efectiva", "Muestra deportividad en victoria y derrota"}',
'workspace_premium', '#FFD700', false, true, NOW(), NOW()),

-- 4o ESO - Trimestre 3 (10 semanas, 20 sesiones)
('4eso_t3_u1', '4_eso', 3, 1,
'Juegos para convivir',
'Juegos recreativos, cooperativos y de confianza',
'Participaras en juegos recreativos, cooperativos y competitivos que refuerzan la cohesion grupal y la inclusion. Valoraras el juego como herramienta de convivencia y disfrute.',
2,
'El Circulo de Todos',
'El Guardian de la Convivencia',
500, 300, 150,
'{"fuerza": 0, "resistencia": 1, "salud": 1, "estrategia": 1, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: juegos de cooperacion y oposicion", "Interaccion social: inclusion y cohesion grupal", "Autorregulacion: actitud positiva y respeto"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Coopera y respeta normas en juegos colectivos", "Muestra actitud positiva y de inclusion hacia todos", "Valora el juego como espacio de convivencia"}',
'diversity_3', '#4CAF50', false, true, NOW(), NOW()),

('4eso_t3_u2', '4_eso', 3, 2,
'Predeportes en accion',
'Juegos modificados hacia deportes reglados',
'A traves de juegos modificados, consolidaras habilidades basicas para la practica de deportes colectivos. Trabajaras la transicion del juego libre al deporte reglado.',
2,
'El Puente hacia el Deporte',
'El Guia de Transiciones',
500, 300, 150,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 2, "liderazgo": 1}',
'{"Resolucion de problemas: juegos predeportivos y fundamentos", "Interaccion social: trabajo en equipo y roles", "Organizacion: transicion juego-deporte"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Aplica fundamentos basicos en situaciones predeportivas", "Participa en juegos modificados con actitud activa", "Comprende la evolucion del juego al deporte reglado"}',
'directions_run', '#00E676', false, true, NOW(), NOW()),

('4eso_t3_u3', '4_eso', 3, 3,
'Grandes deportes: balonmano, voleibol, hockey y rugby',
'Deportes colectivos variados',
'Practicaras deportes colectivos variados como balonmano, voleibol, hockey y rugby escolar. Mejoraras tu tecnica y tactica basica con enfasis en la cooperacion y el respeto.',
3,
'El Polideportivo Total',
'El Atleta Completo',
750, 500, 300,
'{"fuerza": 2, "resistencia": 2, "salud": 1, "estrategia": 3, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: fundamentos de balonmano, voleibol, hockey y rugby", "Interaccion social: cooperacion y roles en distintos deportes", "Autorregulacion: adaptacion a diferentes reglamentos"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta fundamentos tecnicos basicos de distintos deportes colectivos", "Se adapta a diferentes reglamentos y dinamicas de juego", "Coopera en la tactica basica del juego colectivo"}',
'sports_handball', '#FF9800', false, true, NOW(), NOW()),

('4eso_t3_u4', '4_eso', 3, 4,
'Alternativos e inclusivos',
'Ultimate, colpbol, datchball y kin-ball',
'Descubriras y practicaras deportes alternativos como espacios de inclusion y creatividad. Valoraras el juego como herramienta de participacion universal donde todos tienen cabida.',
2,
'El Festival Inclusivo',
'El Campeon de la Igualdad',
550, 350, 180,
'{"fuerza": 1, "resistencia": 1, "salud": 1, "estrategia": 2, "cooperacion": 3, "liderazgo": 2}',
'{"Resolucion de problemas: deportes alternativos inclusivos", "Interaccion social: inclusion y diversidad", "Manifestaciones culturales: nuevos modelos deportivos"}',
'{"Competencia ciudadana", "Competencia personal, social y de aprender a aprender"}',
'{"Se adapta a las normas de deportes alternativos con autonomia", "Coopera y respeta la diversidad en el juego", "Propone adaptaciones para hacer los juegos mas inclusivos"}',
'sports_kabaddi', '#FF6B9D', false, true, NOW(), NOW()),

('4eso_t3_u5', '4_eso', 3, 5,
'Badminton avanzado y orientacion',
'Deporte de raqueta y naturaleza',
'Perfeccionaras tus fundamentos de badminton con torneos internos y practicaras orientacion en el entorno natural. Integraras dos disciplinas diferentes en un cierre deportivo completo.',
2,
'El Legado del Heroe',
'El Consejo de los Sabios',
700, 500, 300,
'{"fuerza": 1, "resistencia": 2, "salud": 2, "estrategia": 3, "cooperacion": 2, "liderazgo": 3}',
'{"Resolucion de problemas: integracion de deportes y estrategias", "Interaccion social: liderazgo y trabajo en equipo", "Vida activa: practica segura y sostenible"}',
'{"Todas las competencias clave", "Competencia personal, social y de aprender a aprender"}',
'{"Ejecuta con correccion tecnica avanzada de badminton", "Utiliza mapas para orientarse en espacios conocidos y naturales", "Integra y aplica los aprendizajes de toda la etapa"}',
'workspace_premium', '#FFD700', true, true, NOW(), NOW());


-- ============================================================
-- LECCIONES (4 por unidad, 240 total)
-- ============================================================

INSERT INTO lessons (id, unit_id, "order", type, title, description, duration_sec, xp_reward, coin_reward, is_active, created_at) VALUES

-- 1ESO T1 U1: Entreno mi cuerpo
('l_1eso_t1_u1_01', '1eso_t1_u1', 1, 'video', 'Por que calentar?', 'Descubre por que es importante calentar antes de hacer ejercicio y que le pasa a tu cuerpo cuando lo haces.', 180, 30, 5, true, NOW()),
('l_1eso_t1_u1_02', '1eso_t1_u1', 2, 'reading', 'Las fases del calentamiento', 'Aprende las tres fases del calentamiento: movilidad articular, activacion y estiramientos suaves.', 240, 35, 5, true, NOW()),
('l_1eso_t1_u1_03', '1eso_t1_u1', 3, 'flashcard', 'Habitos saludables', 'Repasa los habitos clave para una vida activa: hidratacion, descanso, higiene y alimentacion.', 180, 25, 3, true, NOW()),
('l_1eso_t1_u1_04', '1eso_t1_u1', 4, 'quiz', 'Pon a prueba tu salud', 'Demuestra lo que sabes sobre calentamiento y habitos saludables.', 180, 40, 8, true, NOW()),

-- 1ESO T1 U2: Aparato locomotor
('l_1eso_t1_u2_01', '1eso_t1_u2', 1, 'video', 'El esqueleto: nuestra estructura', 'Viaja al interior de tu cuerpo y descubre los huesos que te sostienen y protegen.', 180, 30, 5, true, NOW()),
('l_1eso_t1_u2_02', '1eso_t1_u2', 2, 'reading', 'Los musculos: motores del cuerpo', 'Conoce los principales grupos musculares y como trabajan para moverte.', 240, 35, 5, true, NOW()),
('l_1eso_t1_u2_03', '1eso_t1_u2', 3, 'flashcard', 'Articulaciones en movimiento', 'Aprende los tipos de articulaciones y los movimientos que permite cada una.', 180, 25, 3, true, NOW()),
('l_1eso_t1_u2_04', '1eso_t1_u2', 4, 'quiz', 'Cuanto sabes de tu cuerpo?', 'Pon a prueba tu conocimiento sobre huesos, musculos y articulaciones.', 180, 40, 8, true, NOW()),

-- 1ESO T1 U3: Resistencia y velocidad
('l_1eso_t1_u3_01', '1eso_t1_u3', 1, 'video', 'Corre sin parar', 'Aprende tecnicas de carrera continua y descubre como mejorar tu resistencia.', 200, 30, 5, true, NOW()),
('l_1eso_t1_u3_02', '1eso_t1_u3', 2, 'reading', 'La velocidad: rapida reaccion', 'Descubre como mejorar tu velocidad de reaccion y desplazamiento.', 240, 35, 5, true, NOW()),
('l_1eso_t1_u3_03', '1eso_t1_u3', 3, 'flashcard', 'Controla tu respiracion', 'Aprende tecnicas de respiracion para correr mejor y recuperarte mas rapido.', 180, 25, 3, true, NOW()),
('l_1eso_t1_u3_04', '1eso_t1_u3', 4, 'quiz', 'Resistencia y velocidad', 'Pon a prueba lo que sabes sobre resistencia cardiovascular y velocidad.', 180, 40, 8, true, NOW()),

-- 1ESO T1 U4: Fuerza y flexibilidad
('l_1eso_t1_u4_01', '1eso_t1_u4', 1, 'video', 'Fortalece tu cuerpo', 'Descubre ejercicios basicos de fuerza con tu propio peso corporal.', 200, 30, 5, true, NOW()),
('l_1eso_t1_u4_02', '1eso_t1_u4', 2, 'reading', 'Flexibilidad: muevete mejor', 'Aprende por que es importante ser flexible y como mejorar tu amplitud de movimiento.', 240, 35, 5, true, NOW()),
('l_1eso_t1_u4_03', '1eso_t1_u4', 3, 'flashcard', 'Ejercicios seguros', 'Repasa las claves para ejecutar ejercicios de fuerza y flexibilidad sin lesionarte.', 180, 25, 3, true, NOW()),
('l_1eso_t1_u4_04', '1eso_t1_u4', 4, 'quiz', 'Fuerza y flexibilidad', 'Demuestra cuanto sabes sobre el entrenamiento de fuerza y flexibilidad.', 180, 40, 8, true, NOW()),

-- 1ESO T1 U5: Juegos tradicionales
('l_1eso_t1_u5_01', '1eso_t1_u5', 1, 'video', 'Juegos de siempre', 'Descubre juegos tradicionales de Extremadura: la rayuela, el elastico, las chapas y mas.', 180, 25, 5, true, NOW()),
('l_1eso_t1_u5_02', '1eso_t1_u5', 2, 'reading', 'Jugar en equipo', 'Aprende las claves del trabajo en equipo: comunicacion, respeto y ayuda mutua.', 240, 30, 5, true, NOW()),
('l_1eso_t1_u5_03', '1eso_t1_u5', 3, 'flashcard', 'Normas y fair play', 'Conoce las reglas basicas del juego limpio: respetar turnos y valorar el esfuerzo.', 180, 25, 3, true, NOW()),
('l_1eso_t1_u5_04', '1eso_t1_u5', 4, 'quiz', 'Juego limpio', 'Demuestra cuanto sabes sobre juegos cooperativos y fair play.', 180, 35, 8, true, NOW()),

-- 1ESO T2 U1: Gimnastas en accion
('l_1eso_t2_u1_01', '1eso_t2_u1', 1, 'video', 'Volteos y giros', 'Aprende a realizar volteos adelante y atras con seguridad y control.', 200, 30, 5, true, NOW()),
('l_1eso_t2_u1_02', '1eso_t2_u1', 2, 'reading', 'Equilibrios basicos', 'Descubre diferentes tipos de equilibrio y como mantenerlos.', 240, 35, 5, true, NOW()),
('l_1eso_t2_u1_03', '1eso_t2_u1', 3, 'flashcard', 'Seguridad en gimnasia', 'Repasa las normas de seguridad y ayuda para practicar gimnasia sin riesgo.', 180, 25, 3, true, NOW()),
('l_1eso_t2_u1_04', '1eso_t2_u1', 4, 'quiz', 'Gimnastas en accion', 'Pon a prueba tu conocimiento sobre habilidades gimnasticas basicas.', 180, 40, 8, true, NOW()),

-- 1ESO T2 U2: Expresion y ritmo
('l_1eso_t2_u2_01', '1eso_t2_u2', 1, 'video', 'Emociones en movimiento', 'Descubre como expresar emociones con tu cuerpo: alegria, tristeza, sorpresa y mas.', 200, 30, 5, true, NOW()),
('l_1eso_t2_u2_02', '1eso_t2_u2', 2, 'reading', 'Ritmo y coordinacion', 'Aprende a coordinar tus movimientos con la musica y el ritmo.', 240, 35, 5, true, NOW()),
('l_1eso_t2_u2_03', '1eso_t2_u2', 3, 'flashcard', 'Lenguaje corporal', 'Conoce el lenguaje no verbal: gestos, posturas y comunicacion sin palabras.', 180, 25, 3, true, NOW()),
('l_1eso_t2_u2_04', '1eso_t2_u2', 4, 'quiz', 'Expresion corporal', 'Pon a prueba tu conocimiento sobre expresion corporal y ritmo.', 180, 40, 8, true, NOW()),

-- 1ESO T2 U3: Primeros auxilios
('l_1eso_t2_u3_01', '1eso_t2_u3', 1, 'video', 'La conducta PAS', 'Aprende los tres pasos clave ante una emergencia: Proteger, Avisar, Socorrer.', 180, 30, 5, true, NOW()),
('l_1eso_t2_u3_02', '1eso_t2_u3', 2, 'reading', 'Actuaciones basicas', 'Descubre como actuar ante cortes, caidas, golpes y quemaduras leves.', 240, 35, 5, true, NOW()),
('l_1eso_t2_u3_03', '1eso_t2_u3', 3, 'flashcard', 'Botiquin basico', 'Repasa los elementos esenciales de un botiquin y para que sirve cada uno.', 180, 25, 3, true, NOW()),
('l_1eso_t2_u3_04', '1eso_t2_u3', 4, 'quiz', 'Primeros auxilios', 'Demuestra lo que sabes sobre primeros auxilios y conducta PAS.', 180, 40, 8, true, NOW()),

-- 1ESO T2 U4: Deportes de equipo
('l_1eso_t2_u4_01', '1eso_t2_u4', 1, 'video', 'Deportes colectivos', 'Descubre los fundamentos del baloncesto, futbol sala y voleibol.', 240, 30, 5, true, NOW()),
('l_1eso_t2_u4_02', '1eso_t2_u4', 2, 'reading', 'Reglas basicas del juego', 'Conoce las reglas esenciales de los deportes colectivos.', 240, 35, 5, true, NOW()),
('l_1eso_t2_u4_03', '1eso_t2_u4', 3, 'flashcard', 'Gestos tecnicos', 'Repasa los gestos tecnicos: pase, recepcion, tiro y desplazamiento.', 180, 25, 3, true, NOW()),
('l_1eso_t2_u4_04', '1eso_t2_u4', 4, 'quiz', 'Iniciacion deportiva', 'Demuestra lo que sabes sobre deportes de equipo.', 180, 40, 8, true, NOW()),

-- 1ESO T2 U5: Torneo deportivo
('l_1eso_t2_u5_01', '1eso_t2_u5', 1, 'video', 'Estrategias de equipo', 'Aprende estrategias basicas para jugar en equipo: ocupar espacios y comunicarse.', 240, 30, 5, true, NOW()),
('l_1eso_t2_u5_02', '1eso_t2_u5', 2, 'reading', 'Roles en el equipo', 'Descubre los diferentes roles en los deportes colectivos y encuentra el tuyo.', 240, 35, 5, true, NOW()),
('l_1eso_t2_u5_03', '1eso_t2_u5', 3, 'flashcard', 'Espiritu deportivo', 'Repasa las claves del espiritu deportivo: respeto, esfuerzo y companerismo.', 180, 25, 3, true, NOW()),
('l_1eso_t2_u5_04', '1eso_t2_u5', 4, 'quiz', 'Equipo en juego', 'Pon a prueba tu conocimiento sobre trabajo en equipo y deportes colectivos.', 180, 40, 8, true, NOW()),

-- 1ESO T3 U1: Deportes alternativos
('l_1eso_t3_u1_01', '1eso_t3_u1', 1, 'video', 'Ultimate frisbee', 'Descubre el ultimate frisbee, un deporte alternativo donde el trabajo en equipo es clave.', 200, 30, 5, true, NOW()),
('l_1eso_t3_u1_02', '1eso_t3_u1', 2, 'reading', 'Colpbol y datchball', 'Aprende las reglas basicas del colpbol y el datchball, dos deportes alternativos muy divertidos.', 240, 35, 5, true, NOW()),
('l_1eso_t3_u1_03', '1eso_t3_u1', 3, 'flashcard', 'Valores alternativos', 'Repasa los valores que promueven los deportes alternativos: inclusion, cooperacion y diversion.', 180, 25, 3, true, NOW()),
('l_1eso_t3_u1_04', '1eso_t3_u1', 4, 'quiz', 'Deportes alternativos', 'Demuestra cuanto sabes sobre deportes alternativos.', 180, 40, 8, true, NOW()),

-- 1ESO T3 U2: Badminton
('l_1eso_t3_u2_01', '1eso_t3_u2', 1, 'video', 'El badminton: golpeos basicos', 'Aprende los golpeos basicos de badminton: claro, drive y dejada.', 200, 30, 5, true, NOW()),
('l_1eso_t3_u2_02', '1eso_t3_u2', 2, 'reading', 'Saque y desplazamientos', 'Domina el saque y los desplazamientos en la pista de badminton.', 240, 35, 5, true, NOW()),
('l_1eso_t3_u2_03', '1eso_t3_u2', 3, 'flashcard', 'Reglas del badminton', 'Repasa las reglas esenciales del badminton: pista, puntuacion y faltas.', 180, 25, 3, true, NOW()),
('l_1eso_t3_u2_04', '1eso_t3_u2', 4, 'quiz', 'Badminton', 'Pon a prueba tu conocimiento sobre este divertido deporte de raqueta.', 180, 40, 8, true, NOW()),

-- 1ESO T3 U3: Orientacion
('l_1eso_t3_u3_01', '1eso_t3_u3', 1, 'video', 'Orientacion basica', 'Aprende a orientarte usando el sol, puntos de referencia y mapas sencillos.', 240, 30, 5, true, NOW()),
('l_1eso_t3_u3_02', '1eso_t3_u3', 2, 'reading', 'El mapa y sus claves', 'Descubre como leer un mapa: simbolos, leyendas y orientacion del plano.', 240, 35, 5, true, NOW()),
('l_1eso_t3_u3_03', '1eso_t3_u3', 3, 'flashcard', 'Pistas y senales', 'Aprende a seguir pistas y senales en el entorno para encontrar puntos de control.', 180, 25, 3, true, NOW()),
('l_1eso_t3_u3_04', '1eso_t3_u3', 4, 'quiz', 'Orientacion', 'Demuestra tu conocimiento sobre orientacion espacial.', 180, 40, 8, true, NOW()),

-- 1ESO T3 U4: Naturaleza
('l_1eso_t3_u4_01', '1eso_t3_u4', 1, 'video', 'Senderismo seguro', 'Descubre como preparar una ruta de senderismo: calzado, mochila, agua y ropa adecuada.', 240, 30, 5, true, NOW()),
('l_1eso_t3_u4_02', '1eso_t3_u4', 2, 'reading', 'Cuida la naturaleza', 'Aprende las 3R en la naturaleza: Reduce, Reutiliza, Recicla.', 180, 35, 5, true, NOW()),
('l_1eso_t3_u4_03', '1eso_t3_u4', 3, 'flashcard', 'Fauna y flora local', 'Conoce algunas especies de flora y fauna tipicas de Extremadura.', 180, 25, 3, true, NOW()),
('l_1eso_t3_u4_04', '1eso_t3_u4', 4, 'quiz', 'Naturaleza y aventura', 'Pon a prueba tu conocimiento sobre senderismo y medio natural.', 180, 40, 8, true, NOW()),

-- 1ESO T3 U5: Fiesta deportiva
('l_1eso_t3_u5_01', '1eso_t3_u5', 1, 'video', 'Organiza tu evento deportivo', 'Aprende los pasos para organizar una jornada deportiva.', 240, 35, 5, true, NOW()),
('l_1eso_t3_u5_02', '1eso_t3_u5', 2, 'reading', 'El espiritu de la fiesta', 'Descubre como crear un ambiente deportivo positivo donde todos disfruten.', 240, 40, 8, true, NOW()),
('l_1eso_t3_u5_03', '1eso_t3_u5', 3, 'flashcard', 'Roles en el evento', 'Repasa los roles necesarios en un evento deportivo.', 180, 30, 5, true, NOW()),
('l_1eso_t3_u5_04', '1eso_t3_u5', 4, 'quiz', 'Fiesta deportiva', 'Demuestra lo que sabes sobre organizacion de eventos deportivos.', 180, 45, 10, true, NOW()),

-- 2ESO T1 U1: Calentamiento
('l_2eso_t1_u1_01', '2eso_t1_u1', 1, 'video', 'Calentamiento general y especifico', 'Descubre las diferencias entre calentamiento general y especifico.', 240, 35, 5, true, NOW()),
('l_2eso_t1_u1_02', '2eso_t1_u1', 2, 'reading', 'Disena tu calentamiento', 'Aprende a disenar un calentamiento completo con ejercicios para cada fase.', 300, 40, 5, true, NOW()),
('l_2eso_t1_u1_03', '2eso_t1_u1', 3, 'flashcard', 'Prevencion de lesiones', 'Repasa como el calentamiento previene lesiones y mejora el rendimiento.', 180, 30, 3, true, NOW()),
('l_2eso_t1_u1_04', '2eso_t1_u1', 4, 'quiz', 'Calentamiento y salud', 'Pon a prueba tu conocimiento sobre calentamiento y prevencion.', 180, 45, 8, true, NOW()),

-- 2ESO T1 U2: Cuerpo en movimiento
('l_2eso_t1_u2_01', '2eso_t1_u2', 1, 'video', 'Musculos en accion', 'Observa como trabajan los principales musculos en diferentes ejercicios.', 240, 35, 5, true, NOW()),
('l_2eso_t1_u2_02', '2eso_t1_u2', 2, 'reading', 'Huesos y articulaciones funcionales', 'Profundiza en la funcion de huesos y articulaciones durante el movimiento deportivo.', 240, 40, 5, true, NOW()),
('l_2eso_t1_u2_03', '2eso_t1_u2', 3, 'flashcard', 'Sistemas del cuerpo', 'Repasa los sistemas que intervienen en el movimiento.', 180, 30, 3, true, NOW()),
('l_2eso_t1_u2_04', '2eso_t1_u2', 4, 'quiz', 'Cuerpo y movimiento', 'Demuestra tu conocimiento sobre el aparato locomotor en accion.', 180, 45, 8, true, NOW()),

-- 2ESO T1 U3: Reto fisico
('l_2eso_t1_u3_01', '2eso_t1_u3', 1, 'video', 'Course Navette y tests', 'Descubre como medir tu condicion fisica con los tests mas utilizados.', 300, 40, 8, true, NOW()),
('l_2eso_t1_u3_02', '2eso_t1_u3', 2, 'reading', 'Metodos de entrenamiento', 'Aprende metodos para mejorar resistencia, velocidad, fuerza y flexibilidad.', 300, 45, 8, true, NOW()),
('l_2eso_t1_u3_03', '2eso_t1_u3', 3, 'flashcard', 'Registro de progresos', 'Repasa como llevar un registro de tus marcas y evaluar tu mejora.', 180, 30, 5, true, NOW()),
('l_2eso_t1_u3_04', '2eso_t1_u3', 4, 'quiz', 'Condicion fisica', 'Pon a prueba tu conocimiento sobre las capacidades fisicas basicas.', 240, 50, 10, true, NOW()),

-- 2ESO T1 U4: Deportes alternativos I
('l_2eso_t1_u4_01', '2eso_t1_u4', 1, 'video', 'Ultimate frisbee en equipo', 'Aprende las reglas y tecnicas del ultimate frisbee.', 240, 35, 5, true, NOW()),
('l_2eso_t1_u4_02', '2eso_t1_u4', 2, 'reading', 'Colpbol: todos participan', 'Descubre el colpbol, un deporte alternativo donde todos juegan en equipo.', 240, 40, 5, true, NOW()),
('l_2eso_t1_u4_03', '2eso_t1_u4', 3, 'flashcard', 'Datchball: esquivar y lanzar', 'Conoce las reglas del datchball y estrategias basicas.', 180, 30, 3, true, NOW()),
('l_2eso_t1_u4_04', '2eso_t1_u4', 4, 'quiz', 'Deportes alternativos I', 'Demuestra lo que sabes sobre ultimate, colpbol y datchball.', 180, 45, 8, true, NOW()),

-- 2ESO T1 U5: Deportes alternativos II
('l_2eso_t1_u5_01', '2eso_t1_u5', 1, 'video', 'Crea tu propio deporte', 'Aprende los pasos para disenar un juego alternativo con tu equipo.', 240, 35, 5, true, NOW()),
('l_2eso_t1_u5_02', '2eso_t1_u5', 2, 'reading', 'Como organizar un torneo', 'Descubre como organizar un torneo deportivo alternativo.', 240, 40, 5, true, NOW()),
('l_2eso_t1_u5_03', '2eso_t1_u5', 3, 'flashcard', 'Reglamentos creativos', 'Repasa las claves para crear reglamentos equilibrados y divertidos.', 180, 30, 3, true, NOW()),
('l_2eso_t1_u5_04', '2eso_t1_u5', 4, 'quiz', 'Creador de juegos', 'Pon a prueba tu creatividad y conocimiento sobre diseno de juegos.', 180, 45, 8, true, NOW()),

-- 2ESO T2 U1: Gimnastas II
('l_2eso_t2_u1_01', '2eso_t2_u1', 1, 'video', 'Secuencias gimnasticas', 'Aprende a encadenar volteos, equilibrios y apoyos en secuencias fluidas.', 240, 35, 5, true, NOW()),
('l_2eso_t2_u1_02', '2eso_t2_u1', 2, 'reading', 'Apoyos y balances', 'Descubre tecnicas de apoyo invertido y balances sobre diferentes superficies.', 240, 40, 5, true, NOW()),
('l_2eso_t2_u1_03', '2eso_t2_u1', 3, 'flashcard', 'Ayudas en gimnasia', 'Repasa las tecnicas de ayuda y seguridad para practicar gimnasia en pareja.', 180, 30, 3, true, NOW()),
('l_2eso_t2_u1_04', '2eso_t2_u1', 4, 'quiz', 'Gimnasia avanzada', 'Pon a prueba tu conocimiento sobre habilidades gimnasticas.', 180, 45, 8, true, NOW()),

-- 2ESO T2 U2: Acrosport
('l_2eso_t2_u2_01', '2eso_t2_u2', 1, 'video', 'Acrosport: figuras basicas', 'Descubre las figuras basicas de acrosport por parejas y trios.', 240, 35, 5, true, NOW()),
('l_2eso_t2_u2_02', '2eso_t2_u2', 2, 'reading', 'Roles en acrosport', 'Aprende los roles de portor, agil y ayudante en la construccion de figuras.', 240, 40, 5, true, NOW()),
('l_2eso_t2_u2_03', '2eso_t2_u2', 3, 'flashcard', 'Transiciones y piramides', 'Repasa como realizar transiciones fluidas entre figuras.', 180, 30, 3, true, NOW()),
('l_2eso_t2_u2_04', '2eso_t2_u2', 4, 'quiz', 'Acrosport', 'Demuestra tu conocimiento sobre acrosport y construccion de figuras.', 180, 45, 8, true, NOW()),

-- 2ESO T2 U3: Bailes del mundo
('l_2eso_t2_u3_01', '2eso_t2_u3', 1, 'video', 'Bailes del mundo', 'Descubre bailes tradicionales de diferentes culturas y continentes.', 240, 30, 5, true, NOW()),
('l_2eso_t2_u3_02', '2eso_t2_u3', 2, 'reading', 'Pasos basicos y ritmo', 'Aprende pasos basicos de bailes modernos y tradicionales.', 240, 35, 5, true, NOW()),
('l_2eso_t2_u3_03', '2eso_t2_u3', 3, 'flashcard', 'Cultura y danza', 'Repasa la relacion entre la danza y la cultura de los pueblos.', 180, 25, 3, true, NOW()),
('l_2eso_t2_u3_04', '2eso_t2_u3', 4, 'quiz', 'Bailes del mundo', 'Pon a prueba tu conocimiento sobre danzas y bailes tradicionales.', 180, 40, 8, true, NOW()),

-- 2ESO T2 U4: Primeros auxilios
('l_2eso_t2_u4_01', '2eso_t2_u4', 1, 'video', 'PAS: Proteger, Avisar, Socorrer', 'Repasa la conducta PAS con ejemplos practicos y simulaciones.', 240, 35, 5, true, NOW()),
('l_2eso_t2_u4_02', '2eso_t2_u4', 2, 'reading', 'Vendajes y posicion lateral', 'Aprende a realizar vendajes basicos y colocar en posicion lateral de seguridad.', 240, 40, 5, true, NOW()),
('l_2eso_t2_u4_03', '2eso_t2_u4', 3, 'flashcard', 'Actuacion ante lesiones', 'Repasa como actuar ante esguinces, fracturas y heridas.', 180, 30, 3, true, NOW()),
('l_2eso_t2_u4_04', '2eso_t2_u4', 4, 'quiz', 'Primeros auxilios avanzados', 'Demuestra tu conocimiento avanzado sobre primeros auxilios.', 180, 45, 8, true, NOW()),

-- 2ESO T2 U5: Deportes colectivos
('l_2eso_t2_u5_01', '2eso_t2_u5', 1, 'video', 'Tactica en deportes colectivos', 'Descubre principios tacticos basicos: ataque, defensa y transiciones.', 300, 40, 8, true, NOW()),
('l_2eso_t2_u5_02', '2eso_t2_u5', 2, 'reading', 'Sistemas de juego', 'Aprende sistemas de juego sencillos en baloncesto, futbol sala y voleibol.', 300, 45, 8, true, NOW()),
('l_2eso_t2_u5_03', '2eso_t2_u5', 3, 'flashcard', 'Comunicacion en cancha', 'Repasa claves de comunicacion verbal y no verbal durante el juego.', 180, 30, 5, true, NOW()),
('l_2eso_t2_u5_04', '2eso_t2_u5', 4, 'quiz', 'Deportes colectivos', 'Pon a prueba tu conocimiento tactico sobre deportes de equipo.', 240, 50, 10, true, NOW()),

-- 2ESO T3 U1: Juegos que nos unen
('l_2eso_t3_u1_01', '2eso_t3_u1', 1, 'video', 'Juegos cooperativos', 'Descubre juegos donde todos ganan si trabajan juntos.', 180, 30, 5, true, NOW()),
('l_2eso_t3_u1_02', '2eso_t3_u1', 2, 'reading', 'Confianza y cohesion', 'Aprende dinamicas para generar confianza y cohesion en tu grupo.', 240, 35, 5, true, NOW()),
('l_2eso_t3_u1_03', '2eso_t3_u1', 3, 'flashcard', 'Valores del juego', 'Repasa los valores que se desarrollan jugando: respeto, inclusion, diversion.', 180, 25, 3, true, NOW()),
('l_2eso_t3_u1_04', '2eso_t3_u1', 4, 'quiz', 'Juegos que nos unen', 'Demuestra lo que sabes sobre juegos cooperativos.', 180, 40, 8, true, NOW()),

-- 2ESO T3 U2: Badminton avanzado
('l_2eso_t3_u2_01', '2eso_t3_u2', 1, 'video', 'Badminton: tecnica avanzada', 'Perfecciona tu tecnica de golpeo en badminton: clear, smash y drop.', 240, 35, 5, true, NOW()),
('l_2eso_t3_u2_02', '2eso_t3_u2', 2, 'reading', 'Estrategia en la pista', 'Aprende a leer el juego y anticipar los movimientos de tu rival.', 240, 40, 5, true, NOW()),
('l_2eso_t3_u2_03', '2eso_t3_u2', 3, 'flashcard', 'Reglas de competicion', 'Repasa las reglas oficiales de badminton para torneos.', 180, 30, 3, true, NOW()),
('l_2eso_t3_u2_04', '2eso_t3_u2', 4, 'quiz', 'Badminton avanzado', 'Pon a prueba tu conocimiento avanzado de badminton.', 180, 45, 8, true, NOW()),

-- 2ESO T3 U3: Nuevos deportes
('l_2eso_t3_u3_01', '2eso_t3_u3', 1, 'video', 'Colpbol en accion', 'Descubre el colpbol, un deporte alternativo de equipo donde todos suman.', 240, 35, 5, true, NOW()),
('l_2eso_t3_u3_02', '2eso_t3_u3', 2, 'reading', 'Indiaca: el volante de colores', 'Aprende a jugar con la indiaca, un deporte alternativo de origen brasileno.', 240, 40, 5, true, NOW()),
('l_2eso_t3_u3_03', '2eso_t3_u3', 3, 'flashcard', 'Deportes alternativos', 'Repasa las normas de colpbol, ultimate e indiaca.', 180, 30, 3, true, NOW()),
('l_2eso_t3_u3_04', '2eso_t3_u3', 4, 'quiz', 'Nuevos deportes', 'Demuestra cuanto sabes sobre deportes alternativos.', 180, 45, 8, true, NOW()),

-- 2ESO T3 U4: Orientacion
('l_2eso_t3_u4_01', '2eso_t3_u4', 1, 'video', 'Orientacion con mapa y brujula', 'Aprende a usar el mapa y la brujula para orientarte en cualquier lugar.', 240, 35, 5, true, NOW()),
('l_2eso_t3_u4_02', '2eso_t3_u4', 2, 'reading', 'Planifica tu ruta', 'Descubre como planificar una ruta de orientacion paso a paso.', 240, 40, 5, true, NOW()),
('l_2eso_t3_u4_03', '2eso_t3_u4', 3, 'flashcard', 'Senales y codigos', 'Repasa las senales internacionales de orientacion.', 180, 30, 3, true, NOW()),
('l_2eso_t3_u4_04', '2eso_t3_u4', 4, 'quiz', 'Orientacion avanzada', 'Pon a prueba tu conocimiento sobre orientacion y brujula.', 180, 45, 8, true, NOW()),

-- 2ESO T3 U5: Mini-olimpiadas
('l_2eso_t3_u5_01', '2eso_t3_u5', 1, 'video', 'Mini-olimpiadas escolares', 'Descubre como se organiza un evento multideportivo escolar.', 240, 40, 8, true, NOW()),
('l_2eso_t3_u5_02', '2eso_t3_u5', 2, 'reading', 'Valores olimpicos', 'Aprende sobre los valores del olimpismo: excelencia, amistad y respeto.', 240, 45, 8, true, NOW()),
('l_2eso_t3_u5_03', '2eso_t3_u5', 3, 'flashcard', 'Ceremonia de clausura', 'Repasa como organizar un cierre deportivo con reflexion y celebracion.', 180, 30, 5, true, NOW()),
('l_2eso_t3_u5_04', '2eso_t3_u5', 4, 'quiz', 'Mini-olimpiadas', 'Demuestra tu conocimiento sobre organizacion de eventos y valores olimpicos.', 240, 50, 10, true, NOW());


-- 3ESO T1 U1: Diseno mi calentamiento
('l_3eso_t1_u1_01', '3eso_t1_u1', 1, 'video', 'Principios del calentamiento', 'Descubre los principios fisiologicos del calentamiento y su efecto en el rendimiento.', 240, 40, 8, true, NOW()),
('l_3eso_t1_u1_02', '3eso_t1_u1', 2, 'reading', 'Diseno y direccion', 'Aprende a disenar y dirigir un calentamiento completo para cualquier deporte.', 300, 45, 8, true, NOW()),
('l_3eso_t1_u1_03', '3eso_t1_u1', 3, 'flashcard', 'Calentamiento especifico', 'Repasa ejemplos de calentamientos especificos para diferentes deportes.', 180, 30, 5, true, NOW()),
('l_3eso_t1_u1_04', '3eso_t1_u1', 4, 'quiz', 'Diseno de calentamiento', 'Pon a prueba tu capacidad para disenar calentamientos.', 240, 55, 12, true, NOW()),

-- 3ESO T1 U2: Aparato locomotor avanzado
('l_3eso_t1_u2_01', '3eso_t1_u2', 1, 'video', 'Biomecanica del movimiento', 'Analiza los movimientos deportivos desde una perspectiva biomecanica.', 240, 40, 8, true, NOW()),
('l_3eso_t1_u2_02', '3eso_t1_u2', 2, 'reading', 'Gestos tecnicos y anatomia', 'Relaciona los gestos tecnicos deportivos con musculos y articulaciones.', 300, 45, 8, true, NOW()),
('l_3eso_t1_u2_03', '3eso_t1_u2', 3, 'flashcard', 'Prevencion de lesiones', 'Repasa las lesiones mas comunes y como prevenirlas con buena tecnica.', 180, 30, 5, true, NOW()),
('l_3eso_t1_u2_04', '3eso_t1_u2', 4, 'quiz', 'Anatomia funcional', 'Demuestra tu conocimiento sobre la anatomia aplicada al deporte.', 240, 55, 12, true, NOW()),

-- 3ESO T1 U3: Entreno mi cuerpo
('l_3eso_t1_u3_01', '3eso_t1_u3', 1, 'video', 'Metodos de entrenamiento', 'Descubre los metodos de entrenamiento: continuo, intervalico y circuitos.', 300, 45, 8, true, NOW()),
('l_3eso_t1_u3_02', '3eso_t1_u3', 2, 'reading', 'Circuitos funcionales', 'Aprende a disenar circuitos de entrenamiento funcional por estaciones.', 300, 50, 10, true, NOW()),
('l_3eso_t1_u3_03', '3eso_t1_u3', 3, 'flashcard', 'Dosificacion del esfuerzo', 'Repasa como medir y dosificar la intensidad del entrenamiento.', 240, 35, 5, true, NOW()),
('l_3eso_t1_u3_04', '3eso_t1_u3', 4, 'quiz', 'Metodos de entrenamiento', 'Pon a prueba tu conocimiento sobre metodos de entrenamiento.', 240, 55, 12, true, NOW()),

-- 3ESO T1 U4: Soy mi propio entrenador
('l_3eso_t1_u4_01', '3eso_t1_u4', 1, 'video', 'Principios del entrenamiento', 'Descubre los principios de progresion, especificidad y recuperacion.', 240, 40, 8, true, NOW()),
('l_3eso_t1_u4_02', '3eso_t1_u4', 2, 'reading', 'Disena tu plan personal', 'Aprende a disenar un plan de entrenamiento adaptado a tus objetivos.', 300, 50, 10, true, NOW()),
('l_3eso_t1_u4_03', '3eso_t1_u4', 3, 'flashcard', 'Evaluacion del plan', 'Repasa como evaluar y ajustar tu plan de entrenamiento.', 180, 30, 5, true, NOW()),
('l_3eso_t1_u4_04', '3eso_t1_u4', 4, 'quiz', 'Entrenador personal', 'Demuestra tu capacidad para disenar planes de entrenamiento.', 240, 55, 12, true, NOW()),

-- 3ESO T1 U5: Deportes alternativos
('l_3eso_t1_u5_01', '3eso_t1_u5', 1, 'video', 'Colpbol avanzado', 'Descubre estrategias avanzadas de colpbol para jugar en equipo.', 240, 40, 8, true, NOW()),
('l_3eso_t1_u5_02', '3eso_t1_u5', 2, 'reading', 'Kin-ball adaptado', 'Aprende a jugar al kin-ball, el deporte del balon gigante.', 240, 45, 8, true, NOW()),
('l_3eso_t1_u5_03', '3eso_t1_u5', 3, 'flashcard', 'Ultimate: espiritu de juego', 'Repasa el espiritu de juego del ultimate: autogestion y respeto.', 180, 30, 5, true, NOW()),
('l_3eso_t1_u5_04', '3eso_t1_u5', 4, 'quiz', 'Alternativos avanzados', 'Pon a prueba tu conocimiento sobre deportes alternativos.', 240, 55, 12, true, NOW()),

-- 3ESO T2 U1: Gimnastas en evolucion
('l_3eso_t2_u1_01', '3eso_t2_u1', 1, 'video', 'Secuencias gimnasticas avanzadas', 'Aprende a crear secuencias combinando volteos, equilibrios y apoyos.', 240, 40, 8, true, NOW()),
('l_3eso_t2_u1_02', '3eso_t2_u1', 2, 'reading', 'Creatividad en la gimnasia', 'Descubre como anadir elementos creativos a tus secuencias.', 300, 45, 8, true, NOW()),
('l_3eso_t2_u1_03', '3eso_t2_u1', 3, 'flashcard', 'Seguridad avanzada', 'Repasa protocolos de seguridad para secuencias gimnasticas complejas.', 180, 30, 5, true, NOW()),
('l_3eso_t2_u1_04', '3eso_t2_u1', 4, 'quiz', 'Gimnasia en evolucion', 'Pon a prueba tu conocimiento sobre secuencias gimnasticas.', 240, 55, 12, true, NOW()),

-- 3ESO T2 U2: Expresion corporal
('l_3eso_t2_u2_01', '3eso_t2_u2', 1, 'video', 'Bailes urbanos', 'Descubre los fundamentos del baile urbano y sus estilos principales.', 240, 35, 5, true, NOW()),
('l_3eso_t2_u2_02', '3eso_t2_u2', 2, 'reading', 'Coreografia grupal', 'Aprende a crear una coreografia grupal paso a paso.', 240, 40, 8, true, NOW()),
('l_3eso_t2_u2_03', '3eso_t2_u2', 3, 'flashcard', 'Estilos de baile', 'Repasa las caracteristicas de diferentes estilos de baile moderno.', 180, 25, 5, true, NOW()),
('l_3eso_t2_u2_04', '3eso_t2_u2', 4, 'quiz', 'Baile y expresion', 'Demuestra tu conocimiento sobre bailes modernos y coreografia.', 180, 45, 10, true, NOW()),

-- 3ESO T2 U3: Acrosport creativo
('l_3eso_t2_u3_01', '3eso_t2_u3', 1, 'video', 'Acrosport: figuras en trio', 'Aprende figuras de acrosport en trio y cuarteto con transiciones.', 240, 40, 8, true, NOW()),
('l_3eso_t2_u3_02', '3eso_t2_u3', 2, 'reading', 'Coreografia de acrosport', 'Descubre como crear una coreografia completa de acrosport.', 300, 45, 8, true, NOW()),
('l_3eso_t2_u3_03', '3eso_t2_u3', 3, 'flashcard', 'Seguridad en acrosport', 'Repasa las normas de seguridad para portes y piramides.', 180, 30, 5, true, NOW()),
('l_3eso_t2_u3_04', '3eso_t2_u3', 4, 'quiz', 'Acrosport creativo', 'Pon a prueba tu conocimiento sobre acrosport y coreografia.', 240, 55, 12, true, NOW()),

-- 3ESO T2 U4: RCP
('l_3eso_t2_u4_01', '3eso_t2_u4', 1, 'video', 'RCP: reanimacion cardiopulmonar', 'Aprende la secuencia completa de RCP basica.', 240, 40, 8, true, NOW()),
('l_3eso_t2_u4_02', '3eso_t2_u4', 2, 'reading', 'Maniobra de Heimlich', 'Descubre como actuar ante atragantamientos.', 240, 45, 8, true, NOW()),
('l_3eso_t2_u4_03', '3eso_t2_u4', 3, 'flashcard', 'PAS y emergencias', 'Repasa la conducta PAS aplicada a situaciones de emergencia.', 180, 30, 5, true, NOW()),
('l_3eso_t2_u4_04', '3eso_t2_u4', 4, 'quiz', 'Heroes de la vida', 'Demuestra tu conocimiento sobre RCP y emergencias.', 240, 55, 12, true, NOW()),

-- 3ESO T2 U5: Deportes individuales
('l_3eso_t2_u5_01', '3eso_t2_u5', 1, 'video', 'Atletismo escolar', 'Descubre las pruebas de atletismo: carreras, saltos y lanzamientos.', 240, 40, 8, true, NOW()),
('l_3eso_t2_u5_02', '3eso_t2_u5', 2, 'reading', 'Tenis de mesa: tecnica y tactica', 'Aprende los fundamentos del tenis de mesa.', 240, 45, 8, true, NOW()),
('l_3eso_t2_u5_03', '3eso_t2_u5', 3, 'flashcard', 'Badminton avanzado', 'Repasa tecnicas avanzadas de badminton para competicion.', 180, 30, 5, true, NOW()),
('l_3eso_t2_u5_04', '3eso_t2_u5', 4, 'quiz', 'Deportes individuales', 'Pon a prueba tu conocimiento sobre deportes individuales.', 240, 55, 12, true, NOW()),

-- 3ESO T3 U1: Juegos cohesionan
('l_3eso_t3_u1_01', '3eso_t3_u1', 1, 'video', 'Escape room motriz', 'Descubre como crear y superar desafios motrices en equipo.', 240, 35, 5, true, NOW()),
('l_3eso_t3_u1_02', '3eso_t3_u1', 2, 'reading', 'Confianza y cohesion avanzada', 'Aprende dinamicas avanzadas para fortalecer tu grupo.', 240, 40, 8, true, NOW()),
('l_3eso_t3_u1_03', '3eso_t3_u1', 3, 'flashcard', 'Juego y convivencia', 'Repasa como el juego mejora la convivencia y la inclusion.', 180, 25, 3, true, NOW()),
('l_3eso_t3_u1_04', '3eso_t3_u1', 4, 'quiz', 'Juegos que cohesionan', 'Demuestra tu conocimiento sobre dinamicas de grupo.', 180, 45, 10, true, NOW()),

-- 3ESO T3 U2: Predeportes
('l_3eso_t3_u2_01', '3eso_t3_u2', 1, 'video', 'Juegos predeportivos', 'Descubre juegos que te preparan para los deportes colectivos.', 240, 35, 5, true, NOW()),
('l_3eso_t3_u2_02', '3eso_t3_u2', 2, 'reading', 'Del juego al deporte', 'Aprende como los juegos modificados evolucionan hacia deportes reglados.', 240, 40, 8, true, NOW()),
('l_3eso_t3_u2_03', '3eso_t3_u2', 3, 'flashcard', 'Fundamentos tecnicos', 'Repasa los fundamentos tecnicos basicos para deportes colectivos.', 180, 30, 5, true, NOW()),
('l_3eso_t3_u2_04', '3eso_t3_u2', 4, 'quiz', 'Predeportes', 'Pon a prueba tu conocimiento sobre juegos predeportivos.', 180, 45, 10, true, NOW()),

-- 3ESO T3 U3: Futbol y baloncesto
('l_3eso_t3_u3_01', '3eso_t3_u3', 1, 'video', 'Tactica en futbol', 'Descubre sistemas tacticos y estrategias en futbol.', 300, 45, 8, true, NOW()),
('l_3eso_t3_u3_02', '3eso_t3_u3', 2, 'reading', 'Tactica en baloncesto', 'Aprende principios tacticos ofensivos y defensivos en baloncesto.', 300, 50, 10, true, NOW()),
('l_3eso_t3_u3_03', '3eso_t3_u3', 3, 'flashcard', 'Lectura del juego', 'Repasa claves para leer el juego y tomar decisiones rapidas.', 240, 35, 5, true, NOW()),
('l_3eso_t3_u3_04', '3eso_t3_u3', 4, 'quiz', 'Grandes deportes', 'Demuestra tu conocimiento tactico en futbol y baloncesto.', 240, 60, 15, true, NOW()),

-- 3ESO T3 U4: Alternativos
('l_3eso_t3_u4_01', '3eso_t3_u4', 1, 'video', 'Ultimate avanzado', 'Descubre estrategias avanzadas de ultimate frisbee.', 240, 40, 8, true, NOW()),
('l_3eso_t3_u4_02', '3eso_t3_u4', 2, 'reading', 'Crea tu variante deportiva', 'Aprende a modificar reglas para crear nuevas experiencias deportivas.', 240, 45, 8, true, NOW()),
('l_3eso_t3_u4_03', '3eso_t3_u4', 3, 'flashcard', 'Liderazgo en alternativos', 'Repasa como ejercer liderazgo en deportes alternativos.', 180, 30, 5, true, NOW()),
('l_3eso_t3_u4_04', '3eso_t3_u4', 4, 'quiz', 'Alternativos: nueva mirada', 'Pon a prueba tu conocimiento sobre deportes alternativos avanzados.', 240, 55, 12, true, NOW()),

-- 3ESO T3 U5: Orientacion
('l_3eso_t3_u5_01', '3eso_t3_u5', 1, 'video', 'Orientacion avanzada', 'Aprende tecnicas avanzadas de orientacion con mapas topograficos.', 240, 40, 8, true, NOW()),
('l_3eso_t3_u5_02', '3eso_t3_u5', 2, 'reading', 'Planificacion de expediciones', 'Descubre como planificar una salida al entorno natural.', 300, 50, 10, true, NOW()),
('l_3eso_t3_u5_03', '3eso_t3_u5', 3, 'flashcard', 'Seguridad en montana', 'Repasa normas de seguridad para actividades en montana.', 240, 35, 5, true, NOW()),
('l_3eso_t3_u5_04', '3eso_t3_u5', 4, 'quiz', 'Orientacion y aventura', 'Demuestra tu conocimiento en orientacion avanzada.', 240, 60, 15, true, NOW()),

-- 4ESO T1 U1: Lideres del calentamiento
('l_4eso_t1_u1_01', '4eso_t1_u1', 1, 'video', 'Liderazgo en el calentamiento', 'Descubre como liderar un grupo durante el calentamiento.', 240, 40, 8, true, NOW()),
('l_4eso_t1_u1_02', '4eso_t1_u1', 2, 'reading', 'Diseno avanzado de calentamiento', 'Aprende a disenar calentamientos para diferentes deportes y objetivos.', 300, 50, 10, true, NOW()),
('l_4eso_t1_u1_03', '4eso_t1_u1', 3, 'flashcard', 'Evaluacion de calentamientos', 'Repasa criterios para evaluar la calidad de un calentamiento.', 180, 35, 5, true, NOW()),
('l_4eso_t1_u1_04', '4eso_t1_u1', 4, 'quiz', 'Lideres del calentamiento', 'Pon a prueba tu capacidad para disenar y liderar calentamientos.', 240, 55, 12, true, NOW()),

-- 4ESO T1 U2: Cuerpo en detalle
('l_4eso_t1_u2_01', '4eso_t1_u2', 1, 'video', 'Lesiones deportivas frecuentes', 'Descubre las lesiones mas comunes en el deporte y como prevenirlas.', 240, 40, 8, true, NOW()),
('l_4eso_t1_u2_02', '4eso_t1_u2', 2, 'reading', 'Analisis de movimientos', 'Aprende a analizar movimientos deportivos para prevenir lesiones.', 300, 50, 10, true, NOW()),
('l_4eso_t1_u2_03', '4eso_t1_u2', 3, 'flashcard', 'Prevencion y recuperacion', 'Repasa estrategias de prevencion y recuperacion de lesiones.', 180, 35, 5, true, NOW()),
('l_4eso_t1_u2_04', '4eso_t1_u2', 4, 'quiz', 'Cuerpo en detalle', 'Demuestra tu conocimiento sobre anatomia y prevencion de lesiones.', 240, 55, 12, true, NOW()),

-- 4ESO T1 U3: Reto fisico avanzado
('l_4eso_t1_u3_01', '4eso_t1_u3', 1, 'video', 'HIIT y entrenamiento intervalico', 'Descubre el entrenamiento HIIT y como aplicarlo.', 300, 50, 10, true, NOW()),
('l_4eso_t1_u3_02', '4eso_t1_u3', 2, 'reading', 'Circuitos funcionales avanzados', 'Aprende a disenar circuitos funcionales de alta intensidad.', 300, 55, 10, true, NOW()),
('l_4eso_t1_u3_03', '4eso_t1_u3', 3, 'flashcard', 'Autoevaluacion del esfuerzo', 'Repasa escalas de percepcion del esfuerzo y frecuencia cardiaca.', 240, 40, 8, true, NOW()),
('l_4eso_t1_u3_04', '4eso_t1_u3', 4, 'quiz', 'Reto fisico avanzado', 'Pon a prueba tu conocimiento sobre metodos avanzados de entrenamiento.', 300, 65, 15, true, NOW()),

-- 4ESO T1 U4: Cualidades motrices
('l_4eso_t1_u4_01', '4eso_t1_u4', 1, 'video', 'Coordinacion y agilidad', 'Descubre ejercicios para mejorar tu coordinacion y agilidad.', 240, 40, 8, true, NOW()),
('l_4eso_t1_u4_02', '4eso_t1_u4', 2, 'reading', 'Equilibrio dinamico', 'Aprende a mantener el equilibrio en movimiento.', 240, 45, 8, true, NOW()),
('l_4eso_t1_u4_03', '4eso_t1_u4', 3, 'flashcard', 'Ritmo y movimiento', 'Repasa ejercicios ritmicos para mejorar tu sentido del ritmo.', 180, 30, 5, true, NOW()),
('l_4eso_t1_u4_04', '4eso_t1_u4', 4, 'quiz', 'Cualidades motrices', 'Demuestra tu conocimiento sobre cualidades motrices.', 240, 55, 12, true, NOW()),

-- 4ESO T1 U5: Entrenadores en practica
('l_4eso_t1_u5_01', '4eso_t1_u5', 1, 'video', 'Planificacion del entrenamiento', 'Descubre como planificar un ciclo de entrenamiento completo.', 300, 50, 10, true, NOW()),
('l_4eso_t1_u5_02', '4eso_t1_u5', 2, 'reading', 'Apps y wearables', 'Aprende a usar herramientas digitales para registrar tu entrenamiento.', 240, 50, 10, true, NOW()),
('l_4eso_t1_u5_03', '4eso_t1_u5', 3, 'flashcard', 'Periodizacion basica', 'Repasa los conceptos de macrociclo, mesociclo y microciclo.', 240, 40, 8, true, NOW()),
('l_4eso_t1_u5_04', '4eso_t1_u5', 4, 'quiz', 'Entrenadores en practica', 'Pon a prueba tu capacidad para planificar entrenamientos.', 300, 65, 15, true, NOW()),

-- 4ESO T2 U1: Gimnasia en progresion
('l_4eso_t2_u1_01', '4eso_t2_u1', 1, 'video', 'Secuencias gimnasticas por parejas', 'Aprende a crear rutinas gimnasticas sincronizadas en pareja.', 240, 40, 8, true, NOW()),
('l_4eso_t2_u1_02', '4eso_t2_u1', 2, 'reading', 'Elementos acrobaticos', 'Descubre elementos acrobaticos avanzados con seguridad.', 300, 50, 10, true, NOW()),
('l_4eso_t2_u1_03', '4eso_t2_u1', 3, 'flashcard', 'Ayudas avanzadas', 'Repasa tecnicas avanzadas de ayuda y seguridad.', 180, 35, 5, true, NOW()),
('l_4eso_t2_u1_04', '4eso_t2_u1', 4, 'quiz', 'Gimnasia en progresion', 'Pon a prueba tu conocimiento sobre gimnasia avanzada.', 240, 55, 12, true, NOW()),

-- 4ESO T2 U2: Teatro fisico
('l_4eso_t2_u2_01', '4eso_t2_u2', 1, 'video', 'Teatro fisico', 'Descubre el teatro fisico como forma de expresion corporal.', 240, 40, 8, true, NOW()),
('l_4eso_t2_u2_02', '4eso_t2_u2', 2, 'reading', 'Creacion de personajes', 'Aprende a crear personajes y contar historias con tu cuerpo.', 300, 45, 8, true, NOW()),
('l_4eso_t2_u2_03', '4eso_t2_u2', 3, 'flashcard', 'Improvisacion escenica', 'Repasa tecnicas de improvisacion teatral con movimiento.', 180, 30, 5, true, NOW()),
('l_4eso_t2_u2_04', '4eso_t2_u2', 4, 'quiz', 'Cuerpos que cuentan historias', 'Demuestra tu conocimiento sobre teatro fisico y expresion.', 240, 55, 12, true, NOW()),

-- 4ESO T2 U3: Primeros auxilios
('l_4eso_t2_u3_01', '4eso_t2_u3', 1, 'video', 'RCP en adultos y ninos', 'Aprende las diferencias en RCP segun la edad.', 240, 45, 8, true, NOW()),
('l_4eso_t2_u3_02', '4eso_t2_u3', 2, 'reading', 'Atragantamientos y desobstruccion', 'Descubre como actuar ante atragantamientos en cualquier edad.', 240, 50, 10, true, NOW()),
('l_4eso_t2_u3_03', '4eso_t2_u3', 3, 'flashcard', 'Lesiones deportivas agudas', 'Repasa actuacion en lesiones deportivas comunes.', 180, 35, 5, true, NOW()),
('l_4eso_t2_u3_04', '4eso_t2_u3', 4, 'quiz', 'Se actuar: primeros auxilios', 'Pon a prueba tu conocimiento avanzado en primeros auxilios.', 240, 60, 15, true, NOW()),

-- 4ESO T2 U4: Tactica colectiva
('l_4eso_t2_u4_01', '4eso_t2_u4', 1, 'video', 'Sistemas tacticos avanzados', 'Descubre sistemas de juego en deportes colectivos.', 300, 45, 8, true, NOW()),
('l_4eso_t2_u4_02', '4eso_t2_u4', 2, 'reading', 'Roles de liderazgo en equipo', 'Aprende a ejercer liderazgo en el campo de juego.', 300, 50, 10, true, NOW()),
('l_4eso_t2_u4_03', '4eso_t2_u4', 3, 'flashcard', 'Lectura avanzada del juego', 'Repasa como anticipar jugadas y tomar decisiones.', 240, 35, 5, true, NOW()),
('l_4eso_t2_u4_04', '4eso_t2_u4', 4, 'quiz', 'Tactica y estrategia', 'Pon a prueba tu conocimiento tactico en deportes colectivos.', 240, 60, 15, true, NOW()),

-- 4ESO T2 U5: Torneo deportivo
('l_4eso_t2_u5_01', '4eso_t2_u5', 1, 'video', 'Organizacion de torneos', 'Aprende a organizar un torneo deportivo completo.', 240, 45, 8, true, NOW()),
('l_4eso_t2_u5_02', '4eso_t2_u5', 2, 'reading', 'Etica y deportividad', 'Reflexiona sobre la importancia de la deportividad en competicion.', 240, 50, 10, true, NOW()),
('l_4eso_t2_u5_03', '4eso_t2_u5', 3, 'flashcard', 'Gestion emocional', 'Repasa tecnicas para gestionar las emociones en competicion.', 180, 35, 5, true, NOW()),
('l_4eso_t2_u5_04', '4eso_t2_u5', 4, 'quiz', 'Torneo deportivo', 'Demuestra tu conocimiento sobre organizacion y etica deportiva.', 240, 60, 15, true, NOW()),

-- 4ESO T3 U1: Juegos convivir
('l_4eso_t3_u1_01', '4eso_t3_u1', 1, 'video', 'Escape room motriz', 'Descubre como crear y superar desafios motrices en equipo.', 240, 35, 5, true, NOW()),
('l_4eso_t3_u1_02', '4eso_t3_u1', 2, 'reading', 'Juegos de confianza', 'Aprende juegos que generan confianza entre companeros.', 240, 40, 8, true, NOW()),
('l_4eso_t3_u1_03', '4eso_t3_u1', 3, 'flashcard', 'Convivencia y juego', 'Repasa como el juego inclusivo mejora la convivencia.', 180, 25, 3, true, NOW()),
('l_4eso_t3_u1_04', '4eso_t3_u1', 4, 'quiz', 'Juegos para convivir', 'Demuestra tu conocimiento sobre juegos de convivencia.', 180, 45, 10, true, NOW()),

-- 4ESO T3 U2: Predeportes
('l_4eso_t3_u2_01', '4eso_t3_u2', 1, 'video', 'Predeportes en accion', 'Descubre juegos modificados que preparan para el deporte.', 240, 35, 5, true, NOW()),
('l_4eso_t3_u2_02', '4eso_t3_u2', 2, 'reading', 'Del juego modificado al reglado', 'Aprende la transicion del juego libre al deporte oficial.', 240, 40, 8, true, NOW()),
('l_4eso_t3_u2_03', '4eso_t3_u2', 3, 'flashcard', 'Fundamentos predeportivos', 'Repasa los fundamentos basicos para deportes colectivos.', 180, 30, 5, true, NOW()),
('l_4eso_t3_u2_04', '4eso_t3_u2', 4, 'quiz', 'Predeportes en accion', 'Pon a prueba tu conocimiento sobre juegos predeportivos.', 180, 45, 10, true, NOW()),

-- 4ESO T3 U3: Grandes deportes
('l_4eso_t3_u3_01', '4eso_t3_u3', 1, 'video', 'Balonmano: tecnica y tactica', 'Descubre los fundamentos del balonmano.', 300, 45, 8, true, NOW()),
('l_4eso_t3_u3_02', '4eso_t3_u3', 2, 'reading', 'Voleibol: saque, recepcion y remate', 'Aprende los fundamentos del voleibol.', 300, 50, 10, true, NOW()),
('l_4eso_t3_u3_03', '4eso_t3_u3', 3, 'flashcard', 'Hockey y rugby escolar', 'Repasa las reglas basicas de hockey y rugby adaptado.', 240, 35, 5, true, NOW()),
('l_4eso_t3_u3_04', '4eso_t3_u3', 4, 'quiz', 'Grandes deportes variados', 'Demuestra tu conocimiento sobre balonmano, voleibol, hockey y rugby.', 300, 65, 15, true, NOW()),

-- 4ESO T3 U4: Alternativos inclusivos
('l_4eso_t3_u4_01', '4eso_t3_u4', 1, 'video', 'Deportes inclusivos', 'Descubre como los deportes alternativos promueven la inclusion.', 240, 40, 8, true, NOW()),
('l_4eso_t3_u4_02', '4eso_t3_u4', 2, 'reading', 'Adaptacion de reglamentos', 'Aprende a adaptar reglas para hacer deportes mas inclusivos.', 240, 45, 8, true, NOW()),
('l_4eso_t3_u4_03', '4eso_t3_u4', 3, 'flashcard', 'Juego universal', 'Repasa como eliminar barreras en la practica deportiva.', 180, 30, 5, true, NOW()),
('l_4eso_t3_u4_04', '4eso_t3_u4', 4, 'quiz', 'Alternativos e inclusivos', 'Pon a prueba tu conocimiento sobre deportes inclusivos.', 240, 55, 12, true, NOW()),

-- 4ESO T3 U5: Badminton y orientacion
('l_4eso_t3_u5_01', '4eso_t3_u5', 1, 'video', 'Badminton de competicion', 'Perfecciona tu tecnica de badminton para torneos.', 240, 45, 8, true, NOW()),
('l_4eso_t3_u5_02', '4eso_t3_u5', 2, 'reading', 'Orientacion en entorno natural', 'Aplica tecnicas de orientacion en espacios naturales reales.', 300, 50, 10, true, NOW()),
('l_4eso_t3_u5_03', '4eso_t3_u5', 3, 'flashcard', 'El legado del heroe', 'Repasa todo lo aprendido en tu viaje por EF Quest.', 240, 40, 8, true, NOW()),
('l_4eso_t3_u5_04', '4eso_t3_u5', 4, 'quiz', 'El Legado del Heroe', 'La prueba final: demuestra todo lo que has aprendido en la ESO.', 360, 100, 25, true, NOW());


-- ============================================================
-- RETOS FISICOS (2 por unidad, 120 total)
-- ============================================================

INSERT INTO challenges (id, unit_id, "order", type, title, description, difficulty, goal_type, goal_value, min_value, max_value, adaptive_enabled, adaptive_base_value, adaptive_increment, adaptive_max_value, xp_reward, xp_three_stars, intro_text, success_text, fail_text, is_active, created_at) VALUES

-- 1ESO T1 U1: Entreno mi cuerpo
('ch_1eso_t1_u1_01', '1eso_t1_u1', 1, 'cardio', 'Carrera del Calentamiento', 'Corre suavemente durante 3 minutos manteniendo un ritmo constante. Tu corazon te guiara.', 'facil', 'duration', 180, 120, 300, true, 120, 15, 360, 50, 80, 'Preparate para moverte. Siente como tu cuerpo se activa.', 'Excelente calentamiento! Tu corazon esta listo para la accion.', 'No te preocupes. Cada vez que intentas, tu cuerpo se prepara mejor.', true, NOW()),
('ch_1eso_t1_u1_02', '1eso_t1_u1', 2, 'coordination', 'Activacion Corporal', 'Realiza 10 saltos de estrella seguidos manteniendo el ritmo y la coordinacion.', 'facil', 'reps', 10, 5, 20, true, 5, 2, 30, 40, 70, 'Activa cada parte de tu cuerpo. Energia al maximo!', 'Activacion completa! Tu cuerpo esta preparado.', 'Sigue intentando. Cada salto cuenta.', true, NOW()),

-- 1ESO T1 U2: Aparato locomotor
('ch_1eso_t1_u2_01', '1eso_t1_u2', 1, 'coordination', 'Equilibrio Corporal', 'Manten el equilibrio sobre una pierna el maximo tiempo posible. Concentrate y respira.', 'facil', 'duration', 30, 15, 60, true, 15, 5, 90, 40, 70, 'Encuentra tu centro de gravedad.', 'Equilibrio perfecto! Tu control corporal es excelente.', 'Sigue practicando. Mejoraras cada dia.', true, NOW()),
('ch_1eso_t1_u2_02', '1eso_t1_u2', 2, 'strength', 'El Puente Corporal', 'Manten la posicion de plancha el maximo tiempo posible. Core firme!', 'facil', 'duration', 30, 15, 60, true, 15, 5, 90, 50, 80, 'Cuerpo recto como una tabla.', 'Core de acero! Tu fuerza estabilizadora es genial.', 'Cada segundo cuenta. Sigue practicando.', true, NOW()),

-- 1ESO T1 U3: Resistencia y velocidad
('ch_1eso_t1_u3_01', '1eso_t1_u3', 1, 'cardio', 'Carrera Continua', 'Corre sin parar durante 5 minutos. Manten un ritmo constante.', 'medio', 'duration', 300, 180, 480, true, 180, 30, 600, 60, 100, 'Respira hondo. Tu cuerpo puede mas de lo que crees.', 'Resistencia increible! Tu corazon es fuerte.', 'Sigue entrenando. Cada minuto cuenta.', true, NOW()),
('ch_1eso_t1_u3_02', '1eso_t1_u3', 2, 'coordination', 'Velocidad de Reaccion', 'Realiza 5 sprints de 20 metros. Descansa 30 seg entre cada uno.', 'medio', 'reps', 5, 3, 8, true, 3, 1, 10, 50, 90, 'Explota! Salida rapida y aceleracion maxima.', 'Velocidad fulgurante! Tus reflejos son asombrosos.', 'La velocidad se entrena. Sigue practicando.', true, NOW()),

-- 1ESO T1 U4: Fuerza y flexibilidad
('ch_1eso_t1_u4_01', '1eso_t1_u4', 1, 'strength', 'Fuerza Basica', 'Realiza el maximo numero de sentadillas posible en 1 minuto.', 'facil', 'reps', 15, 10, 30, true, 10, 2, 40, 50, 80, 'Flexiona las rodillas. Arriba y abajo con ritmo.', 'Fuerza explosiva! Tus piernas son potentes.', 'Sigue practicando. La fuerza llega con constancia.', true, NOW()),
('ch_1eso_t1_u4_02', '1eso_t1_u4', 2, 'coordination', 'Flexibilidad al Maximo', 'Alcanza la mayor distancia posible en el test de Sit and Reach.', 'facil', 'reps', 15, 5, 30, true, 5, 3, 40, 40, 70, 'Estira los brazos. Exhalar y estirar.', 'Flexibilidad excelente! Tu amplitud de movimiento es genial.', 'La flexibilidad necesita constancia. Sigue estirando.', true, NOW()),

-- 1ESO T1 U5: Juegos tradicionales
('ch_1eso_t1_u5_01', '1eso_t1_u5', 1, 'coordination', 'Relevos Cooperativos', 'Completa el circuito de relevos con tu equipo. Comunicacion clave.', 'facil', 'reps', 8, 4, 12, true, 4, 1, 15, 50, 80, 'Pasad el testigo. Animaos unos a otros.', 'Equipo imparable! La coordinacion os ha llevado a la victoria.', 'Seguid practicando la comunicacion.', true, NOW()),
('ch_1eso_t1_u5_02', '1eso_t1_u5', 2, 'coordination', 'El Circulo de la Fuerza', 'Pasa la pelota alrededor del circulo sin que caiga al suelo.', 'facil', 'reps', 20, 10, 40, true, 10, 2, 50, 40, 70, 'Formad el circulo. Mirad a los ojos. Pase!', 'Sincronizacion perfecta!', 'La practica hace al maestro.', true, NOW()),

-- 1ESO T2 U1: Gimnastas
('ch_1eso_t2_u1_01', '1eso_t2_u1', 1, 'coordination', 'Volteos en Linea', 'Realiza 3 volteos adelante seguidos con buena tecnica.', 'medio', 'reps', 3, 1, 5, true, 1, 1, 6, 50, 90, 'Menton al pecho. Espalda redonda.', 'Volteos perfectos! Tu tecnica gimnastica mejora.', 'Practica la tecnica antes de la velocidad.', true, NOW()),
('ch_1eso_t2_u1_02', '1eso_t2_u1', 2, 'strength', 'Equilibrio Estatico', 'Manten el equilibrio sobre un pie con ojos cerrados.', 'medio', 'duration', 20, 10, 45, true, 10, 5, 60, 40, 70, 'Encuentra tu centro. Cierra los ojos.', 'Equilibrio de acero! Tu propiocepcion es genial.', 'El equilibrio se entrena en silencio.', true, NOW()),

-- 1ESO T2 U2: Expresion y ritmo
('ch_1eso_t2_u2_01', '1eso_t2_u2', 1, 'coordination', 'Sigue el Ritmo', 'Repite la secuencia de pasos marcada por el profesor. 10 repeticiones correctas.', 'facil', 'reps', 10, 5, 20, true, 5, 2, 30, 40, 70, 'Escucha la musica. Dejate llevar.', 'Ritmo perfecto! Tu coordinacion musical es fantastica.', 'Siente el ritmo en tu cuerpo.', true, NOW()),
('ch_1eso_t2_u2_02', '1eso_t2_u2', 2, 'coordination', 'Coreografia Express', 'Crea y ejecuta una secuencia de 4 movimientos expresivos en 30 segundos.', 'facil', 'reps', 4, 2, 6, true, 2, 1, 8, 50, 80, 'Exprimate. Tu cuerpo habla.', 'Creatividad desbordante! Eres un artista.', 'Cada movimiento cuenta una historia.', true, NOW()),

-- 1ESO T2 U3: Primeros auxilios
('ch_1eso_t2_u3_01', '1eso_t2_u3', 1, 'coordination', 'Simulacion PAS', 'Completa la secuencia PAS (Proteger, Avisar, Socorrer) en una simulacion.', 'facil', 'reps', 3, 1, 5, true, 1, 1, 5, 50, 80, 'Situacion de emergencia. Actua con calma.', 'Heroe en accion! Has aplicado PAS correctamente.', 'Repasa los pasos. La practica salva vidas.', true, NOW()),

-- 1ESO T2 U4: Deportes equipo
('ch_1eso_t2_u4_01', '1eso_t2_u4', 1, 'coordination', 'Pases Precisos', 'Realiza 10 pases contra la pared con precision.', 'facil', 'reps', 10, 5, 20, true, 5, 2, 30, 40, 70, 'Apunta. Calcula la fuerza.', 'Pases de ensueno! Tu precision mejora.', 'La practica perfecciona el pase.', true, NOW()),
('ch_1eso_t2_u4_02', '1eso_t2_u4', 2, 'cardio', 'Partido Reducido', 'Juega un partido 3x3 durante 5 minutos aplicando lo aprendido.', 'medio', 'duration', 300, 180, 480, true, 180, 30, 600, 60, 100, 'Comunicate con tu equipo. Busca espacios.', 'Gran partido! Tu juego en equipo mejora.', 'Sigue practicando los fundamentos.', true, NOW()),

-- 1ESO T2 U5: Torneo
('ch_1eso_t2_u5_01', '1eso_t2_u5', 1, 'cardio', 'Torneo Relampago', 'Participa en un mini-torneo de 3 partidos de 3 minutos cada uno.', 'medio', 'duration', 540, 360, 720, true, 360, 60, 900, 60, 100, 'Tres partidos. Todo tu esfuerzo.', 'Campeon! Has demostrado espiritu deportivo.', 'La competicion ensena y divierte.', true, NOW()),
('ch_1eso_t2_u5_02', '1eso_t2_u5', 2, 'coordination', 'Juego de Roles', 'Asume 3 roles diferentes (base, alero, pivot) durante el torneo.', 'medio', 'reps', 3, 1, 4, true, 1, 1, 5, 50, 90, 'Adaptate a cada rol.', 'Versatilidad total! Eres un jugador completo.', 'Cada rol tiene su importancia.', true, NOW()),

-- 1ESO T3 U1: Alternativos
('ch_1eso_t3_u1_01', '1eso_t3_u1', 1, 'coordination', 'Lanzamiento Frisbee', 'Realiza 5 lanzamientos de frisbee a zona marcada.', 'facil', 'reps', 5, 3, 10, true, 3, 1, 12, 40, 70, 'Sueltalo con giro de muneca.', 'Punteria de precision! El frisbee te obedece.', 'Ajusta la fuerza y el angulo.', true, NOW()),

-- 1ESO T3 U2: Badminton
('ch_1eso_t3_u2_01', '1eso_t3_u2', 1, 'coordination', 'Golpeo Continuo', 'Manten el volante en juego dando golpes hacia arriba. Cuantos mas mejor.', 'facil', 'reps', 15, 5, 30, true, 5, 3, 45, 40, 70, 'Golpea suave. Controla el volante.', 'Control absoluto! El volante no toca el suelo.', 'Practica el golpeo suave.', true, NOW()),
('ch_1eso_t3_u2_02', '1eso_t3_u2', 2, 'cardio', 'Partido de Badminton', 'Juega un partido a 11 puntos. Aplica saque, golpeo y desplazamiento.', 'medio', 'duration', 480, 300, 600, true, 300, 30, 720, 60, 100, 'Desplazate. Preparado para el golpe.', 'Gran partido! Tu badminton mejora.', 'Sigue practicando los desplazamientos.', true, NOW()),

-- 1ESO T3 U3: Orientacion
('ch_1eso_t3_u3_01', '1eso_t3_u3', 1, 'cardio', 'Busqueda del Tesoro', 'Encuentra 5 puntos de control en el menor tiempo posible usando el mapa.', 'medio', 'duration', 600, 300, 900, true, 300, 60, 1200, 60, 100, 'Lee el mapa. Orientate. Corre.', 'Tesoro encontrado! Tu orientacion es excelente.', 'Sigue las pistas. No te rindas.', true, NOW()),

-- 1ESO T3 U4: Naturaleza
('ch_1eso_t3_u4_01', '1eso_t3_u4', 1, 'cardio', 'Senderismo Activo', 'Completa el recorrido de senderismo marcado en el menor tiempo posible.', 'medio', 'duration', 900, 600, 1500, true, 600, 60, 1800, 80, 130, 'Ritmo constante. Disfruta del paisaje.', 'Expedicion completada! Eres un aventurero.', 'El camino importa tanto como la meta.', true, NOW()),

-- 1ESO T3 U5: Fiesta deportiva
('ch_1eso_t3_u5_01', '1eso_t3_u5', 1, 'coordination', 'Estacion Multiple', 'Participa en 4 estaciones diferentes de juegos durante la fiesta deportiva.', 'facil', 'reps', 4, 2, 6, true, 2, 1, 8, 50, 80, 'Disfruta cada estacion. Prueba todo.', 'Fiesta completa! Has disfrutado al maximo.', 'Cada estacion es una nueva experiencia.', true, NOW());

-- ============================================================
-- JEFES FINALES (1 por unidad, 60 total)
-- ============================================================

INSERT INTO boss (unit_id, name, description, phase1_name, phase1_type, phase1_hp, phase1_damage, phase2_name, phase2_type, phase2_hp, phase2_damage, phase3_name, phase3_type, phase3_hp, phase3_damage, xp_reward, coin_reward, is_active, created_at) VALUES
('1eso_t1_u1', 'El Guardian del Calentamiento', 'Una antigua estatua que cobra vida para poner a prueba tus conocimientos sobre el calentamiento.', 'Quiz Calentamiento', 'quiz', 8, 2, 'Activacion Fisica', 'movimiento', 12, 4, 'Esfuerzo Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t1_u2', 'El Esqueleto Viviente', 'Un esqueleto gigante que conoce cada hueso de tu cuerpo. Demuestra tu sabiduria anatomica.', 'Quiz Anatomia', 'quiz', 8, 2, 'Circuito Corporal', 'movimiento', 12, 4, 'Dominio del Cuerpo', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t1_u3', 'El Cronometrador Implacable', 'Un reloj humano que mide cada segundo. Solo la resistencia vencera su poder.', 'Quiz Resistencia', 'quiz', 10, 3, 'Carrera Contra el Tiempo', 'movimiento', 14, 5, 'Esfuerzo Maximo', 'esfuerzo', 18, 6, 180, 40, true, NOW()),
('1eso_t1_u4', 'El Arbol de la Flexibilidad', 'Un arbol milenario que estira sus ramas. Tu fuerza y flexibilidad lo venceran.', 'Quiz Fuerza', 'quiz', 10, 3, 'Circuito de Fuerza', 'movimiento', 14, 5, 'Estiramiento Final', 'esfuerzo', 18, 6, 180, 40, true, NOW()),
('1eso_t1_u5', 'El Dragon del Juego Sucio', 'Un dragon que rompe las reglas. La cooperacion y el respeto son tus armas.', 'Quiz Cooperacion', 'quiz', 10, 3, 'Juego en Equipo', 'movimiento', 14, 5, 'Juego Limpio', 'esfuerzo', 20, 7, 200, 40, true, NOW()),
('1eso_t2_u1', 'El Acrobata Invisible', 'Un acrobata que se mueve sin ser visto. Tu equilibrio y giros lo revelaran.', 'Quiz Gimnasia', 'quiz', 8, 2, 'Secuencia Acrobatica', 'movimiento', 12, 4, 'Dominio Aereo', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t2_u2', 'La Sombra Silenciosa', 'Una criatura que copia tus movimientos. Expresate con claridad para vencerla.', 'Quiz Expresion', 'quiz', 8, 2, 'Coreografia Combate', 'movimiento', 12, 4, 'Actuacion Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t2_u3', 'El Guardian de la Seguridad', 'Un guardian que protege a los heridos. Demuestra tu conocimiento en primeros auxilios.', 'Quiz PAS', 'quiz', 8, 2, 'Simulacion Emergencia', 'movimiento', 12, 4, 'Salvamento', 'esfuerzo', 13, 5, 130, 25, true, NOW()),
('1eso_t2_u4', 'El Titan de las Reglas', 'Un gigante que conoce todas las reglas. Un error y te eliminara.', 'Quiz Reglas', 'quiz', 10, 3, 'Partido de Prueba', 'movimiento', 14, 5, 'Regla de Oro', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('1eso_t2_u5', 'El Estratega del Balon', 'Un entrenador implacable. Tu estrategia en equipo determinara la victoria.', 'Quiz Estrategia', 'quiz', 10, 3, 'Partido Tactico', 'movimiento', 14, 5, 'Victoria en Equipo', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('1eso_t3_u1', 'El Inventor de Deportes', 'Un inventor loco que crea deportes imposibles. Tu adaptacion es la clave.', 'Quiz Alternativos', 'quiz', 8, 2, 'Juego Inventado', 'movimiento', 12, 4, 'Creatividad Deportiva', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t3_u2', 'El Saque Imparable', 'Un jugador de badminton que devuelve cada golpe. Tu tecnica lo vencera.', 'Quiz Badminton', 'quiz', 8, 2, 'Intercambio de Golpes', 'movimiento', 12, 4, 'Partido Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t3_u3', 'El Guardian del Norte', 'Un espiritu del norte que desorienta a todos. Tu orientacion te guiara.', 'Quiz Orientacion', 'quiz', 8, 2, 'Busqueda de Balizas', 'movimiento', 12, 4, 'Mapa Maestro', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('1eso_t3_u4', 'El Espiritu del Bosque', 'Un espiritu que protege la naturaleza. Respeta el entorno y vence.', 'Quiz Naturaleza', 'quiz', 10, 3, 'Ruta Ecologica', 'movimiento', 14, 5, 'Conservacion', 'esfuerzo', 20, 7, 200, 40, true, NOW()),
('1eso_t3_u5', 'El Maestro de Ceremonias', 'El anfitrion de la fiesta deportiva. Organiza y celebra con el.', 'Quiz Eventos', 'quiz', 10, 3, 'Organizacion Deportiva', 'movimiento', 14, 5, 'Gran Celebración', 'esfuerzo', 20, 7, 200, 45, true, NOW()),
('2eso_t1_u1', 'El Maestro del Fuego', 'Un maestro que enciende la pasion por el calentamiento. Disena tu mejor rutina.', 'Quiz Calor', 'quiz', 10, 3, 'Calentamiento Guiado', 'movimiento', 14, 5, 'Intensidad Total', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t1_u2', 'El Pulso de Acero', 'Un robot perfecto que conoce cada musculo. Tu conocimiento anatomico es tu mejor arma.', 'Quiz Cuerpo', 'quiz', 10, 3, 'Circuito Muscular', 'movimiento', 14, 5, 'La Maquina Perfecta', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t1_u3', 'El Cronometrador de Almas', 'Un cronometrador que mide tu progreso. Supera tus marcas para vencerlo.', 'Quiz Capacidades', 'quiz', 12, 4, 'Test de Condicion', 'movimiento', 16, 6, 'Marca Personal', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('2eso_t1_u4', 'El Pionero del Juego', 'Un pionero que busca nuevos horizontes. Aprende deportes alternativos con el.', 'Quiz Alternativos', 'quiz', 10, 3, 'Practica Alternativa', 'movimiento', 14, 5, 'Nuevo Deporte', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t1_u5', 'El Creador de Reglas', 'Un ser que inventa reglas. Crea tu propio juego y vencelo.', 'Quiz Creacion', 'quiz', 10, 3, 'Diseno de Juego', 'movimiento', 14, 5, 'Reglamento Final', 'esfuerzo', 20, 7, 200, 40, true, NOW()),
('2eso_t2_u1', 'El Equilibrista del Abismo', 'Un equilibrista que desafia la gravedad. Tu equilibrio superara el abismo.', 'Quiz Gimnasia', 'quiz', 10, 3, 'Secuencia en Banco', 'movimiento', 14, 5, 'Equilibrio Extremo', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t2_u2', 'El Coloso de Fuerza', 'Un gigante de piedra que solo la cooperacion puede derribar.', 'Quiz Acrosport', 'quiz', 10, 3, 'Construccion de Figura', 'movimiento', 14, 5, 'Piramide Final', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t2_u3', 'El Ritmo del Mundo', 'Un ser que baila al ritmo del mundo. Sigue su compas y vencelo.', 'Quiz Danza', 'quiz', 8, 2, 'Coreografia Grupal', 'movimiento', 12, 4, 'Baile Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('2eso_t2_u4', 'El Angel Guardian', 'Un angel que protege. Demuestra tu habilidad para salvar vidas.', 'Quiz Primeros Auxilios', 'quiz', 8, 2, 'Simulacion de Accidente', 'movimiento', 12, 4, 'Mision Rescate', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('2eso_t2_u5', 'El Estratega de Cinco Anillos', 'Un estratega que dirige equipos. Tu tactica colectiva decidira el combate.', 'Quiz Tactica', 'quiz', 12, 4, 'Partido 5c5', 'movimiento', 16, 6, 'Final de Partido', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('2eso_t3_u1', 'El Guardian de la Union', 'Un guardian que promueve la amistad. Los juegos cooperativos son tu camino.', 'Quiz Cooperacion', 'quiz', 8, 2, 'Juego de Confianza', 'movimiento', 12, 4, 'Union de Fuerzas', 'esfuerzo', 13, 5, 130, 25, true, NOW()),
('2eso_t3_u2', 'El Saque Imparable', 'Un jugador de badminton letal. Tu tecnica avanzada es la unica defensa.', 'Quiz Badminton', 'quiz', 10, 3, 'Rally de Golpeos', 'movimiento', 14, 5, 'Partido Estelar', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('2eso_t3_u3', 'El Inventor de Juegos', 'Un inventor que crea deportes locos. Adaptate y vencelo.', 'Quiz Alternativos', 'quiz', 8, 2, 'Juego Sorpresa', 'movimiento', 12, 4, 'Invencion Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('2eso_t3_u4', 'El Yeti del Valle Olvidado', 'Una criatura legendaria de las montanas. Tu orientacion te guiara hasta el.', 'Quiz Orientacion', 'quiz', 10, 3, 'Ruta de Montana', 'movimiento', 14, 5, 'Encuentro con el Yeti', 'esfuerzo', 20, 7, 200, 40, true, NOW()),
('2eso_t3_u5', 'El Espiritu Olimpico', 'El espiritu de las olimpiadas. Demuestra tus valores deportivos.', 'Quiz Olimpiadas', 'quiz', 12, 4, 'Prueba Olimpica', 'movimiento', 16, 6, 'Llama Olimpica', 'esfuerzo', 25, 9, 250, 50, true, NOW()),
('3eso_t1_u1', 'El Maestro del Calor', 'Un maestro del calentamiento. Disena la rutina perfecta para impresionarlo.', 'Quiz Calor', 'quiz', 10, 3, 'Direccion de Grupo', 'movimiento', 14, 5, 'Calor Intenso', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('3eso_t1_u2', 'El Guardian de las Articulaciones', 'Un guardian que protege las articulaciones. Tu conocimiento anatomico es la clave.', 'Quiz Anatomia', 'quiz', 10, 3, 'Analisis de Movimiento', 'movimiento', 14, 5, 'Articulacion Maestra', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('3eso_t1_u3', 'El Titan de la Intensidad', 'Un titan que entrena sin descanso. Tus metodos de entrenamiento lo desafiaran.', 'Quiz Entreno', 'quiz', 12, 4, 'Circuito de Campeon', 'movimiento', 18, 6, 'Maxima Intensidad', 'esfuerzo', 25, 9, 250, 50, true, NOW()),
('3eso_t1_u4', 'El Planificador Infinito', 'Un ser que planea cada detalle. Disena el plan perfecto para vencerlo.', 'Quiz Planificacion', 'quiz', 10, 3, 'Rutina Disenada', 'movimiento', 14, 5, 'Plan Maestro', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('3eso_t1_u5', 'El Arbitro Invisible', 'Un arbitro que ve todo. Tu juego limpio y tu habilidad te haran ganar.', 'Quiz Alternativos', 'quiz', 12, 4, 'Torneo Alternativo', 'movimiento', 16, 6, 'Juego Invisible', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('3eso_t2_u1', 'El Malabarista del Tiempo', 'Un malabarista que controla el tiempo. Tu secuencia gimnastica detendra el reloj.', 'Quiz Gimnasia', 'quiz', 10, 3, 'Rutina Contrarreloj', 'movimiento', 14, 5, 'Tiempo Congelado', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('3eso_t2_u2', 'El Coreografo Virtual', 'Un coreografo digital. Tu baile y ritmo lo desafiaran.', 'Quiz Baile', 'quiz', 8, 2, 'Batalla de Baile', 'movimiento', 12, 4, 'Coreografia Final', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('3eso_t2_u3', 'El Coloso de los Portes', 'Un coloso que solo se rinde ante el trabajo en equipo. Construye tu mejor figura.', 'Quiz Acrosport', 'quiz', 10, 3, 'Figura Colectiva', 'movimiento', 16, 6, 'Piramide Perfecta', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('3eso_t2_u4', 'El Guardian de las Vidas', 'Un guardian que protege cada vida. Tu RCP y emergencias marcaran la diferencia.', 'Quiz RCP', 'quiz', 10, 3, 'Simulacion de Crisis', 'movimiento', 14, 5, 'Vida Salvada', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('3eso_t2_u5', 'El Espejo del Esfuerzo', 'Un espejo que refleja tu esfuerzo. Superate a ti mismo para vencerlo.', 'Quiz Individual', 'quiz', 10, 3, 'Marca Personal', 'movimiento', 14, 5, 'Auto-superacion', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('3eso_t3_u1', 'El Guardian de la Amistad', 'Un guardian que une grupos. Tus juegos cooperativos fortaleceran el vinculo.', 'Quiz Cohesion', 'quiz', 8, 2, 'Dinamica de Grupo', 'movimiento', 12, 4, 'Amistad Eterna', 'esfuerzo', 13, 5, 130, 25, true, NOW()),
('3eso_t3_u2', 'El Instructor de Habilidades', 'Un instructor exigente. Tus fundamentos predeportivos seran evaluados.', 'Quiz Predeportes', 'quiz', 8, 2, 'Circuito de Habilidades', 'movimiento', 12, 4, 'Habilidad Maestra', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('3eso_t3_u3', 'El General del Juego', 'Un general que dirige el campo. Tu tactica en futbol y baloncesto decidira la batalla.', 'Quiz Tactica', 'quiz', 12, 4, 'Partido Tactico', 'movimiento', 18, 6, 'Victoria Estrategica', 'esfuerzo', 25, 9, 250, 50, true, NOW()),
('3eso_t3_u4', 'El Innovador de Reglas', 'Un innovador que reta lo establecido. Tu creatividad en alternativos lo sorprendera.', 'Quiz Innovacion', 'quiz', 10, 3, 'Nuevo Deporte', 'movimiento', 14, 5, 'Regla Revolucionaria', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('3eso_t3_u5', 'El Espiritu de la Montana', 'El espiritu de la naturaleza. Tu orientacion y respeto por el medio te guiaran.', 'Quiz Naturaleza', 'quiz', 10, 3, 'Expedicion Final', 'movimiento', 16, 6, 'Cima Alcanzada', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t1_u1', 'El Maestro de Ceremonias', 'Un maestro que lidera ceremonias. Tu liderazgo en calentamientos brillara.', 'Quiz Liderazgo', 'quiz', 10, 3, 'Direccion de Grupo', 'movimiento', 16, 6, 'Ceremonia Final', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t1_u2', 'El Sanador de Musculos', 'Un sanador que conoce cada lesion. Tu prevencion y conocimiento anatomico venceran.', 'Quiz Lesiones', 'quiz', 10, 3, 'Analisis de Riesgos', 'movimiento', 16, 6, 'Cuerpo Sano', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t1_u3', 'El Monitor de Intensidad', 'Un monitor que mide cada latido. Tu condicion fisica avanzada lo desafiara.', 'Quiz HIIT', 'quiz', 12, 4, 'Circuito HIIT', 'movimiento', 20, 7, 'Intensidad Suprema', 'esfuerzo', 30, 10, 300, 60, true, NOW()),
('4eso_t1_u4', 'El Guardian del Equilibrio', 'Un guardian del equilibrio y la coordinacion. Tus cualidades motrices lo venceran.', 'Quiz Motricidad', 'quiz', 10, 3, 'Circuito de Habilidades', 'movimiento', 14, 5, 'Cualidad Maestra', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t1_u5', 'El Planificador Infinito', 'Un ser que planea eternamente. Tu plan de entrenamiento personal lo impresionara.', 'Quiz Planificacion', 'quiz', 12, 4, 'Rutina Personal', 'movimiento', 18, 6, 'Plan Definitivo', 'esfuerzo', 30, 10, 300, 60, true, NOW()),
('4eso_t2_u1', 'El Acrobata Maestro', 'Un acrobata que domina cada movimiento. Tu progresion gimnastica brillara.', 'Quiz Gimnasia', 'quiz', 10, 3, 'Rutina en Pareja', 'movimiento', 14, 5, 'Acrobacia Final', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t2_u2', 'El Director de Escena', 'Un director teatral. Tu teatro fisico expresara la victoria.', 'Quiz Teatro', 'quiz', 10, 3, 'Improvisacion', 'movimiento', 14, 5, 'Gran Estreno', 'esfuerzo', 22, 8, 220, 45, true, NOW()),
('4eso_t2_u3', 'El Angel de la Guarda', 'Un angel que protege. Tus primeros auxilios avanzados salvaran la situacion.', 'Quiz Emergencias', 'quiz', 10, 3, 'Simulacion Compleja', 'movimiento', 14, 5, 'Mision Cumplida', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('4eso_t2_u4', 'El General de la Cancha', 'Un general que dirige el juego. Tu tactica colectiva decidira la batalla.', 'Quiz Tactica', 'quiz', 12, 4, 'Sistema de Juego', 'movimiento', 18, 6, 'Batalla Tactica', 'esfuerzo', 25, 9, 250, 50, true, NOW()),
('4eso_t2_u5', 'El Espiritu Deportivo', 'El espiritu de la competicion justa. Tu deportividad y talento brillaran.', 'Quiz Deportividad', 'quiz', 12, 4, 'Torneo Final', 'movimiento', 18, 6, 'Juego Limpio', 'esfuerzo', 25, 9, 250, 50, true, NOW()),
('4eso_t3_u1', 'El Guardian de la Convivencia', 'Un guardian de la paz. Tus juegos inclusivos uniran a todos.', 'Quiz Inclusion', 'quiz', 8, 2, 'Juego Universal', 'movimiento', 12, 4, 'Convivencia', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('4eso_t3_u2', 'El Guia de Transiciones', 'Un guia que ensena el camino del juego al deporte. Tu progresion lo impresionara.', 'Quiz Predeportes', 'quiz', 8, 2, 'Progresion Deportiva', 'movimiento', 12, 4, 'Transicion Maestra', 'esfuerzo', 15, 5, 150, 30, true, NOW()),
('4eso_t3_u3', 'El Atleta Completo', 'Un atleta polivalente. Tu version en multiples deportes lo vencera.', 'Quiz Multideporte', 'quiz', 14, 5, 'Circuito Multideportivo', 'movimiento', 20, 7, 'Atleta Total', 'esfuerzo', 30, 10, 300, 60, true, NOW()),
('4eso_t3_u4', 'El Campeon de la Igualdad', 'Un campeon que defiende la inclusion. Tu juego inclusivo demostrara el camino.', 'Quiz Inclusion', 'quiz', 10, 3, 'Deporte para Todos', 'movimiento', 14, 5, 'Igualdad en Juego', 'esfuerzo', 18, 6, 180, 35, true, NOW()),
('4eso_t3_u5', 'El Consejo de los Sabios', 'Cinco sabios que representan todo tu aprendizaje. Debes superar todas sus pruebas.', 'Quiz Integral', 'quiz', 16, 6, 'Circuito Maestro', 'movimiento', 22, 8, 'El Desafio Elite', 'esfuerzo', 30, 12, 300, 60, true, NOW());


-- ============================================================
-- LOGROS
-- ============================================================

INSERT INTO achievements (id, title, description, icon_url, category, rarity, condition, xp_reward, coin_reward, is_active, created_at) VALUES
('ach_first_steps', 'Primeros Pasos', 'Completa tu primera leccion. El viaje comienza!', '👣', 'special', 'comun', '{"type": "lessons_completed", "target": 1}', 50, 10, true, NOW()),
('ach_dedication', 'Dedicacion', 'Completa 10 lecciones. Sigue asi!', '📚', 'streak', 'comun', '{"type": "lessons_completed", "target": 10}', 100, 25, true, NOW()),
('ach_scholar', 'Estudiante Aplicado', 'Completa 50 lecciones. Tu esfuerzo brilla.', '🎓', 'streak', 'raro', '{"type": "lessons_completed", "target": 50}', 250, 50, true, NOW()),
('ach_week_streak', 'Racha Semanal', 'Manten una racha de 7 dias activos. Constancia!', '🔥', 'streak', 'comun', '{"type": "streak", "target": 7}', 100, 20, true, NOW()),
('ach_month_streak', 'Racha Mensual', 'Manten una racha de 30 dias activos. Imparable!', '💪', 'streak', 'epico', '{"type": "streak", "target": 30}', 500, 100, true, NOW()),
('ach_three_stars', 'Tres Estrellas', 'Consigue 3 estrellas en un reto. Brillante!', '⭐⭐⭐', 'special', 'comun', '{"type": "three_stars_count", "target": 1}', 75, 15, true, NOW()),
('ach_collector', 'Coleccionista', 'Consigue 10 retos con 3 estrellas. Maestro!', '🏆', 'units', 'raro', '{"type": "three_stars_count", "target": 10}', 300, 75, true, NOW()),
('ach_boss_slayer', 'Cazador de Jefes', 'Derrota a tu primer jefe final. Victoria!', '🗡️', 'special', 'comun', '{"type": "bosses_defeated", "target": 1}', 100, 25, true, NOW()),
('ach_boss_master', 'Senor de los Jefes', 'Derrota a 5 jefes finales. Legendario!', '👑', 'units', 'epico', '{"type": "bosses_defeated", "target": 5}', 500, 100, true, NOW()),
('ach_team_player', 'Jugador de Equipo', 'Completa tu primer reto cooperativo. Juntos somos mas!', '🤝', 'social', 'comun', '{"type": "challenges_completed", "target": 1}', 75, 15, true, NOW()),
('ach_xp_hunter', 'Cazador de XP', 'Acumula 1000 XP en total. Sigue creciendo!', '⚡', 'units', 'comun', '{"type": "total_xp", "target": 1000}', 150, 30, true, NOW()),
('ach_xp_elite', 'Elite XP', 'Acumula 5000 XP en total. Eres una leyenda!', '🌟', 'units', 'epico', '{"type": "total_xp", "target": 5000}', 800, 200, true, NOW()),
('ach_strong', 'Fuerza en Desarrollo', 'Alcanza nivel 10 de fuerza. Titan!', '💪', 'attributes', 'raro', '{"type": "attribute_fuerza", "target": 10}', 200, 50, true, NOW()),
('ach_resilient', 'Resistencia Legendaria', 'Alcanza nivel 10 de resistencia. Maratoniano!', '❤️', 'attributes', 'raro', '{"type": "attribute_resistencia", "target": 10}', 200, 50, true, NOW()),
('ach_strategist', 'Estratega', 'Alcanza nivel 10 de estrategia. Maestro Jedi!', '🧠', 'attributes', 'raro', '{"type": "attribute_estrategia", "target": 10}', 200, 50, true, NOW()),
('ach_leader', 'Lider Nato', 'Alcanza nivel 10 de liderazgo. A seguir!', '⭐', 'attributes', 'raro', '{"type": "attribute_liderazgo", "target": 10}', 200, 50, true, NOW()),
('ach_healthy', 'Vida Saludable', 'Alcanza nivel 10 de salud. Cuerpo sano, mente sana!', '🍎', 'attributes', 'raro', '{"type": "attribute_salud", "target": 10}', 200, 50, true, NOW()),
('ach_cooperative', 'Cooperador', 'Alcanza nivel 10 de cooperacion. Equipo!', '🤝', 'attributes', 'raro', '{"type": "attribute_cooperacion", "target": 10}', 200, 50, true, NOW()),
('ach_1eso_complete', 'Graduado en 1o ESO', 'Completa todas las unidades de 1o de ESO. Promocionas!', '🎓', 'units', 'epico', '{"type": "course_completed", "params": {"course": "1_eso"}, "target": 1}', 500, 150, true, NOW()),
('ach_2eso_complete', 'Graduado en 2o ESO', 'Completa todas las unidades de 2o de ESO. Promocionas!', '🎓', 'units', 'epico', '{"type": "course_completed", "params": {"course": "2_eso"}, "target": 1}', 600, 200, true, NOW()),
('ach_3eso_complete', 'Graduado en 3o ESO', 'Completa todas las unidades de 3o de ESO. Promocionas!', '🎓', 'units', 'epico', '{"type": "course_completed", "params": {"course": "3_eso"}, "target": 1}', 700, 250, true, NOW()),
('ach_4eso_complete', 'Graduado en 4o ESO', 'Completa todas las unidades de 4o de ESO. Promocionas!', '🎓', 'units', 'epico', '{"type": "course_completed", "params": {"course": "4_eso"}, "target": 1}', 800, 300, true, NOW()),
('ach_all_eso', 'Maestro EF', 'Completa unidades de los 4 cursos de ESO.', '👑', 'special', 'legendario', '{"type": "units_completed", "target": 48}', 2000, 500, true, NOW());

-- ============================================================
-- TIENDA: OBJETOS
-- ============================================================

INSERT INTO shop_items (id, type, name, description, image_url, price, tier, is_limited, is_active, created_at) VALUES
('item_outfit_rookie', 'outfit', 'Chandal Inicial', 'Chandal basico de EF Quest. Perfecto para empezar.', '', 0, 'rookie', false, true, NOW()),
('item_outfit_amateur', 'outfit', 'Equipo Deportivo', 'Equipo deportivo completo. Mayor comodidad para tus entrenamientos.', '', 150, 'amateur', false, true, NOW()),
('item_outfit_competidor', 'outfit', 'Uniforme Elite', 'Uniforme de competicion con tecnologia avanzada.', '', 300, 'competidor', false, true, NOW()),
('item_outfit_capitan', 'outfit', 'Armadura Legendaria', 'Una armadura deportiva que solo los capitanes pueden llevar.', '', 500, 'capitan', false, true, NOW()),
('item_outfit_elite', 'outfit', 'Traje Maximo', 'El traje definitivo. Solo los estudiantes Elite pueden portarlo.', '', 800, 'elite', false, true, NOW()),
('item_acc_headband', 'accessory', 'Cinta Deportiva', 'Cinta absorbente para mantener el sudor fuera de tus ojos.', '', 50, 'rookie', false, true, NOW()),
('item_acc_wristband', 'accessory', 'Munequeras', 'Munequeras ajustables con el logo de EF Quest.', '', 40, 'rookie', false, true, NOW()),
('item_acc_cap', 'accessory', 'Gorra Elite', 'Gorra con visera. Proteccion solar con estilo.', '', 80, 'amateur', false, true, NOW()),
('item_acc_backpack', 'accessory', 'Mochila Aventurera', 'Mochila ligera para tus rutas de senderismo.', '', 120, 'competidor', false, true, NOW()),
('item_acc_medal', 'accessory', 'Medalla de Honor', 'Medalla dorada que demuestra tu valia.', '', 200, 'capitan', false, true, NOW()),
('item_acc_crown', 'accessory', 'Corona Elite', 'La corona del campeon. Solo los mejores la poseen.', '', 500, 'elite', true, true, NOW()),
('item_power_double_xp', 'powerup', 'Doble XP', 'Multiplica por 2 los XP ganados durante 24h.', '', 100, 'amateur', false, true, NOW()),
('item_power_extra_coins', 'powerup', 'Bonus Monedas', 'Gana monedas extra durante una sesion completa.', '', 80, 'rookie', false, true, NOW()),
('item_power_heart', 'powerup', 'Corazon Extra', 'Una vida extra para los retos. Usalo con sabiduria!', '', 60, 'rookie', false, true, NOW()),
('item_power_time_freeze', 'powerup', 'Congelacion Temporal', 'Deten el tiempo durante 30 segundos en cualquier reto.', '', 150, 'competidor', false, true, NOW()),
('item_power_streak_shield', 'powerup', 'Escudo de Racha', 'Protege tu racha de un dia de inactividad.', '', 200, 'capitan', false, true, NOW()),
('item_special_frame_dark', 'special', 'Marco Nocturno', 'Marco oscuro para tu perfil. Misterioso y elegante.', '', 100, 'amateur', false, true, NOW()),
('item_special_frame_gold', 'special', 'Marco Dorado', 'Marco dorado radiante. Tu perfil brillara como tu.', '', 300, 'competidor', false, true, NOW()),
('item_special_frame_rainbow', 'special', 'Marco Arcoiris', 'Marco multicolor muy exclusivo. Edicion limitada.', '', 600, 'elite', true, true, NOW()),
('item_special_effect_trail', 'special', 'Estela Brillante', 'Una estela de luz te seguira por la app.', '', 250, 'capitan', false, true, NOW());


