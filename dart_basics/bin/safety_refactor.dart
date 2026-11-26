/// 作业任务1：空安全改写（改写前 / 改写后对照）。
///
/// 改写前的隐患代码对应作业页附件中的“用户资料读取”场景。
/// AI 使用标注：TraeCode 仅用于生成改写建议，四处改写均由本人
/// 逐条运行复现错误并验证修复效果（证据见进度报告第五节）。
library;

/// 用户资料：三个字段都可空。
class UserProfile {
  UserProfile({this.nickname, this.bio, this.website});

  String? nickname;
  String? bio;
  String? website;
}

/// 用于复现 LateInitializationError 的类。
class TokenHolder {
  late String token;
}

/// 改写前：能通过编译，但运行时会崩（部分写法编译期就报错）。
void beforeRefactor() {
  print('----- 改写前（有隐患）-----');
  final user = UserProfile(); // 三个字段都是 null

  // 隐患1：对可空值直接 .length —— 编译错误
  // Error: The property 'length' can't be unconditionally accessed
  // because the receiver can be null.
  // print(user.nickname.length);

  // 隐患2：! 强行断言非空 —— null 时抛 Null check operator used on null
  try {
    print('昵称长度：${user.nickname!.length}');
  } catch (e) {
    print('隐患2 运行时错误：${e.runtimeType}');
  }

  // 隐患3：未判空就调用方法 —— 同样在运行时崩溃
  // print(user.bio.toUpperCase());

  // 隐患4：late 字段未赋值就读取 —— 抛 LateInitializationError
  final holder = TokenHolder();
  try {
    print(holder.token);
  } catch (e) {
    print('隐患4 运行时错误：${e.runtimeType}');
  }
}

/// 改写后：用 ?.、??、判空提升、late 正确初始化消除隐患。
void afterRefactor() {
  print('----- 改写后（安全版本）-----');
  final user = UserProfile();

  // 改写1：安全调用，null 时短路返回 null，不会崩
  print('昵称长度：${user.nickname?.length}');

  // 改写2：用 ?? 提供默认值，替代 ! 强断言
  print('昵称显示：${user.nickname ?? '未填写'}');

  // 改写3：先判空再使用，Dart 类型提升让局部变量在该分支内变成非空
  final bio = user.bio;
  if (bio != null) {
    print('简介大写：${bio.toUpperCase()}');
  } else {
    print('简介大写：跳过（简介为空）');
  }

  // 改写4：late 先赋值再读取，避免 LateInitializationError
  late final String avatarUrl;
  avatarUrl = 'https://example.com/avatar/${user.nickname ?? 'default'}.png';
  print('头像地址：$avatarUrl');

  // 改写5：! 只在“逻辑上必然非空”时保留，并写明理由
  user.nickname = 'hu'; // 上一行刚赋值，此处非空可断言
  print('确认赋值后再用 !：${user.nickname!.length}');
}

void main() {
  beforeRefactor();
  print('');
  afterRefactor();
}
