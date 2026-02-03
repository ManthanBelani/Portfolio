import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';
import '../models/skill_model.dart';
import 'section_title.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    
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
              const SectionTitle(number: '03.', title: 'Skills'),
              const SizedBox(height: 40),
              isMobile
                  ? _buildMobileSkills()
                  : _buildGridSkills(isTablet ? 2 : 3, isMobile),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileSkills() {
    return Column(
      children: SkillData.skillCategories
          .map((category) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _SkillCard(category: category),
              ))
          .toList(),
    );
  }

  Widget _buildGridSkills(int crossAxisCount, bool isMobile) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.8,
      ),
      itemCount: SkillData.skillCategories.length,
      itemBuilder: (context, index) {
        return _SkillCard(category: SkillData.skillCategories[index]);
      },
    );
  }
}

class _SkillCard extends StatefulWidget {
  final SkillCategory category;

  const _SkillCard({required this.category});

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -5, 0))
            : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  _getIconForCategory(widget.category.title),
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.category.title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.category.skills
                  .map((skill) => _SkillChip(skill: skill))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForCategory(String title) {
    switch (title) {
      case 'Languages':
        return Icons.code;
      case 'Frameworks':
        return Icons.widgets;
      case 'Backend & APIs':
        return Icons.cloud;
      case 'Databases':
        return Icons.storage;
      case 'Tools':
        return Icons.build;
      case 'Concepts':
        return Icons.lightbulb;
      default:
        return Icons.star;
    }
  }
}

class _SkillChip extends StatelessWidget {
  final String skill;

  const _SkillChip({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: AppColors.primary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
