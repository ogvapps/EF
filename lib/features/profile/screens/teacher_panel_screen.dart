import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/models/class_model.dart';
import '../../../data/models/user_model.dart';
import '../../auth/providers/auth_providers.dart';
import '../../../core/providers/core_providers.dart';

class TeacherPanelScreen extends ConsumerWidget {
  const TeacherPanelScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classesAsync = ref.watch(teacherClassesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Panel del Profesor', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => _showCreateClassDialog(context, ref),
          ),
        ],
      ),
      body: classesAsync.when(
        data: (classes) {
          if (classes.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.school, size: 60, color: Colors.white.withValues(alpha: 0.1)),
                  const SizedBox(height: 16),
                  const Text('Aún no hay clases', style: TextStyle(color: Colors.white54)),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => _showCreateClassDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('Crear clase'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                      foregroundColor: const Color(0xFF4CAF50),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => ref.refresh(teacherClassesProvider),
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final c = classes[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('📚', style: TextStyle(fontSize: 24)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              c.group,
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                          ),
                          Text('${c.students.length} alumnos',
                              style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.analytics_outlined,
                              label: 'Analíticas',
                              onTap: () => _showAnalyticsDialog(context, ref, c),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.group_outlined,
                              label: 'Alumnos',
                              onTap: () => _showStudentsDialog(context, ref, c),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _ActionButton(
                              icon: Icons.link,
                              label: 'Invitar',
                              onTap: () => _showInviteDialog(context, c),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e', style: const TextStyle(color: Colors.red))),
      ),
    );
  }

  void _showCreateClassDialog(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final user = ref.read(authProvider).user;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: const Text('Nueva clase', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del grupo',
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white24)),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar', style: TextStyle(color: Colors.white54)),
          ),
          TextButton(
            onPressed: () async {
              if (nameController.text.isNotEmpty && user != null) {
                final now = DateTime.now();
                final uniqueClassId = '${user.uid.substring(0, user.uid.length.clamp(0, 8))}_${now.millisecondsSinceEpoch}';
                await ref.read(classRepositoryProvider).createClass(
                  ClassModel(
                    classId: uniqueClassId,
                    teacherId: user.uid,
                    course: user.course,
                    group: nameController.text,
                    schoolYear: '${now.year}-${now.year + 1}',
                    createdAt: now,
                    updatedAt: now,
                  ),
                );
                ref.invalidate(teacherClassesProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              }
            },
            child: const Text('Crear', style: TextStyle(color: Color(0xFF4CAF50))),
          ),
        ],
      ),
    );
  }

  void _showInviteDialog(BuildContext context, ClassModel classModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: const Row(
          children: [
            Icon(Icons.link, color: Color(0xFF4CAF50)),
            SizedBox(width: 8),
            Text('Código de Clase', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Comparte este código con los alumnos del grupo "${classModel.group}":',
                style: const TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SelectableText(
                      classModel.classId,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Color(0xFF4CAF50), size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: classModel.classId));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Código copiado al portapapeles')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }

  void _showAnalyticsDialog(BuildContext context, WidgetRef ref, ClassModel classModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: Row(
          children: [
            const Icon(Icons.analytics_outlined, color: Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            Text('Analíticas - ${classModel.group}', style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: FutureBuilder<Map<String, dynamic>>(
          future: ref.read(classRepositoryProvider).getClassAnalytics(classModel.classId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 100,
                child: Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50))),
              );
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}', style: const TextStyle(color: Colors.red));
            }
            final data = snapshot.data ?? {};
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _AnalyticsTile(label: 'Total de alumnos', value: '${data['totalStudents'] ?? 0}'),
                _AnalyticsTile(label: 'Promedio de XP', value: '${data['averageXP'] ?? 0} XP'),
                _AnalyticsTile(label: 'Promedio de racha', value: '${data['averageStreak'] ?? 0} días'),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }

  void _showStudentsDialog(BuildContext context, WidgetRef ref, ClassModel classModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF2A2A3E),
        title: Row(
          children: [
            const Icon(Icons.group, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Alumnos - ${classModel.group}',
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ],
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: classModel.students.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('Sin alumnos aún', style: TextStyle(color: Colors.white54), textAlign: TextAlign.center),
                )
              : FutureBuilder<List<UserModel>>(
                  future: ref.read(classRepositoryProvider).getClassStudents(classModel.classId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                        height: 80,
                        child: Center(child: CircularProgressIndicator(color: Color(0xFF4CAF50))),
                      );
                    }
                    final studentsList = snapshot.data ?? [];
                    if (studentsList.isEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: classModel.students.length,
                        itemBuilder: (_, i) => ListTile(
                          leading: const Icon(Icons.person, color: Colors.white54),
                          title: Text(classModel.students[i],
                              style: const TextStyle(color: Colors.white, fontSize: 13)),
                        ),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: studentsList.length,
                      itemBuilder: (_, i) {
                        final student = studentsList[i];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF4CAF50).withValues(alpha: 0.2),
                            child: Text(
                              student.displayName.isNotEmpty ? student.displayName[0].toUpperCase() : 'A',
                              style: const TextStyle(color: Color(0xFF4CAF50)),
                            ),
                          ),
                          title: Text(
                            student.displayName.isNotEmpty ? student.displayName : student.email,
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          subtitle: Text(
                            '${student.xp} XP · Nv. ${student.level}',
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 12),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red, size: 18),
                            onPressed: () async {
                              await ref
                                  .read(classRepositoryProvider)
                                  .removeStudent(classModel.classId, student.uid);
                              ref.invalidate(teacherClassesProvider);
                              if (ctx.mounted) Navigator.pop(ctx);
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cerrar', style: TextStyle(color: Colors.white54)),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsTile extends StatelessWidget {
  final String label;
  final String value;

  const _AnalyticsTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
          Text(value, style: const TextStyle(color: Color(0xFF4CAF50), fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF4CAF50), size: 18),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(color: Color(0xFF4CAF50), fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
