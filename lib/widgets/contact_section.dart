import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    
    return Container(
      width: double.infinity,
      padding: Responsive.screenPadding(context),
      child: Center(
        child: SizedBox(
          width: Responsive.contentWidth(context),
          child: Column(
            children: [
              const SizedBox(height: 100),
              Text(
                '05. What\'s Next?',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: isMobile ? 14 : 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Get In Touch',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: isMobile ? 40 : 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: isMobile ? double.infinity : 600,
                child: const Text(
                  'I\'m currently looking for new opportunities and my inbox is always open. '
                  'Whether you have a question, want to discuss a project, or just want to say hi, '
                  'I\'ll try my best to get back to you!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 17,
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              _ContactButton(),
              const SizedBox(height: 60),
              _buildSocialLinks(isMobile),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIcon(
          icon: FontAwesomeIcons.github,
          url: AppStrings.github,
        ),
        const SizedBox(width: 32),
        _SocialIcon(
          icon: FontAwesomeIcons.linkedin,
          url: AppStrings.linkedin,
        ),
        const SizedBox(width: 32),
        _SocialIcon(
          icon: FontAwesomeIcons.envelope,
          url: 'mailto:${AppStrings.email}',
        ),
        const SizedBox(width: 32),
        _SocialIcon(
          icon: FontAwesomeIcons.phone,
          url: 'tel:${AppStrings.phone}',
        ),
      ],
    );
  }
}

class _ContactButton extends StatefulWidget {
  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
  bool _isHovered = false;

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: AppStrings.email,
      queryParameters: {
        'subject': 'Hello from Portfolio',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchEmail,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
            border: Border.all(color: AppColors.primary, width: 1.5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Say Hello',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({required this.icon, required this.url});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  Future<void> _launchUrl() async {
    final Uri uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _launchUrl,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0, -4, 0))
              : Matrix4.identity(),
          child: FaIcon(
            widget.icon,
            color: _isHovered ? AppColors.primary : AppColors.textSecondary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
