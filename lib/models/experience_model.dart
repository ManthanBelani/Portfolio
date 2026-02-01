class Experience {
  final String company;
  final String role;
  final String duration;
  final String period;
  final List<String> responsibilities;

  const Experience({
    required this.company,
    required this.role,
    required this.duration,
    required this.period,
    required this.responsibilities,
  });
}

class ExperienceData {
  static const List<Experience> experiences = [
    Experience(
      company: 'RainStream Technologies',
      role: 'Flutter Developer Intern',
      duration: '3.5 Months',
      period: 'Sept 2024 - Dec 2024',
      responsibilities: [
        'Developed a secure internal company portal mobile app using Flutter',
        'Collaborated with UI/UX team to build responsive and user-friendly screens',
        'Integrated legacy backend APIs not originally designed for mobile use',
        'Implemented cookie-based authentication, session management, and secure headers',
        'Worked with backend developers to debug APIs and test endpoints via Postman',
      ],
    ),
    Experience(
      company: 'Infolabz IT Services Pvt. Ltd.',
      role: 'Flutter Intern',
      duration: '2 Weeks',
      period: 'Jul 2024',
      responsibilities: [
        'Worked on Flutter fundamentals and UI component development',
        'Integrated REST APIs and learned mobile app development best practices',
        'Gained exposure to industry workflow and development processes',
      ],
    ),
  ];
}
