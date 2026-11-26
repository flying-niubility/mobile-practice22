/// 作业任务3：成绩分级器扩展（边界 0 / 100 与非法输入）。
library;

import 'package:dart_basics/dart_basics.dart';

/// 解析用户输入的字符串并分级；无法解析或超范围时返回“非法成绩”。
String parseAndGrade(String input) {
  final value = double.tryParse(input.trim());
  if (value == null) return '非法成绩';
  return gradeOf(value);
}

void main() {
  print('===== 控制流：成绩分级器（扩展版）=====');

  // 边界与非法数值：0、100、越界、NaN
  final samples = <num>[
    100,
    99.9,
    90,
    89.9,
    80,
    60,
    59.9,
    0,
    -1,
    100.1,
    double.nan,
  ];
  for (final score in samples) {
    print('score=${score.toString().padLeft(5)} => ${gradeOf(score)}');
  }

  print('');
  // 非法字符串输入
  print('输入 "abc" => ${parseAndGrade('abc')}');
  print('输入 "85"  => ${parseAndGrade('85')}');
  print('输入 "120" => ${parseAndGrade('120')}');
}
