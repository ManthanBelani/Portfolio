import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onProjectsClick;

  const HeroSection({
    super.key,
    required this.onProjectsClick,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: Responsive.screenHeight(context) - 80,
      ),
      padding: Responsive.screenPadding(context),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                AppStrings.heroGreeting,
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppStrings.name,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 40 : isTablet ? 56 : 72,
                  fontWeight: FontWeight.bold,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: isMobile ? 50 : 70,
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      AppStrings.heroTagline,
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? 32 : isTablet ? 44 : 56,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'Flutter Developer.',
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? 32 : isTablet ? 44 : 56,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                    TypewriterAnimatedText(
                      'Mobile App Enthusiast.',
                      textStyle: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: isMobile ? 32 : isTablet ? 44 : 56,
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                      ),
                      speed: const Duration(milliseconds: 80),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: isMobile ? double.infinity : 600,
                child: Text(
                  AppStrings.heroDescription,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: isMobile ? 15 : 17,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _HeroButton(onTap: onProjectsClick),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroButton extends StatefulWidget {
  final VoidCallback onTap;

  const _HeroButton({required this.onTap});

  @override
  State<_HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<_HeroButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Check out my work!',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
