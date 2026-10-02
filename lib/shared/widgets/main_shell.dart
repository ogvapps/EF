import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _items = [
    _NavItem(Icons.home_rounded, 'Inicio'),
    _NavItem(Icons.bar_chart_rounded, 'Progreso'),
    _NavItem(Icons.person_rounded, 'Avatar'),
    _NavItem(Icons.widgets_rounded, 'Más'),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = widget.navigationShell.currentIndex;

    return Scaffold(
      extendBody: true,
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A1F35), Color(0xFF141829)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth = constraints.maxWidth / _items.length;
            return Stack(
              children: [
                AnimatedAlign(
                  alignment: Alignment(
                    -1 + (2.0 / (_items.length - 1)) * currentIndex,
                    0,
                  ),
                  duration: AppTheme.medAnim,
                  curve: AppTheme.springCurve,
                  child: Container(
                    width: itemWidth - 8,
                    margin: EdgeInsets.only(
                      left: 4 + currentIndex * itemWidth,
                    ),
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: AppTheme.primaryGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: AppTheme.neonShadow(AppTheme.primary, blur: 12),
                    ),
                  ),
                ),
                Row(
                  children: List.generate(_items.length, (i) {
                    final isSelected = currentIndex == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => widget.navigationShell.goBranch(i),
                        child: AnimatedContainer(
                          duration: AppTheme.fastAnim,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _items[i].icon,
                                color: isSelected ? Colors.white : Colors.white38,
                                size: 22,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _items[i].label,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      isSelected ? FontWeight.w600 : FontWeight.w400,
                                  color:
                                      isSelected ? Colors.white : Colors.white38,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}
