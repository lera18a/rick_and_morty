import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum LifeStatus {
  @JsonValue('unknown')
  unknown('unknown'),
  @JsonValue('Alive')
  alive('Alive'),
  @JsonValue('Dead')
  dead('Dead');

  final String value;
  const LifeStatus(this.value);
  factory LifeStatus.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'alive':
        return LifeStatus.alive;
      case 'dead':
        return LifeStatus.dead;
      case 'unknown':
        return LifeStatus.unknown;
      default:
        return LifeStatus.unknown;
    }
  }
}
