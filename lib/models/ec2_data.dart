class Ec2Data {
  late final String name;
  late final String id;
  late final String type;
  late final String state;
  late final String az;
  late final String publicIP;
  late final String privateIP;

  Ec2Data.fromJson({
    required Map<String, dynamic> data,
  }) {
    name = data['name'] ?? '';
    id = data['id'] ?? '';
    type = data['type'] ?? '';
    state = data['state'] ?? '';
    az = data['az'] ?? '';
    publicIP = data['publicIP'] ?? '';
    privateIP = data['privateIP'] ?? '';
  }
}