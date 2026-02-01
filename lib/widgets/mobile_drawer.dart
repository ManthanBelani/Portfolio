import 'package:flutter/material.dart';
import '../utils/constants.dart';

class MobileDrawer extends StatelessWidget {
  final VoidCallback onAbout;
  final VoidCallback onExperience;
  final VoidCallback onSkills;
  final VoidCallback onProjects;
  final VoidCallback onContact;

  const MobileDrawer({
    super.key,
    required this.onAbout,
    required this.onExperience,
    required this.onSkills,
    required this.onProjects,
    required this.onContact,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundLight,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close, color: AppColors.primary, size: 28),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 40),
              _DrawerItem(number: '01.', text: 'About', onTap: onAbout),
              _DrawerItem(number: '02.', text: 'Experience', onTap: onExperience),
              _DrawerItem(number: '03.', text: 'Skills', onTap: onSkills),
              _DrawerItem(number: '04.', text: 'Projects', onTap: onProjects),
              _DrawerItem(number: '05.', text: 'Contact', onTap: onContact),
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Resume',
                    style: TextStyle(color: AppColors.primary, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String number;
  final String text;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.number,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number,
              style: const TextStyle(color: AppColors.primary, fontSize: 14),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
