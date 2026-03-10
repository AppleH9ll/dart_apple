void main() {
  List<String> students = [
    'Иванов Иван',
    'Петров Петр',
    'Сидорова Анна',
    'Козлов Дмитрий',
    'Смирнова Елена'
  ];

  List<String> subjects = [
    'Математика',
    'Физика',
    'Информатика',
    'Литература'
  ];

  List<List<int>> grades = [
    [5, 4, 5, 3],
    [3, 3, 2, 4],
    [5, 5, 5, 5],
    [4, 4, 4, 4],
    [2, 3, 3, 3], 
  ];

  print('СВОДНАЯ ТАБЛИЦА УСПЕВАЕМОСТИ\n');

  String header = 'Студент'.padRight(20);
  for (var subject in subjects) {
    header += subject.padLeft(12);
  }
  header += 'Ср.балл'.padLeft(10);
  print(header);

  List<double> subjectSums = List.filled(subjects.length, 0.0);

  for (int i = 0; i < students.length; i++) {
    String row = students[i].padRight(20);
    double studentSum = 0.0;

    for (int j = 0; j < subjects.length; j++) {
      int grade = grades[i][j];
      row += grade.toString().padLeft(12);
      studentSum += grade;
      subjectSums[j] += grade;
    }

    double studentAvg = studentSum / subjects.length;
    row += studentAvg.toStringAsFixed(2).padLeft(10);
    print(row);
  }

  String avgRow = 'Средний по предмету'.padRight(20);
  for (int j = 0; j < subjects.length; j++) {
    double subjectAvg = subjectSums[j] / students.length;
    avgRow += subjectAvg.toStringAsFixed(2).padLeft(12);
  }
  print(avgRow);

  print('\nПОИСК СТУДЕНТА');
  String searchName = 'Сидорова Анна';
  bool found = false;
  for (int i = 0; i < students.length; i++) {
    if (students[i] == searchName) {
      found = true;
      print('Студент: ${students[i]}');
      print('Оценки по предметам:');
      double sum = 0.0;
      for (int j = 0; j < subjects.length; j++) {
        print('  ${subjects[j]}: ${grades[i][j]}');
        sum += grades[i][j];
      }
      double avg = sum / subjects.length;
      String category = _getCategory(avg);
      print('Средний балл: ${avg.toStringAsFixed(2)}');
      print('Категория: $category');
      break;
    }
  }
  if (!found) {
    print('Студент с именем "$searchName" не найден.');
  }

  print('\nУНИКАЛЬНЫЕ ОЦЕНКИ');
  Set<int> uniqueGrades = {};
  for (var row in grades) {
    uniqueGrades.addAll(row);
  }
  print('Оценки, встречающиеся в журнале: ${uniqueGrades.toList()}');

  print('\nМАКСИМАЛЬНЫЕ И МИНИМАЛЬНЫЕ ОЦЕНКИ ПО ПРЕДМЕТАМ');
  for (int j = 0; j < subjects.length; j++) {
    List<int> subjectGrades = [];
    for (int i = 0; i < students.length; i++) {
      subjectGrades.add(grades[i][j]);
    }
    int maxGrade = subjectGrades.reduce((a, b) => a > b ? a : b);
    int minGrade = subjectGrades.reduce((a, b) => a < b ? a : b);

    List<String> maxStudents = [];
    List<String> minStudents = [];
    for (int i = 0; i < students.length; i++) {
      if (grades[i][j] == maxGrade) {
        maxStudents.add(students[i]);
      }
      if (grades[i][j] == minGrade) {
        minStudents.add(students[i]);
      }
    }

    print('${subjects[j]}:');
    print('  Максимальная оценка $maxGrade у студентов: ${maxStudents.join(', ')}');
    print('  Минимальная оценка $minGrade у студентов: ${minStudents.join(', ')}');
  }

  print('\nСТУДЕНТЫ С РОВНО ОДНОЙ ДВОЙКОЙ');
  bool hasSingleTwo = false;
  for (int i = 0; i < students.length; i++) {
    int twoCount = 0;
    int twoIndex = -1;
    for (int j = 0; j < subjects.length; j++) {
      if (grades[i][j] == 2) {
        twoCount++;
        twoIndex = j;
      }
    }
    if (twoCount == 1) {
      hasSingleTwo = true;
      print('${students[i]} - предмет: ${subjects[twoIndex]}');
    }
  }
  if (!hasSingleTwo) {
    print('Нет студентов с ровно одной двойкой.');
  }

  print('\nПРЕДМЕТЫ СО СРЕДНИМ БАЛЛОМ ВЫШЕ ОБЩЕГО');
  double totalSum = 0.0;
  int totalCount = 0;
  for (var row in grades) {
    for (var g in row) {
      totalSum += g;
      totalCount++;
    }
  }
  double overallAvg = totalSum / totalCount;

  print('Общий средний балл по группе: ${overallAvg.toStringAsFixed(2)}');

  for (int j = 0; j < subjects.length; j++) {
    double subjectSum = 0.0;
    for (int i = 0; i < students.length; i++) {
      subjectSum += grades[i][j];
    }
    double subjectAvg = subjectSum / students.length;
    if (subjectAvg > overallAvg) {
      print('${subjects[j]} (${subjectAvg.toStringAsFixed(2)})');
    }
  }

  print('\nКАТЕГОРИИ УСПЕВАЕМОСТИ');
  int excellent = 0;
  int good = 0;
  int other = 0;

  for (int i = 0; i < students.length; i++) {
    double sum = 0.0;
    for (int j = 0; j < subjects.length; j++) {
      sum += grades[i][j];
    }
    double avg = sum / subjects.length;
    String cat = _getCategory(avg);
    if (cat == 'отличник') {
      excellent++;
    } else if (cat == 'хорошист') {
      good++;
    } else {
      other++;
    }
  }

  print('Отличники: $excellent');
  print('Хорошисты: $good');
  print('Остальные: $other');
}

String _getCategory(double avg) {
  if (avg >= 4.5) {
    return 'отличник';
  } else if (avg >= 3.5) {
    return 'хорошист';
  } else {
    return 'остальные';
  }
}