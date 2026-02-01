import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';
import '../models/experience_model.dart';
import 'section_title.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  int _selectedIndex = 0;

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
              const SectionTitle(number: '02.', title: 'Experience'),
              const SizedBox(height: 40),
              isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
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
        _buildTabsMobile(),
        const SizedBox(height: 24),
        _buildExperienceContent(ExperienceData.experiences[_selectedIndex]),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTabsDesktop(),
        const SizedBox(width: 32),
        Expanded(
          child: _buildExperienceContent(ExperienceData.experiences[_selectedIndex]),
        ),
      ],
    );
  }

  Widget _buildTabsMobile() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          ExperienceData.experiences.length,
          (index) => _TabButton(
            text: ExperienceData.experiences[index].company,
            isSelected: _selectedIndex == index,
            onTap: () => setState(() => _selectedIndex = index),
            isMobile: true,
          ),
        ),
      ),
    );
  }

  Widget _buildTabsDesktop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        ExperienceData.experiences.length,
        (index) => _TabButton(
          text: ExperienceData.experiences[index].company,
          isSelected: _selectedIndex == index,
          onTap: () => setState(() => _selectedIndex = index),
          isMobile: false,
        ),
      ),
    );
  }

  Widget _buildExperienceContent(Experience exp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: exp.role,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: ' @ ${exp.company}',
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '${exp.period} (${exp.duration})',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: 20),
        ...exp.responsibilities.map((resp) => _ResponsibilityItem(text: resp)),
      ],
    );
  }
}

class _TabButton extends StatefulWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isMobile;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.isMobile,
  });

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> {
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
          padding: EdgeInsets.symmetric(
            horizontal: widget.isMobile ? 16 : 20,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: widget.isSelected || _isHovered
                ? AppColors.primary.withValues(alpha: 0.1)
                : Colors.transparent,
            border: widget.isMobile
                ? Border(
                    bottom: BorderSide(
                      color: widget.isSelected ? AppColors.primary : AppColors.backgroundLight,
                      width: 2,
                    ),
                  )
                : Border(
                    left: BorderSide(
                      color: widget.isSelected ? AppColors.primary : AppColors.backgroundLight,
                      width: 2,
                    ),
                  ),
          ),
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.isSelected ? AppColors.primary : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: widget.isSelected ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _ResponsibilityItem extends StatelessWidget {
  final String text;

  const _ResponsibilityItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(
              Icons.arrow_right,
              color: AppColors.primary,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
