import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SosSheet extends StatelessWidget {
  const SosSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
        decoration: BoxDecoration(
          color: const Color(0xFF991B1B).withOpacity(0.95), // Red tone for SOS
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            
            // SOS Pulsing Icon
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 20)
                  ],
                ),
                child: const Icon(Icons.sos_rounded, color: Color(0xFF991B1B), size: 40),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(1, 1), end: const Offset(1.15, 1.15), duration: 600.ms),
            ),
            
            const SizedBox(height: 24),
            Text(
              'حالة طوارئ',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'هل تحتاج إلى مساعدة فورية؟',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white70,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            _buildSosAction(
              context,
              'الاتصال بالإسعاف',
              Icons.local_hospital_rounded,
              () {},
            ),
            const SizedBox(height: 12),
            _buildSosAction(
              context,
              'الاتصال بالمرور',
              Icons.local_police_rounded,
              () {},
            ),
            const SizedBox(height: 12),
            _buildSosAction(
              context,
              'مشاركة موقعي لجهات الاتصال',
              Icons.share_location_rounded,
              () {},
              isLight: true,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 1, end: 0, curve: Curves.easeOutCirc);
  }

  Widget _buildSosAction(BuildContext context, String title, IconData icon, VoidCallback onTap, {bool isLight = false}) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isLight ? Colors.white.withOpacity(0.15) : Colors.white,
        foregroundColor: isLight ? Colors.white : const Color(0xFF991B1B),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

void showSosSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const SosSheet(),
  );
}
