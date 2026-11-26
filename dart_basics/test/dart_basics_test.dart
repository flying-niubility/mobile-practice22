import 'package:dart_basics/dart_basics.dart';
import 'package:test/test.dart';

void main() {
  group('gradeOf 分级器', () {
    test('正常区间', () {
      expect(gradeOf(95), '优');
      expect(gradeOf(85), '良');
      expect(gradeOf(60), '中');
      expect(gradeOf(59.9), '不及格');
    });

    test('边界 0 与 100', () {
      expect(gradeOf(0), '不及格');
      expect(gradeOf(100), '优');
    });

    test('非法输入', () {
      expect(gradeOf(-1), '非法成绩');
      expect(gradeOf(100.1), '非法成绩');
      expect(gradeOf(double.nan), '非法成绩');
    });
  });

  test('add 与 apply', () {
    expect(add(2, 3), 5);
    expect(apply(6, 7, add), 13);
    expect(apply(6, 7, (a, b) => a * b), 42);
  });

  test('divideDemo 区分 / 与 ~/', () {
    expect(divideDemo(7, 2), '7 / 2 = 3.5（double），7 ~/ 2 = 3（整除）');
  });
}
