# TraeCode 对拍练习记录（第 1 轮）

范围：空安全、命名参数、整除。流程：本人先手写作答 → TraeCode 生成参考答案与讲解 → 逐题复核，分歧记入下表。

## 第 1 题（空安全 · 安全调用）

```dart
String? s;
print(s?.length);
print(s ?? '空');
```

- 我的答案：`null`、`空`
- AI 答案：`null`、`空`
- 分歧复核：无。`?.` 在 null 时短路返回 null，`??` 在 null 时取右侧默认值。

## 第 2 题（命名参数 · 默认值）

```dart
void f({required int a, int b = 2}) => print(a + b);
f(a: 1);
f(a: 1, b: 3);
```

- 我的答案：`3`、`4`
- AI 答案：`3`、`4`
- 分歧复核：无。`required` 只约束必填，`b` 不传时取默认值 2。

## 第 3 题（整除与浮点除法）

```dart
print(7 / 2);
print(7 ~/ 2);
print(7 % 2);
```

- 我的答案：`3.5`、`3`、`1`
- AI 答案：`3.5`、`3`、`1`
- 分歧复核：无。`/` 结果恒为 double，`~/` 截断取整，`%` 取余。

## 第 4 题（空安全 · 类型提升）

```dart
String? name = 'Dart';
if (name != null) {
  print(name.length);
}
```

- 我的答案：可能编译报错，需要写 `name!.length`
- AI 答案：输出 `4`，局部变量判空后自动提升为非空，不需要 `!`
- 分歧复核：**AI 正确，我错**。在 `dart run` 实测输出 `4`；`dart analyze` 无告警。原因是局部变量在 `if (name != null)` 分支内被类型提升为 `String`；非 final 的实例字段则不会提升，这也是 `types_demo.dart` 中 `_Profile.nickname` 仍需 `!` 的原因。

## 第 5 题（空安全 · late）

```dart
late String token;
print(token);
```

- 我的答案：输出 `null`
- AI 答案：运行时抛 `LateInitializationError`
- 分歧复核：**AI 正确，我错**。实测 `dart run bin/safety_refactor.dart` 捕获到的异常类型为 `LateError`（即 `LateInitializationError` 的运行时类型）。`late String` 是非空类型，未赋值直接读取不会得到 null，而是抛错。

## 本轮结论

1. 5 题中 3 题一致、2 题分歧，分歧都集中在“类型提升”和“late 未初始化”两个语义点，已用实测输出确认。
2. 后续判断可空值能否直接使用，先看它是不是**局部变量**且已被判空；字段一律借助 `?.`、`??` 或局部变量承接。
3. `!` 只在逻辑上必然非空（如刚赋值）时使用，其余场景优先 `?.` 与 `??`。
