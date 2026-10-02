import 'package:flutter/material.dart';

class DailyCard extends StatelessWidget {
  final VoidCallback onTap;
  const DailyCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7C4DFF), Color(0xFFFF6B9D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C4DFF).withValues(alpha: 0.25),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              Text('🎯', style: TextStyle(fontSize: 26)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reto diario',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.white)),
                  Text('150 XP', style: TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
