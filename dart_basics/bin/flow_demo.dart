/// 运算符与控制流示例：整除、for-in、while、do-while、break/continue、switch。
library;

import 'package:dart_basics/dart_basics.dart';

void runFlowDemo() {
  print('===== flow_demo：运算符与控制流 =====');

  // 算术运算符：/ 得 double，~/ 整除，% 取余，== 判值相等
  print(divideDemo(7, 2));
  print('7 % 2 = ${7 % 2}');
  print('1 == 1.0 => ${1 == 1.0}');

  // for-in 遍历集合
  for (final i in [1, 2, 3]) {
    print('第$i题');
  }

  // while：先判断再执行
  var count = 3;
  while (count > 0) {
    print('while 倒计时 $count');
    count--;
  }

  // do-while：至少执行一次
  var n = 0;
  do {
    print('do-while 至少执行一次，n=$n');
    n++;
  } while (n < 0);

  // continue 跳过、break 结束
  for (var i = 0; i < 6; i++) {
    if (i == 2) continue;
    if (i == 5) break;
    print('for i=$i');
  }

  // 分支：if / else if / else（条件必须是 bool）
  for (final s in <num>[95, 85, 72, 59.5, 0, 100]) {
    print('score=$s => ${gradeOf(s)}');
  }

  // switch 表达式（Dart 3 模式匹配，了解即可）
  final label = switch (gradeOf(95)) {
    '优' => 'A',
    '良' => 'B',
    '中' => 'C',
    _ => 'D',
  };
  print('等级映射：${gradeOf(95)} -> $label');
}
