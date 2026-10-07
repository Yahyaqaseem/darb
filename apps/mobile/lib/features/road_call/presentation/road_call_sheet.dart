import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RoadCallSheet extends StatelessWidget {
  final int driverCount;

  const RoadCallSheet({super.key, required this.driverCount});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, -10),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),
            
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.radar_rounded, color: Color(0xFFEAB308), size: 28)
                    .animate(onPlay: (controller) => controller.repeat(reverse: true))
                    .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1.seconds),
                const SizedBox(width: 12),
                Text(
                  'نداء الطريق',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 24),
                ),
              ],
            ).animate().fadeIn().slideY(begin: 0.5, end: 0, curve: Curves.easeOut),
            
            const SizedBox(height: 8),
            
            Text(
              '$driverCount سائقاً متصلاً على هذا الطريق الآن',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
              textAlign: TextAlign.center,
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.5, end: 0, curve: Curves.easeOut),
            
            const SizedBox(height: 32),
            
            // Staggered Questions
            ...[
              _buildQuestionButton(context, 'هل يوجد زحام؟', Icons.traffic_rounded),
              _buildQuestionButton(context, 'هل يوجد إغلاق بالطريق؟', Icons.remove_road_rounded),
              _buildQuestionButton(context, 'هل توجد نقطة تفتيش / سيطرة؟', Icons.security_rounded),
              _buildQuestionButton(context, 'هل يوجد حادث أمامي؟', Icons.car_crash_rounded),
            ].animate(interval: 100.ms).fadeIn(delay: 200.ms).slideX(begin: 0.2, end: 0, curve: Curves.easeOut),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionButton(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم إرسال نداء الطريق بنجاح', style: TextStyle(fontFamily: 'Tajawal')),
                backgroundColor: const Color(0xFF0F172A),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFF0F172A), size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey.shade400, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showRoadCallSheet(BuildContext context, int driverCount) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context).overlay!,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 300),
    )..forward(),
    builder: (context) => RoadCallSheet(driverCount: driverCount),
  );
}
