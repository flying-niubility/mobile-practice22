# 进度报告2（第4周 · Dart 语言基础一）

> 仓库：https://github.com/flying-niubility/mobile-practice22
> 工程：`dart_basics`

## 一、任务理解

本次作业要完成三件事：

1. **案例复现**：用 `dart create` 建纯 Dart 工程 `dart_basics`，补齐类型、函数、控制流四组示例，`dart run` 能一次跑通全部输出。
2. **自主实践**：空安全改写（含隐患的可空代码改成安全版本并逐处解释）、为“实验报告生成器”设计命名参数函数并给三种调用、成绩分级器扩展（处理 0/100 边界与非法输入）、一轮 TraeCode 对拍记录。
3. **过程留痕**：Git 提交不少于 3 次，进度报告与对拍记录入库。

验收标准：`dart run` 全部输出正确且无编译告警；空安全改写有前后对照；能口头解释 `??` 与 `!` 的区别；提交记录可追溯。

## 二、环境与工具

| 项目 | 内容 |
| --- | --- |
| 操作系统 | Windows 11 |
| Dart SDK | 3.13.4 (stable) |
| Flutter SDK | 3.47.x（`dart` 来自 Flutter SDK 自带） |
| 编辑器 / AI 工具 | TraeCode（DeepSeek 模型） |
| 运行目标 | 命令行（Dart VM），本课为纯 Dart，不涉及 Web/模拟器/真机 |
| 版本控制 | Git 2.x，远程 GitHub |

## 三、过程记录

1. 阅读实践指南二，确认课堂案例 `dart_basics` 与作业二五项任务。
2. 终端执行 `dart create -t console dart_basics`，自动生成 `bin/`、`lib/`、`test/` 结构与依赖；首次提交。
3. 新建 `types_demo.dart`、`func_demo.dart`、`flow_demo.dart`，在 `lib/dart_basics.dart` 放共用函数（`enroll`、`gradeOf`、`add`、`apply`），入口 `bin/dart_basics.dart` 统一调用。
4. `dart format` 统一格式，`dart analyze` 消除告警，`dart run` 核对全部输出。
5. 完成作业：`safety_refactor.dart`（空安全改写对照）、`report_generator.dart`（命名参数三种调用）、`grade.dart`（边界与非法输入）。
6. 让 TraeCode 出 5 道“预测输出”题，先手写作答，再生成参考答案，逐题复核并把 2 处分歧记录到 `lecture2/ai_quiz_round1.md`。
7. 补充单元测试并 `dart test` 全绿；整理 README 与进度报告，提交并推送。

## 四、关键代码

### 4.1 空安全改写（作业1）

```dart
// 改写前：! 强断言，遇到 null 直接崩
try {
  print('昵称长度：${user.nickname!.length}');
} catch (e) {
  print('隐患2 运行时错误：${e.runtimeType}');
}

// 改写后：安全调用 + 默认值 + 判空提升
print('昵称长度：${user.nickname?.length}');
print('昵称显示：${user.nickname ?? '未填写'}');
final bio = user.bio;
if (bio != null) {
  print('简介大写：${bio.toUpperCase()}');
}
```

逐行解释：

- `nickname!.length`：`!` 是“我保证非空”的断言，编译器放行，但运行时若为 null 抛 `Null check operator used on null`（实测 `runtimeType` 为 `_TypeError`）。
- `nickname?.length`：安全调用，接收者为 null 时整条表达式短路为 null，不会访问 `.length`。
- `nickname ?? '未填写'`：空合并，左侧为 null 时取右侧默认值，是替代 `!` 的首选写法。
- 先把 `user.bio` 赋给局部变量再判空：**非 final 字段不会被类型提升**，赋给局部变量后 `if` 内才能安全调用 `toUpperCase()`。
- `!` 仅在“刚赋值、逻辑上必然非空”处保留，并写明理由。

AI 标注：改写建议由 TraeCode 生成，本人逐条运行复现错误后再验证修复效果。

