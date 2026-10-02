enum ProgressStatus {
  locked,
  available,
  inProgress,
  completed,
  failed;

  String get value {
    switch (this) {
      case ProgressStatus.locked:
        return 'locked';
      case ProgressStatus.available:
        return 'available';
      case ProgressStatus.inProgress:
        return 'in_progress';
      case ProgressStatus.completed:
        return 'completed';
      case ProgressStatus.failed:
        return 'failed';
    }
  }

  static ProgressStatus fromString(String s) {
    switch (s) {
      case 'locked':
        return ProgressStatus.locked;
      case 'available':
        return ProgressStatus.available;
      case 'in_progress':
        return ProgressStatus.inProgress;
      case 'completed':
        return ProgressStatus.completed;
      case 'failed':
        return ProgressStatus.failed;
      default:
        throw ArgumentError('Invalid ProgressStatus: $s');
    }
  }
}
