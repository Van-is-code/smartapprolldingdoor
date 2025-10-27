import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Đổi tên từ _ControlButton thành ControlButton (bỏ dấu gạch)
class _ControlButton extends StatelessWidget {
  // ... (Copy class _ControlButton) ...
  final IconData icon;
  final String label;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(0),
            ),
            child: isLoading
                ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            )
                : Icon(icon, color: color, size: 32),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}