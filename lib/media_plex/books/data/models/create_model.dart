import 'package:media_plex/media_plex/books/domain/entities/_created.dart';

class CreatedModel extends Created {
  const CreatedModel({
    required super.type,
    required super.value,
  });

  factory CreatedModel.fromJson(Map<String, dynamic> json) => CreatedModel(
        type: json["type"] ?? "",
        value: DateTime.tryParse(json["value"] ?? "") ?? DateTime.utc(0, 0, 0),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value.toIso8601String(),
      };
}
