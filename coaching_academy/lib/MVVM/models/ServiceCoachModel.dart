import 'CoachServiceModel.dart';
import 'UserModel.dart';
import 'WorkingHour.dart';
import 'WorkspaceMedia.dart';

class ServiceCoachModel {
  final int id;
  final String serviceName;
  final String category;
  final String description;
  final UserModel user;
  final List<WorkingHour> workingHours;
  final List<WorkspaceMedia> workspaceMedias;
  final List<CoachServiceModel> coachServices;

  ServiceCoachModel({
    required this.id,
    required this.serviceName,
    required this.category,
    required this.description,
    required this.user,
    required this.workingHours,
    required this.workspaceMedias,
    required this.coachServices,

  });

  factory ServiceCoachModel.fromJson(Map<String, dynamic> json) {
    return ServiceCoachModel(
      id: json['id'],
      serviceName: json['service_name'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      user: UserModel.fromJson(json['user']),
      workingHours: (json['working_hours'] as List ?? [])
          .map((e) => WorkingHour.fromJson(e))
          .toList(),
      workspaceMedias: (json['workspace_medias'] as List ?? [])
          .map((e) => WorkspaceMedia.fromJson(e))
          .toList(),
      coachServices: (json['coach_services'] as List ?? [])
          .map((e) => CoachServiceModel.fromJson(e))
          .toList(),
    );
  }
}
