import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/core_providers.dart';
import '../../../data/models/user_model.dart';
import '../../../core/enums/user_role.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;
  final bool isTeacher;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.isTeacher = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
    bool? isTeacher,
  }) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        isTeacher: isTeacher ?? this.isTeacher,
      );
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AuthState()) {
    _init();
  }

  void _init() {
    _ref.read(supabaseClientProvider).auth.onAuthStateChange.listen((data) {
      final sbUser = data.session?.user;
      if (sbUser != null) {
        _loadUser(sbUser.id);
      } else {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          user: null,
        );
      }
    });
  }

  Future<void> _loadUser(String uid) async {
    try {
      final userRepo = _ref.read(userRepositoryProvider);
      final user = await userRepo.getUser(uid);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isTeacher: user.role == UserRole.profesor,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.unauthenticated,
        errorMessage: 'Error al cargar perfil',
      );
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final authRepo = _ref.read(authRepositoryProvider);
      final user = await authRepo.signInWithEmail(email, password);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isTeacher: user.role == UserRole.profesor,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapAuthError(e.toString()),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final authRepo = _ref.read(authRepositoryProvider);
      final user = await authRepo.signInWithGoogle();
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isTeacher: user.role == UserRole.profesor,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: 'Error al iniciar con Google',
      );
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
    required String course,
    required UserRole role,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final authRepo = _ref.read(authRepositoryProvider);
      final user = await authRepo.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
        course: course,
        role: role,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        user: user,
        isTeacher: role == UserRole.profesor,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: _mapAuthError(e.toString()),
      );
    }
  }

  Future<void> signOut() async {
    final authRepo = _ref.read(authRepositoryProvider);
    await authRepo.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> refreshUser() async {
    if (state.user == null) return;
    await _loadUser(state.user!.uid);
  }

  String _mapAuthError(String error) {
    if (error.contains('invalid-email')) return 'Email inválido';
    if (error.contains('user-not-found')) return 'Usuario no encontrado';
    if (error.contains('wrong-password')) return 'Contraseña incorrecta';
    if (error.contains('email-already-in-use')) return 'Email ya registrado';
    if (error.contains('weak-password')) return 'Contraseña demasiado débil';
    if (error.contains('network-request-failed')) return 'Error de conexión';
    return 'Error de autenticación';
  }
}

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier(ref));
