enum StatusLife {
  unknown,
  alive,
  dead;

  factory StatusLife.fromString(String value) {
    switch (value.toLowerCase()) {
      case 'alive':
        return StatusLife.alive;
      case 'dead':
        return StatusLife.dead;
      case 'unknown':
        return StatusLife.unknown;
      default:
        return StatusLife.unknown;
    }
  }
}
