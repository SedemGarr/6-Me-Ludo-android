class AppVersion {
  late String version;
  late int buildNumber;

  AppVersion({
    required this.version,
    required this.buildNumber,
  });

  AppVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    buildNumber = json['buildNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    data['buildNumber'] = buildNumber;
    return data;
  }
}
