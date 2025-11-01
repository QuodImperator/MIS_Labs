import '../models/exam.dart';

List<Exam> getExams() {
  return [
    Exam(
      subject: "Веројатност и статистика",
      dateTime: DateTime(2025, 11, 5, 10, 0),
      rooms: ["Амфитеатар 1", "Амфитеатар 2"],
    ),
    Exam(
      subject: "Оперативни системи",
      dateTime: DateTime(2025, 11, 8, 12, 0),
      rooms: ["Лабораторија 3"],
    ),
    Exam(
      subject: "Бази на податоци",
      dateTime: DateTime(2025, 11, 15, 11, 0),
      rooms: ["Лабораторија 1", "Лабораторија 2"],
    ),
    Exam(
      subject: "Веб програмирање",
      dateTime: DateTime(2025, 11, 18, 14, 0),
      rooms: ["Амфитеатар 4"],
    ),
    Exam(
      subject: "Алгоритми и податочни структури",
      dateTime: DateTime(2025, 11, 22, 10, 0),
      rooms: ["Амфитеатар 1"],
    ),
    Exam(
      subject: "Компјутерски мрежи",
      dateTime: DateTime(2025, 11, 25, 13, 0),
      rooms: ["Лабораторија 4"],
    ),
    Exam(
      subject: "Софтверско инженерство",
      dateTime: DateTime(2025, 11, 28, 9, 30),
      rooms: ["Амфитеатар 2", "Амфитеатар 3"],
    ),
    Exam(
      subject: "Вештачка интелигенција",
      dateTime: DateTime(2025, 12, 2, 11, 0),
      rooms: ["Амфитеатар 5"],
    ),
    Exam(
      subject: "Мобилни информациски системи",
      dateTime: DateTime(2025, 12, 5, 15, 0),
      rooms: ["Лабораторија 1", "Лабораторија 3"],
    ),
    Exam(
      subject: "Дискретна математика",
      dateTime: DateTime(2025, 10, 28, 10, 0),
      rooms: ["Амфитеатар 1"],
    ),
    Exam(
      subject: "Објектно ориентирано програмирање",
      dateTime: DateTime(2025, 10, 25, 12, 0),
      rooms: ["Лабораторија 2"],
    ),
  ];
}