class WorkspaceMedia {
  final String? workspaceImage;
  final String? workspaceVideo;

  WorkspaceMedia({
    this.workspaceImage,
    this.workspaceVideo,
  });

  factory WorkspaceMedia.fromJson(Map<String, dynamic> json) {
    return WorkspaceMedia(
      workspaceImage: json['workspace_image'],
      workspaceVideo: json['workspace_video'],
    );
  }
}
