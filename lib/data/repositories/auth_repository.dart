import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';
import '../../core/enums/user_role.dart';
import '../../core/services/logger_service.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class AuthRepository {
  final SupabaseClient _supabase;
  final FlutterSecureStorage _storage;
  final LoggerService? _logger;

  AuthRepository({
    SupabaseClient? supabase,
    FlutterSecureStorage? storage,
    LoggerService? logger,
  })  : _supabase = supabase ?? Supabase.instance.client,
        _storage = storage ?? const FlutterSecureStorage(),
        _logger = logger;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
  User? get currentUser => _supabase.auth.currentUser;

  Future<UserModel> signInWithEmail(String email, String password) async {
    _logger?.info('Sign-in iniciado', data: {'email': email});
    try {
      final result = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final authUser = result.user;
      if (authUser == null) throw Exception('Error de autenticación');

      final userData = await _supabase
          .from('users')
          .select()
          .eq('auth_id', authUser.id)
          .single();

      _updateLastLogin(authUser.id);
      _logger?.info('Sign-in exitoso', data: {'uid': authUser.id});
      return UserModel.fromJson(userData);
    } catch (e) {
      _logger?.error('Sign-in fallido', error: e);
      rethrow;
    }
  }

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String course,
    required UserRole role,
  }) async {
    _logger?.info('Registro iniciado', data: {'email': email, 'role': role.value});
    try {
      final result = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'display_name': displayName,
          'role': role.value,
          'course': course,
        },
      );
      final authUser = result.user;
      if (authUser == null) throw Exception('Error de registro');

      final now = DateTime.now();
      UserModel user;

      try {
        final userData = await _supabase
            .from('users')
            .select()
            .eq('auth_id', authUser.id)
            .single();
        user = UserModel.fromJson(userData);
      } catch (_) {
        user = UserModel(
          uid: authUser.id,
          email: email,
          displayName: displayName,
          role: role,
          course: course,
          lastActiveDate: now,
          createdAt: now,
          updatedAt: now,
          lastLoginAt: now,
        );
      }

      _logger?.info('Registro exitoso', data: {'uid': authUser.id});
      return user;
    } catch (e) {
      _logger?.error('Registro fallido', error: e);
      rethrow;
    }
  }

  Future<UserModel> signInWithGoogle() async {
    _logger?.info('Google sign-in iniciado');
    try {
      await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? null : 'com.efquest.app://callback',
      );

      final authUser = _supabase.auth.currentUser;
      if (authUser == null) throw Exception('Google sign-in cancelado');

      final userData = await _supabase
          .from('users')
          .select()
          .eq('auth_id', authUser.id)
          .maybeSingle();

      if (userData == null) {
        try {
          final rpcResult = await _supabase.rpc('upsert_user_profile', params: {
            'p_display_name': authUser.userMetadata?['full_name'] ?? '',
            'p_role': 'alumno',
            'p_course': '1_eso',
            'p_photo_url': authUser.userMetadata?['avatar_url'],
            'p_email': authUser.email,
          });
          return UserModel.fromJson(Map<String, dynamic>.from(rpcResult));
        } catch (_) {
          final now = DateTime.now();
          final user = UserModel(
            uid: authUser.id,
            email: authUser.email ?? '',
            displayName: authUser.userMetadata?['full_name'] ?? '',
            photoURL: authUser.userMetadata?['avatar_url'],
            role: UserRole.alumno,
            course: '1_eso',
            lastActiveDate: now,
            createdAt: now,
            updatedAt: now,
            lastLoginAt: now,
          );
          _logger?.info('Google sign-in exitoso (nuevo usuario, perfil local)');
          return user;
        }
      }

      _updateLastLogin(authUser.id);
      _logger?.info('Google sign-in exitoso', data: {'uid': authUser.id});
      return UserModel.fromJson(userData);
    } catch (e) {
      _logger?.error('Google sign-in fallido', error: e);
      rethrow;
    }
  }

  Future<void> signOut() async {
    _logger?.info('Sign-out iniciado');
    await _supabase.auth.signOut();
    await _storage.deleteAll();
    _logger?.info('Sign-out completado');
  }

  Future<void> sendPasswordReset(String email) async {
    _logger?.info('Password reset solicitado', data: {'email': email});
    await _supabase.auth.resetPasswordForEmail(email);
    _logger?.info('Password reset email enviado');
  }

  Future<void> deleteAccount() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('No hay usuario autenticado');
    _logger?.info('Cuenta eliminada', data: {'uid': user.id});
    try {
      await _supabase.rpc('delete_user_account');
    } catch (_) {
      await _supabase.from('users').delete().eq('auth_id', user.id);
    }
    await signOut();
  }

  Future<void> _updateLastLogin(String uid) async {
    await _supabase.from('users').update({
      'last_login_at': DateTime.now().toIso8601String(),
      'is_active': true,
    }).eq('auth_id', uid);
  }
}
