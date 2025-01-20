class VehicleChoice {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  VehicleChoice({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  // Factory constructor to create a Vehicle object from a JSON map
  factory VehicleChoice.fromJson(Map<String, dynamic> json) {
    return VehicleChoice(
      make: json['make'] as String,
      model: json['model'] as String,
      containerName: json['containerName'] as String,
      similarity: json['similarity'] as int,
      externalId: json['externalId'] as String,
    );
  }

  // Method to convert a Vehicle object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'make': make,
      'model': model,
      'containerName': containerName,
      'similarity': similarity,
      'externalId': externalId,
    };
  }

  @override
  String toString() {
    return 'Vehicle(make: $make, model: $model, containerName: $containerName, similarity: $similarity, externalId: $externalId)';
  }
}
