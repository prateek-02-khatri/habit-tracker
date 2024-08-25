class HabitModel {
  final String habitName;
  final String habitDescription;
  bool isCompleted;
  final int dateTime;

  HabitModel({
    required this.habitName,
    required this.habitDescription,
    required this.isCompleted,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'habitTitle': habitName,
      'habit': habitDescription,
      'isCompleted': isCompleted,
      'dateTime': dateTime,
    };
  }

  factory HabitModel.fromMap(Map<String, dynamic> json) {
    return HabitModel(
      habitName: json['habitTitle'] ?? '',
      habitDescription: json['habit'] ?? '',
      isCompleted: json['isCompleted'] ?? false,
      dateTime: json['dateTime'],
    );
  }
}