import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_names.dart';
import '../features/auth/screens/splash_screen.dart';
import '../features/auth/screens/onboarding_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/units/screens/unit_detail_screen.dart';
import '../features/lessons/screens/lesson_screen.dart';
import '../features/lessons/screens/quiz_screen.dart';
import '../features/challenges/screens/challenge_screen.dart';
import '../features/progress/screens/progress_screen.dart';
import '../features/avatar/screens/avatar_screen.dart';
import '../features/boss/screens/boss_fight_screen.dart';
import '../features/avatar/screens/shop_screen.dart';
import '../features/avatar/screens/avatar_customize_screen.dart';
import '../features/avatar/screens/profile_screen.dart';
import '../features/avatar/screens/leaderboard_screen.dart';
import '../features/avatar/screens/settings_screen.dart';
import '../features/avatar/screens/achievements_screen.dart';
import '../features/avatar/screens/inventory_screen.dart';
import '../features/profile/screens/teacher_panel_screen.dart';
import '../features/more/screens/more_screen.dart';
import '../data/models/unit_model.dart';
import '../data/models/lesson_model.dart';
import '../data/models/quiz_question_model.dart';
import '../data/models/challenge_model.dart';
import '../core/theme/app_theme.dart';
import '../shared/widgets/main_shell.dart';

final router = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(path: RouteNames.splash, pageBuilder: (c, s) => _fade(const SplashScreen(), c, s)),
    GoRoute(path: RouteNames.onboarding, pageBuilder: (c, s) => _slide(const OnboardingScreen(), c, s)),
    GoRoute(path: RouteNames.auth, pageBuilder: (c, s) => _slide(const LoginScreen(), c, s)),
    GoRoute(path: RouteNames.login, pageBuilder: (c, s) => _slide(const LoginScreen(), c, s)),
    GoRoute(path: RouteNames.register, pageBuilder: (c, s) => _slide(const RegisterScreen(), c, s)),
    StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) => MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (c, s) => _none(const HomeScreen(), c, s),
            routes: [
              GoRoute(
                path: 'unit/:unitId',
                pageBuilder: (c, s) => _slideUp(UnitDetailScreen(
                  unitId: s.pathParameters['unitId']!,
                ), c, s),
                routes: [
                  GoRoute(
                    path: 'lesson/:lessonId',
                    pageBuilder: (c, s) {
                      final lesson = s.extra as LessonModel?;
                      return _slideUp(LessonScreen(
                        unitId: s.pathParameters['unitId']!,
                        lessonId: s.pathParameters['lessonId']!,
                        lesson: lesson,
                      ), c, s);
                    },
                  ),
                  GoRoute(
                    path: 'quiz/:lessonId',
                    pageBuilder: (c, s) => _slideUp(QuizScreen(
                      unitId: s.pathParameters['unitId']!,
                      lessonId: s.pathParameters['lessonId']!,
                      questions: s.extra as List<QuizQuestion>? ?? const [],
                    ), c, s),
                  ),
                  GoRoute(
                    path: 'challenge/:challengeId',
                    pageBuilder: (c, s) {
                      final challenge = s.extra as ChallengeModel?;
                      return _slideUp(ChallengeScreen(
                        unitId: s.pathParameters['unitId']!,
                        challengeId: s.pathParameters['challengeId']!,
                        challenge: challenge,
                      ), c, s);
                    },
                  ),
                  GoRoute(
                    path: 'boss',
                    pageBuilder: (c, s) {
                      final unit = s.extra as UnitModel?;
                      return _slideUp(BossFightScreen(
                        unitId: s.pathParameters['unitId']!,
                        unit: unit,
                      ), c, s);
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: RouteNames.progress, pageBuilder: (c, s) => _none(const ProgressScreen(), c, s)),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: RouteNames.avatar, pageBuilder: (c, s) => _none(const AvatarScreen(), c, s),
            routes: [
              GoRoute(path: 'customize', pageBuilder: (c, s) => _slideUp(const AvatarCustomizeScreen(), c, s)),
              GoRoute(path: 'shop', pageBuilder: (c, s) => _slideUp(const ShopScreen(), c, s)),
              GoRoute(path: 'inventory', pageBuilder: (c, s) => _slideUp(const InventoryScreen(), c, s)),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(path: RouteNames.more, pageBuilder: (c, s) => _none(const MoreScreen(), c, s),
            routes: [
              GoRoute(path: 'perfil', pageBuilder: (c, s) => _slideUp(const ProfileScreen(), c, s)),
              GoRoute(path: 'leaderboard', pageBuilder: (c, s) => _slideUp(const LeaderboardScreen(), c, s)),
              GoRoute(path: 'ajustes', pageBuilder: (c, s) => _slideUp(const SettingsScreen(), c, s)),
              GoRoute(path: 'logros', pageBuilder: (c, s) => _slideUp(const AchievementsScreen(), c, s)),
            ],
          ),
        ]),
      ],
    ),
    GoRoute(path: RouteNames.teacher, pageBuilder: (c, s) => _slideUp(const TeacherPanelScreen(), c, s)),
  ],
);

Page<dynamic> _slideUp(Widget child, BuildContext context, GoRouterState state) {
  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.06),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: AppTheme.springCurve)),
      child: FadeTransition(opacity: animation, child: child),
    ),
  );
}

Page<dynamic> _slide(Widget child, BuildContext context, GoRouterState state) {
  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, animation, __, child) => SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: AppTheme.springCurve)),
      child: FadeTransition(opacity: animation, child: child),
    ),
  );
}

Page<dynamic> _fade(Widget child, BuildContext context, GoRouterState state) {
  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

Page<dynamic> _none(Widget child, BuildContext context, GoRouterState state) {
  return CustomTransitionPage<dynamic>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (_, __, ___, child) => child,
  );
}
