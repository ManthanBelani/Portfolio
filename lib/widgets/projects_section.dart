import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive.dart';
import '../utils/constants.dart';
import '../models/project_model.dart';
import 'section_title.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SectionTitle(number: '04.', title: 'Projects'),
              const SizedBox(height: 48),
              _buildFeaturedProjects(context),
              const SizedBox(height: 80),
              _buildOtherProjectsTitle(),
              const SizedBox(height: 40),
              _buildOtherProjects(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedProjects(BuildContext context) {
    return Column(
      children: ProjectData.featuredProjects.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: _FeaturedProjectCard(
            project: entry.value,
            isReversed: entry.key.isOdd,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOtherProjectsTitle() {
    return const Center(
      child: Text(
        'Other Noteworthy Projects',
        style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildOtherProjects(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    int crossAxisCount = isMobile
        ? 1
        : isTablet
        ? 2
        : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isMobile ? 1.4 : 1.1,
      ),
      itemCount: ProjectData.otherProjects.length,
      itemBuilder: (context, index) {
        return _OtherProjectCard(project: ProjectData.otherProjects[index]);
      },
    );
  }
}

class _FeaturedProjectCard extends StatelessWidget {
  final Project project;
  final bool isReversed;

  const _FeaturedProjectCard({required this.project, required this.isReversed});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return _buildMobileCard();
    }
    return _buildDesktopCard();
  }

  Widget _buildMobileCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MobileProjectImage(
            title: project.title,
            imagePaths: project.imagePaths,
          ),
          const SizedBox(height: 20),
          const Text(
            'Featured Project',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            project.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.description,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          ...project.features.map((f) => _FeatureItem(text: f)),
          const SizedBox(height: 20),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: project.technologies
                .map(
                  (tech) => Text(
                    tech,
                    style: TextStyle(
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                      fontSize: 13,
                      fontFamily: 'monospace',
                    ),
                  ),
                )
                .toList(),
          ),
          if (project.githubUrl != null) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final url = Uri.parse(project.githubUrl!);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              },
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.github,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'View on GitHub',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopCard() {
    return Row(
      children: isReversed
          ? [
              Expanded(
                flex: 5,
                child: _buildContent(CrossAxisAlignment.end, TextAlign.right),
              ),
              const SizedBox(width: 24),
              Expanded(flex: 6, child: _buildProjectImage()),
            ]
          : [
              Expanded(flex: 6, child: _buildProjectImage()),
              const SizedBox(width: 24),
              Expanded(
                flex: 5,
                child: _buildContent(CrossAxisAlignment.start, TextAlign.left),
              ),
            ],
    );
  }

  Widget _buildProjectImage() {
    return _ProjectImageWidget(
      title: project.title,
      imagePaths: project.imagePaths,
    );
  }

  Widget _buildContent(CrossAxisAlignment alignment, TextAlign textAlign) {
    return Column(
      crossAxisAlignment: alignment,
      children: [
        const Text(
          'Featured Project',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          project.title,
          textAlign: textAlign,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Text(
                project.description,
                textAlign: textAlign,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              ...project.features.map(
                (f) => _FeatureItem(text: f, alignment: alignment),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: isReversed ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: isReversed ? WrapAlignment.end : WrapAlignment.start,
              children: project.technologies
                  .map(
                    (tech) => Text(
                      tech,
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.8),
                        fontSize: 13,
                        fontFamily: 'monospace',
                      ),
                    ),
                  )
                  .toList(),
            ),
            if (project.githubUrl != null) ...[
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () async {
                  final url = Uri.parse(project.githubUrl!);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: const FaIcon(
                  FontAwesomeIcons.github,
                  color: AppColors.textSecondary,
                  size: 24,
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;
  final CrossAxisAlignment alignment;

  const _FeatureItem({
    required this.text,
    this.alignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check, color: AppColors.primary, size: 16),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectImageWidget extends StatefulWidget {
  final String title;
  final List<String> imagePaths;

  const _ProjectImageWidget({required this.title, required this.imagePaths});

  @override
  State<_ProjectImageWidget> createState() => _ProjectImageWidgetState();
}

class _ProjectImageWidgetState extends State<_ProjectImageWidget> {
  bool _isHovered = false;
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.imagePaths.isNotEmpty;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: AppColors.backgroundLight,
            child: Stack(
              fit: StackFit.expand,
              children: [
                if (hasImages)
                  Center(
                    child: Image.asset(
                      widget.imagePaths[_currentImageIndex],
                      fit: BoxFit.contain,
                    ),
                  ),
                if (!hasImages)
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.backgroundLight.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone_android,
                            size: 80,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                // Tint overlay
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: _isHovered
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : AppColors.primary.withValues(alpha: 0.2),
                  ),
                ),
                // Navigation arrows and indicators
                if (hasImages && widget.imagePaths.length > 1) ...[
                  // Left arrow
                  Positioned(
                    left: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentImageIndex =
                                  (_currentImageIndex - 1) %
                                  widget.imagePaths.length;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  // Right arrow
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: AnimatedOpacity(
                        opacity: _isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentImageIndex =
                                  (_currentImageIndex + 1) %
                                  widget.imagePaths.length;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  // Dots indicator
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.imagePaths.length,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentImageIndex == index
                                ? AppColors.primary
                                : Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OtherProjectCard extends StatefulWidget {
  final Project project;

  const _OtherProjectCard({required this.project});

  @override
  State<_OtherProjectCard> createState() => _OtherProjectCardState();
}

class _OtherProjectCardState extends State<_OtherProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0, -8, 0))
            : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.folder_open,
                  color: AppColors.primary,
                  size: 40,
                ),
                if (widget.project.githubUrl != null)
                  GestureDetector(
                    onTap: () async {
                      final url = Uri.parse(widget.project.githubUrl!);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: const FaIcon(
                      FontAwesomeIcons.github,
                      color: AppColors.textSecondary,
                      size: 22,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              widget.project.title,
              style: TextStyle(
                color: _isHovered ? AppColors.primary : AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Text(
                widget.project.description,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: widget.project.technologies
                  .map(
                    (tech) => Text(
                      tech,
                      style: TextStyle(
                        color: AppColors.textSecondary.withValues(alpha: 0.7),
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobileProjectImage extends StatefulWidget {
  final String title;
  final List<String> imagePaths;

  const _MobileProjectImage({
    required this.title,
    required this.imagePaths,
  });

  @override
  State<_MobileProjectImage> createState() => _MobileProjectImageState();
}

class _MobileProjectImageState extends State<_MobileProjectImage> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasImages = widget.imagePaths.isNotEmpty;

    return Container(
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: AppColors.backgroundLight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (hasImages)
                Center(
                  child: Image.asset(
                    widget.imagePaths[_currentImageIndex],
                    fit: BoxFit.contain,
                  ),
                ),
              if (!hasImages)
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.15),
                        AppColors.backgroundLight.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.phone_android,
                          size: 60,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            widget.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              // Tint overlay
              Container(
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                ),
              ),
              // Navigation and indicators for multiple images
              if (hasImages && widget.imagePaths.length > 1) ...[
                // Left arrow
                Positioned(
                  left: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentImageIndex = (_currentImageIndex - 1 + widget.imagePaths.length) %
                                widget.imagePaths.length;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Right arrow
                Positioned(
                  right: 8,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                        onPressed: () {
                          setState(() {
                            _currentImageIndex =
                                (_currentImageIndex + 1) % widget.imagePaths.length;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Dots indicator
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.imagePaths.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? AppColors.primary
                              : Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

