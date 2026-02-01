class SkillCategory {
  final String title;
  final List<String> skills;

  const SkillCategory({required this.title, required this.skills});
}

class SkillData {
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Languages',
      skills: ['Dart', 'Java', 'C', 'C++', 'JavaScript', 'Python'],
    ),
    SkillCategory(
      title: 'Frameworks',
      skills: ['Flutter', 'Angular (Basics)'],
    ),
    SkillCategory(
      title: 'Backend & APIs',
      skills: ['Firebase', 'REST APIs', 'Node.js (Basic)'],
    ),
    SkillCategory(
      title: 'Databases',
      skills: ['Firestore', 'MongoDB', 'MySQL'],
    ),
    SkillCategory(
      title: 'Tools',
      skills: ['Git', 'GitHub', 'Postman', 'VS Code', 'Figma', 'Android Studio'],
    ),
    SkillCategory(
      title: 'Concepts',
      skills: ['State Management', 'Provider', 'REST Integration', 'UI/UX Implementation', 'Authentication'],
    ),
  ];
}
