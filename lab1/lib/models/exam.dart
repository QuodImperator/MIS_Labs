class Exam {
  final String subject;
  final DateTime dateTime;
  final List<String> rooms;

  Exam({
    required this.subject,
    required this.dateTime,
    required this.rooms,
  });

  bool get isPast {
    return dateTime.isBefore(DateTime.now());
  }

  String getRemainingTime() {
    final now = DateTime.now();
    final difference = dateTime.difference(now);
    
    if (difference.isNegative) {
      return "Испитот е завршен";
    }
    
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    
    return "$days дена, $hours часа";
  }
}