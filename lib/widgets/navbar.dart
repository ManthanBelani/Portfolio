import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';

class Navbar extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onAbout;
  final VoidCallback onExperience;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const Navbar({
    super.key,
    required this.scaffoldKey,
    required this.onAbout,
    required this.onExperience,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: Responsive.screenPadding(context),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         
          Responsive.isMobile(context)
              ? _buildMenuButton(context)
              : _buildNavItems(),
        ],
      ),
    );
  }



  Widget _buildMenuButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, color: AppColors.primary, size: 28),
      onPressed: () => scaffoldKey.currentState?.openDrawer(),
    );
  }

  Widget _buildNavItems() {
    return Row(
      children: [
        _NavItem(text: 'About', number: '01.', onTap: onAbout),
        _NavItem(text: 'Experience', number: '02.', onTap: onExperience),
        _NavItem(text: 'Skills', number: '03.', onTap: onSkills),
        _NavItem(text: 'Projects', number: '04.', onTap: onProjects),
        _NavItem(text: 'Contact', number: '05.', onTap: onContact),
        const SizedBox(width: 16),
        _ResumeButton(),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final String text;
  final String number;
  final VoidCallback onTap;

  const _NavItem({
    required this.text,
    required this.number,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: TextStyle(
              color: _isHovered ? AppColors.primary : AppColors.textSecondary,
              fontSize: 14,
            ),
            child: Row(
              children: [
                Text(
                  widget.number,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 4),
                Text(widget.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _isHovered = false;

  Future<void> _openResume() async {
    final Uri url = Uri.parse('assets/Manthan_CV.pdf');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _openResume,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(4),
          ),
          child: const Text(
            'Resume',
            style: TextStyle(color: AppColors.primary, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
