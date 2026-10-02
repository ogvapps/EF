const admin = require('firebase-admin');
const yaml = require('js-yaml');
const fs = require('fs');
const path = require('path');

// --- Setup ---
const serviceAccount = require('./service-account.json');
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) });
const db = admin.firestore();

// --- Load curriculum ---
const curriculumPath = path.join(__dirname, '..', 'docs', 'curriculum.yaml');
const curriculum = yaml.load(fs.readFileSync(curriculumPath, 'utf8'));

const now = admin.firestore.FieldValue.serverTimestamp();
const batchSize = 500;

async function seed() {
  console.log('🧹 Limpiando colecciones existentes...');
  const collections = ['units', 'lessons', 'challenges', 'minigames', 'bosses', 'achievements', 'shop_items'];
  for (const col of collections) {
    const snap = await db.collection(col).get();
    const batches = [];
    let batch = db.batch();
    let count = 0;
    snap.forEach(doc => {
      batch.delete(doc.ref);
      count++;
      if (count >= batchSize) { batches.push(batch.commit()); batch = db.batch(); count = 0; }
    });
    batches.push(batch.commit());
    await Promise.all(batches);
    console.log(`  ${col}: eliminados`);
  }

  // --- Seed units & lessons & challenges & minigames & bosses ---
  let unitIndex = 0;
  for (const course of curriculum.courses) {
    for (const trimester of course.trimesters) {
      for (const ud of trimester.ud) {
        unitIndex++;
        const unitRef = db.collection('units').doc();
        const unitData = {
          unitId: unitRef.id,
          courseId: course.id,
          trimester: trimester.id,
          number: ud.number,
          title: ud.title,
          description: ud.description ?? '',
          attributes: ud.attributes ?? {},
          color: ud.color ?? '#4CAF50',
          icon: ud.icon ?? '🏋️',
          order: unitIndex,
          createdAt: now,
        };
        await unitRef.set(unitData);

        // Lessons
        for (const lesson of ud.lessons ?? []) {
          const lessonRef = db.collection('lessons').doc();
          const lessonData = {
            lessonId: lessonRef.id,
            unitId: unitRef.id,
            number: lesson.number,
            title: lesson.title,
            type: lesson.type ?? 'content',
            content: lesson.content ?? '',
            contentType: lesson.content_type ?? 'text',
            duration: lesson.duration ?? 15,
            xpReward: lesson.xp_reward ?? 50,
            order: lesson.number,
            createdAt: now,
          };

          if (lesson.quiz) {
            lessonData.quizData = {
              questions: lesson.quiz.questions ?? [],
              minScore: lesson.quiz.min_score ?? 60,
              xpPerQuestion: lesson.quiz.xp_per_question ?? 10,
            };
          }

          await lessonRef.set(lessonData);
        }

        // Challenges
        for (const challenge of ud.challenges ?? []) {
          const challengeRef = db.collection('challenges').doc();
          const challengeData = {
            challengeId: challengeRef.id,
            unitId: unitRef.id,
            number: challenge.number,
            title: challenge.title,
            description: challenge.description ?? '',
            type: challenge.type ?? 'count',
            metric: challenge.metric ?? 'reps',
            targetValue: challenge.target_value ?? 10,
            timeSeconds: challenge.time_seconds ?? 60,
            xpReward: challenge.xp_reward ?? 100,
            attribute: challenge.attribute ?? 'fuerza',
            order: challenge.number,
            createdAt: now,
          };
          await challengeRef.set(challengeData);
        }

        // Minigames
        for (const minigame of ud.minigames ?? []) {
          const mgRef = db.collection('minigames').doc();
          const mgData = {
            minigameId: mgRef.id,
            unitId: unitRef.id,
            number: minigame.number,
            title: minigame.title,
            description: minigame.description ?? '',
            gameType: minigame.game_type ?? 'reflex',
            levels: minigame.levels ?? [],
            xpReward: minigame.xp_reward ?? 80,
            order: minigame.number,
            createdAt: now,
          };
          await mgRef.set(mgData);
        }

        // Boss
        if (ud.boss) {
          const bossRef = db.collection('bosses').doc();
          const bossData = {
            bossId: bossRef.id,
            unitId: unitRef.id,
            name: ud.boss.name,
            description: ud.boss.description ?? '',
            phases: ud.boss.phases ?? [],
            xpReward: ud.boss.xp_reward ?? 200,
            minAttributes: ud.boss.min_attributes ?? {},
            createdAt: now,
          };
          await bossRef.set(bossData);
        }
      }
    }
  }

  // --- Seed achievements ---
  const achievements = curriculum.achievements ?? [];
  for (const ach of achievements) {
    const ref = db.collection('achievements').doc();
    await ref.set({
      achievementId: ref.id,
      name: ach.name,
      description: ach.description ?? '',
      icon: ach.icon ?? '🏆',
      rarity: ach.rarity ?? 'comun',
      category: ach.category ?? 'general',
      condition: ach.condition ?? {},
      xpReward: ach.xp_reward ?? 100,
      coinReward: ach.coin_reward ?? 0,
      createdAt: now,
    });
  }

  // --- Seed shop items ---
  const shopItems = curriculum.shop_items ?? [];
  for (const item of shopItems) {
    const ref = db.collection('shop_items').doc();
    await ref.set({
      itemId: ref.id,
      name: item.name,
      description: item.description ?? '',
      type: item.type ?? 'outfit',
      price: item.price ?? 100,
      tier: item.tier ?? 'bronce',
      attributes: item.attributes ?? {},
      createdAt: now,
    });
  }

  console.log('\n✅ Seed completado exitosamente');
  console.log(`  Unidades: ${unitIndex}`);
  console.log(`  Logros: ${achievements.length}`);
  console.log(`  Items tienda: ${shopItems.length}\n`);
  process.exit(0);
}

seed().catch(err => { console.error('❌ Error:', err); process.exit(1); });
