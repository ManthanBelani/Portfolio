class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final List<String> features;
  final String? githubUrl;
  final bool isFeatured;
  final List<String> imagePaths;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.features,
    this.githubUrl,
    this.isFeatured = false,
    this.imagePaths = const [],
  });
}

class ProjectData {
  static const List<Project> featuredProjects = [
    Project(
      title: 'Company Portal App',
      description: 'A production-grade internal mobile application for company employees with secure authentication and role-based access.',
      technologies: ['Flutter', 'Custom REST APIs', 'Cookie-based Auth'],
      features: [
        'Built production-grade internal mobile application',
        'Managed authentication manually using cookies and headers',
        'Implemented role-based access and session handling',
        'Integrated legacy backend APIs for mobile use',
      ],
      isFeatured: true,
      imagePaths: [
        'assets/project_images/portal_app/image_0.jpeg',
        'assets/project_images/portal_app/image_1.png',
        'assets/project_images/portal_app/image_2.png',
      ],
      githubUrl: 'https://github.com/ManthanBelani/RSW-portal-app',
    ),
    Project(
      title: 'Dream Canvas - AI Image Generator',
      description: 'An AI-powered mobile application for generating images using text prompts with Stability AI integration.',
      technologies: ['Flutter', 'Stability AI API', 'Firebase', 'Provider'],
      features: [
        'AI-powered image generation using text prompts',
        'Integrated Stability AI API with async workflows',
        'Firebase Authentication and Firestore integration',
        'User image history storage and management',
      ],
      isFeatured: true,
      imagePaths: [
        'assets/project_images/dream_canvas/home_screen.png',
        'assets/project_images/dream_canvas/home_screen2.png',
        'assets/project_images/dream_canvas/setting_screen.png',
      ],
      githubUrl: 'https://github.com/ManthanBelani/dream_canvas',
    ),
    Project(
      title: 'Real Estate Booking & Rental App',
      description: 'A user-side application for property booking and rental management with pixel-perfect UI from Figma designs.',
      technologies: ['Flutter', 'Firebase', 'Figma'],
      features: [
        'Property booking and rental management',
        'Converted Figma designs to pixel-perfect UI',
        'Firebase integration for listings and bookings',
        'User data management and authentication',
      ],
      isFeatured: true,
      imagePaths: [
        'assets/project_images/housely_real_estate_app/image_1.png',
        'assets/project_images/housely_real_estate_app/image_2.png',
        'assets/project_images/housely_real_estate_app/image_3.png',
      ],
      githubUrl: 'https://github.com/ManthanBelani/housely-real-estate-app',
    ),
  ];

  static const List<Project> otherProjects = [
    Project(
      title: 'Group Chat App',
      description: 'Real-time group messaging application with Firebase backend.',
      technologies: ['Flutter', 'Firebase'],
      features: ['Real-time messaging', 'Group creation', 'User authentication'],
      githubUrl: 'https://github.com/ManthanBelani/Chat_app',
    ),
    Project(
      title: 'Weather App',
      description: 'Weather forecasting app with location-based updates.',
      technologies: ['Flutter', 'OpenWeather API', 'Geolocation'],
      features: ['Current weather data', 'Location detection', 'Weather forecasts'],
    ),
    Project(
      title: 'Notes App',
      description: 'Simple and efficient note-taking application with state management.',
      technologies: ['Flutter', 'Provider'],
      features: ['Create and edit notes', 'Local storage', 'Clean UI'],
    ),
    Project(
      title: 'Face Recognition Attendance',
      description: 'Automated attendance system using facial recognition technology.',
      technologies: ['Python', 'OpenCV', 'MySQL'],
      features: ['Face detection', 'Attendance tracking', 'Database management'],
    ),
  ];
}
