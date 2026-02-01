import 'package:flutter/material.dart';
import '../utils/responsive.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/footer.dart';
import '../widgets/mobile_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
      Navigator.pop(this.context);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Responsive.isMobile(context)
          ? MobileDrawer(
              onAbout: () => _scrollToSection(_aboutKey),
              onExperience: () => _scrollToSection(_experienceKey),
              onSkills: () => _scrollToSection(_skillsKey),
              onProjects: () => _scrollToSection(_projectsKey),
              onContact: () => _scrollToSection(_contactKey),
            )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                HeroSection(
                  key: _heroKey,
                  onProjectsClick: () => _scrollToSection(_projectsKey),
                ),
                AboutSection(key: _aboutKey),
                ExperienceSection(key: _experienceKey),
                SkillsSection(key: _skillsKey),
                ProjectsSection(key: _projectsKey),
                ContactSection(key: _contactKey),
                const Footer(),
              ],
            ),
          ),
          Navbar(
            scaffoldKey: _scaffoldKey,
            onAbout: () => _scrollToSection(_aboutKey),
            onExperience: () => _scrollToSection(_experienceKey),
            onSkills: () => _scrollToSection(_skillsKey),
            onProjects: () => _scrollToSection(_projectsKey),
            onContact: () => _scrollToSection(_contactKey),
          ),
        ],
      ),
    );
  }
}
