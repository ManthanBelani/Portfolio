import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String number;
  final String title;

  const SectionTitle({
    super.key,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Row(
      children: [
        Text(
          number,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isMobile ? 24 : 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 1,
            constraints: const BoxConstraints(maxWidth: 300),
            color: AppColors.backgroundLight,
          ),
        ),
      ],
    );
  }
}