### 4.2 命名参数（作业2）

```dart
String generateReport({
  required String course,
  required String student,
  int week = 1,
  double? score,
  String? comment,
  bool includeAppendix = false,
}) { ... }
```

逐行解释：

- 花括号表示命名参数，调用时必须写参数名，与 Flutter 组件构造函数风格一致。
- `required` 标记 `course`、`student` 必填，漏传是编译错误。
- `week = 1` 给默认值；`score`、`comment` 为可空类型，可不传。
- `includeAppendix = false` 用 bool 开关控制附录段落。
- 三种调用分别是：只传必填、补可选、全参数（含评语与附录），运行输出见第五节。

AI 标注：函数签名由本人按“实验报告生成器”需求设计，TraeCode 仅用于检查参数顺序与可空标注是否规范。

### 4.3 成绩分级器扩展（作业3）

```dart
String gradeOf(num score) {
  if (score.isNaN || score < 0 || score > 100) {
    return '非法成绩';
  }
  if (score >= 90) return '优';
  if (score >= 80) return '良';
  if (score >= 60) return '中';
  return '不及格';
}
```

逐行解释：

- 参数用 `num`，同时接受 `int` 与 `double`，方便处理 59.9 这类小数。
- 第一道关卡拦截 `NaN`、负数和超过 100 的值，统一返回“非法成绩”。
- 之后按 90/80/60 三档从高到低判断，`0` 落入“不及格”，`100` 落入“优”，边界不遗漏。
- 字符串输入由 `parseAndGrade` 用 `double.tryParse` 兜底，解析失败即非法。

AI 标注：边界用例清单由本人列出，TraeCode 补充了 `double.nan` 这一条。

## 五、检查点结果

### 5.1 `dart run`（节选）

```
===== types_demo：变量与内置类型 =====
title=第一次作业（String）
你好，李华，成绩97.5
安全调用 nickname?.length => null
默认值   nickname ?? "未填写" => 未填写
空断言   profile.nickname!.length => 2
对 null 使用 ! 的运行时错误类型：_TypeError

===== func_demo：函数 =====
add(2, 3) = 5
报名成功：赵敏，年龄 19，班级 2班

===== flow_demo：运算符与控制流 =====
7 / 2 = 3.5（double），7 ~/ 2 = 3（整除）
score=59.5 => 不及格
score=100 => 优
等级映射：优 -> A
```

### 5.2 静态检查与测试

```
$ dart analyze
No issues found!

$ dart test
00:00 +5: All tests passed!
```

### 5.3 空安全改写运行结果

```
----- 改写前（有隐患）-----
隐患2 运行时错误：_TypeError
隐患4 运行时错误：LateError

----- 改写后（安全版本）-----
昵称长度：null
昵称显示：未填写
简介大写：跳过（简介为空）
头像地址：https://example.com/avatar/default.png
确认赋值后再用 !：2
```

结论：`dart run` 全部输出正确，`dart analyze` 无告警，空安全改写前后对比清晰。

**口头解释**：`??` 是“空合并”，遇到 null 换一个默认值，表达式仍可用；`!` 是“空断言”，运行时不满足就抛异常，属于把风险从编译期挪到运行期，所以只在确定非空时用。

## 六、问题与调试

**问题1：`dart test` 断言失败，Expected 42，Actual 13**

- 现象：`expect(apply(6, 7, add), 42)` 失败。
- 定位：`apply` 把第三个参数当运算符调用，传入 `add` 自然是 6 + 7 = 13，42 是 `6 * 7` 的旧模板值，属于我照抄模板没改。
- 解决：把期望值改成 13，另加一条 `apply(6, 7, (a, b) => a * b)` 断言 42，测试全绿。

**问题2：`dart analyze` 报 `definitely_unassigned_late_local_variable`**

