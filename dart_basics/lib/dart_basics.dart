/// Dart 语言基础一：被 bin 示例与 test 共用的函数。
library;

/// 箭头函数：两数相加（单表达式简写）。
int add(int a, int b) => a + b;

/// 函数是一等公民：把函数当参数传入。
int apply(int a, int b, int Function(int, int) op) => op(a, b);

/// 命名参数：required 必填，age 有默认值，className 可空。
void enroll({required String name, int age = 18, String? className}) {
  print('报名成功：$name，年龄 $age，班级 ${className ?? '未分班'}');
}

/// 成绩分级器（扩展版）：处理 0、100 边界与非法输入。
String gradeOf(num score) {
  if (score.isNaN || score < 0 || score > 100) {
    return '非法成绩';
  }
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}

/// 对比 `/`（结果为 double）与 `~/`（整除）。
String divideDemo(int a, int b) =>
    '$a / $b = ${a / b}（double），$a ~/ $b = ${a ~/ b}（整除）';
