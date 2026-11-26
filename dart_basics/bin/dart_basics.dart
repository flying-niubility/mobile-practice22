/// dart_basics 入口：依次运行四组示例。
library;

import 'flow_demo.dart';
import 'func_demo.dart';
import 'types_demo.dart';

void main(List<String> arguments) {
  print('dart_basics：Dart 语言基础一示例合集\n');
  runTypesDemo();
  print('');
  runFuncDemo();
  print('');
  runFlowDemo();
  print('\n全部示例执行完毕。');
}