- 现象：为演示 `LateInitializationError` 写了 `late final String avatarUrl;` 后直接打印，分析器直接报错。
- 定位：局部 `late` 变量的未赋值路径会被静态检查拦住，无法用来演示运行时错误。
- 解决：改为在类中声明 `late String token;`，通过实例读取，成功捕获到 `LateError`，既保留演示又消除告警。

**问题3：`dart analyze` 报 `dead_code` / `unnecessary_non_null_assertion`**

- 现象：`String? s; print(s?.length)` 被判定为死代码；赋值后 `s!` 被判为多余断言。
- 定位：局部变量初始化后是“确定 null / 确定非空”，分析器能精确推断。
- 解决：用返回 `String?` 的函数模拟接口读取，用非 final 字段演示必须使用 `!` 的场景，告警清零。

## 七、AI 使用记录

| 用途 | 指令摘要 | 输出 | 本人验证方式 |
| --- | --- | --- | --- |
| 生成示例初稿 | “按指南写 types/func/flow 三个示例，含空安全四件套与命名参数” | 三个 demo 文件初稿 | 逐行阅读，`dart run` 核对输出，改写不准确的注释 |
| 出对拍题 | “基于空安全、命名参数、整除出 5 道预测输出题” | 5 题与参考答案 | 先手写作答再对照，2 处分歧实测复核并记录 |
| 空安全改写建议 | “把这段强断言代码改成安全版本并逐处解释” | `?.`、`??`、判空提升、late 正确用法 | 运行改写前后两版，对比异常类型 |
| 边界用例补充 | “成绩分级器还要考虑哪些边界” | 补充 `double.nan`、100.1、字符串解析失败 | 写入 `grade.dart` 并运行确认输出 |
| 告警修复 | “解释这三个 analyze 告警并给最小改法” | 局部 late 改字段、用函数规避常量折叠 | 重新 `dart analyze` 至 No issues found |

所有 AI 生成内容均已标注，且经本人运行验证后才提交。

## 八、证据截图 / 文本证据

> 本机截图另附雨课堂；以下为可复现的控制台文本证据。

1. 示例合集入口运行：`dart run` 输出四组示例，末尾打印“全部示例执行完毕。”
2. 静态检查：`dart analyze` → `No issues found!`
3. 单元测试：`dart test` → `00:00 +5: All tests passed!`
4. Git 提交记录：

```
dce0da7 docs: ai quiz round 1 records
f28c7e7 feat: dart create dart_basics with types/func/flow demos
04ce8d2 chore: init mobile-practice22 repository
```

5. 对拍记录：`lecture2/ai_quiz_round1.md`（5 题、2 处分歧及复核结论）。

## 九、自评

| 要求 | 完成情况 | 说明 |
| --- | --- | --- |
| dart_basics 完整复现（15） | 完成 | 三组示例 + 入口统一调用，输出完整 |
| 检查点（5） | 完成 | `dart run` 正确、`dart analyze` 无告警、能解释 `??` 与 `!` |
| Git 规范（5） | 完成 | 4 次提交，提交信息使用 feat/docs/chore 前缀 |
| 报告记录（5） | 完成 | 十节齐全，含代码、证据、调试与 AI 记录 |
| 空安全改写 | 完成 | 5 处改写，前后对照 + 逐处解释 |
| 命名参数设计 | 完成 | 6 个参数（2 必填 + 默认值 + 可空 + 开关），三种调用 |
| 控制流小程序 | 完成 | 覆盖 0、100、越界、NaN、非法字符串 |
| TraeCode 对拍 | 完成 | 5 题记录，2 处分歧已复核 |
| AI 使用标注 | 完成 | 代码头注释 + 报告第七节 |

## 十、一句话收获与下一步计划

一句话收获：Dart 的空安全把“可能为空”写进类型系统，`?.` 和 `??` 是日常写法，`!` 只是万不得已的逃生门。

下一步：预习第 3 课集合（List/Map/Set）与迭代器，把对拍练习扩展到集合的 `map`/`where` 链式调用，并尝试用 `const` 优化常量集合。
