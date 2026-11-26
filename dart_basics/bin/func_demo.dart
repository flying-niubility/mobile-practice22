/// 函数示例：箭头函数、函数作为参数、位置可选参数、命名参数。
library;

import 'package:dart_basics/dart_basics.dart' as basics;

void runFuncDemo() {
  print('===== func_demo：函数 =====');

  print('add(2, 3) = ${basics.add(2, 3)}');
  print('apply(6, 7, add) = ${basics.apply(6, 7, basics.add)}（函数作为参数）');

  // 位置可选参数：用方括号声明，调用时可省略
  print(greet('李华'));
  print(greet('李华', '同学'));

  // 命名参数：required 必填，age 走默认值，className 可空
  basics.enroll(name: '李华');
  basics.enroll(name: '王芳', age: 20);
  basics.enroll(name: '赵敏', age: 19, className: '2班');

  // 函数作为变量保存（一等公民）
  final int Function(int, int) op = basics.add;
  print('op(10, 20) = ${op(10, 20)}');
}

/// 位置可选参数示例。
String greet(String name, [String? title]) {
  return '你好，${title ?? ''}$name';
}
