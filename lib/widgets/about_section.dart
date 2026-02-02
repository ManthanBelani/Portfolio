import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';
import 'section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const SectionTitle(number: '01.', title: 'About Me'),
              const SizedBox(height: 40),
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildProfileImage(),
        const SizedBox(height: 32),
        _buildAboutContent(),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _buildAboutContent()),
        const SizedBox(width: 48),
        Expanded(flex: 2, child: _buildProfileImage()),
      ],
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutMe,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Here are some technologies I\'ve been working with:',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        _buildTechList(),
      ],
    );
  }

  Widget _buildTechList() {
    const techs = [
      'Flutter & Dart',
      'Firebase',
      'REST APIs',
      'Provider',
      'Git & GitHub',
      'Figma to Flutter',
    ];

    return Wrap(
      spacing: 24,
      runSpacing: 8,
      children: techs.map((tech) => _TechItem(tech: tech)).toList(),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: _ProfileImageWidget(),
    );
  }
}

class _TechItem extends StatelessWidget {
  final String tech;

  const _TechItem({required this.tech});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.arrow_right,
          color: AppColors.primary,
          size: 20,
        ),
        Text(
          tech,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class _ProfileImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          'assets/my_image.png',
          width: 280,
          height: 350,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
    );
  }
}
