enum ProjectStatus { live, beta, development }

class ProjectModel {
  final String title;
  final String description;
  final ProjectStatus status;
  final String? githubUrl;
  final String? appStoreUrl;
  final List<String> techStack;

  ProjectModel({
    required this.title,
    required this.description,
    required this.status,
    this.githubUrl,
    this.appStoreUrl,
    required this.techStack,
  });
}

final List<ProjectModel> myProjects = [
  ProjectModel(
    title: "VisionScan AI",
    description: "A mobile app using computer vision to assist in visual perception studies.",
    status: ProjectStatus.live,
    githubUrl: "https://github.com/yourname/visionscan",
    techStack: ["Flutter", "TensorFlow Lite", "Dart"],
  ),
  ProjectModel(
    title: "ThermalFlow HVAC",
    description: "An IoT dashboard for monitoring DIY home climate control systems.",
    status: ProjectStatus.development,
    techStack: ["Raspberry Pi", "Python", "MQTT"],
  ),
];