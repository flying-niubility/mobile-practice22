/// 类型与空安全示例：变量声明、字符串插值、空安全四件套。
///
/// AI 使用标注：TraeCode 生成初稿，本人逐行核对并运行验证
/// （验证方式：dart run + dart analyze，输出见进度报告第五节）。
library;

void runTypesDemo() {
  print('===== types_demo：变量与内置类型 =====');

  // 1. 变量声明与类型推断
  var title = '第一次作业'; // 推断为 String，之后不能再赋 int
  int year = 2026;
  double score = 92.5;
  final now = DateTime.now(); // 运行时确定，只赋值一次
  const pi = 3.14159; // 编译期常量

  print('title=$title（${title.runtimeType}）');
  print('year=$year, score=$score, pi=$pi');
  print('now=${now.year}-${now.month}-${now.day}');

  // 2. 字符串：单双引号等价、三引号多行、插值
  final name = '李华';
  print('你好，$name，成绩${score + 5}'); // $变量 / ${表达式}
  print('''
多行文本示例：
  课程：$title
  时间：$year
''');

  // 3. bool 没有 truthy：if (name) 是编译错误，必须显式比较
  final bool passed = score >= 60;
  print('是否及格：$passed（Dart 的 bool 只有 true/false）');

  // 4. 空安全四件套
  String? nickname = _readNickname(); // 可空类型，此处返回 null
  print('安全调用 nickname?.length => ${nickname?.length}'); // null 短路
  print('默认值   nickname ?? "未填写" => ${nickname ?? '未填写'}');

  // 非 final 字段不会被类型提升，确实需要 ! 断言的场景
  final profile = _Profile()..nickname = 'hu';
  print('空断言   profile.nickname!.length => ${profile.nickname!.length}');

  // 5. late：承诺使用前一定赋值（适合初始化成本高的字段）
  late String token;
  token = 'tk_2026';
  print('late 延迟初始化 token => $token');

  // 6. 故意实验：对 null 使用 ! 的运行时错误类型
  final empty = _Profile();
  try {
    print(empty.nickname!.length);
  } catch (e) {
    print('对 null 使用 ! 的运行时错误类型：${e.runtimeType}');
  }
}

/// 用于演示“非 final 字段不做类型提升”的小类。
class _Profile {
  String? nickname;
}

/// 模拟从接口读取昵称，本次返回 null。
String? _readNickname() => null;
