# mobile-practice22

《移动应用开发》课程实践仓库 · 实验二：Dart 语言基础一（变量、类型、函数与控制流）。

## 目录结构

```
mobile-practice22/
├── README.md
├── lecture2/
│   ├── progress.md            # 进度报告二全文
│   └── ai_quiz_round1.md      # TraeCode 对拍练习记录（5 题）
└── dart_basics/               # 课堂案例复现工程
    ├── bin/
    │   ├── dart_basics.dart      # 入口：依次运行四组示例
    │   ├── types_demo.dart       # 变量、插值、空安全四件套
    │   ├── func_demo.dart        # 箭头函数、位置可选参数、命名参数
    │   ├── flow_demo.dart        # 运算符、分支、循环、switch
    │   ├── safety_refactor.dart  # 作业1：空安全改写前后对照
    │   ├── report_generator.dart # 作业2：实验报告生成器命名参数
    │   └── grade.dart            # 作业3：成绩分级器边界与非法输入
    ├── lib/dart_basics.dart      # 被 bin 与 test 共用的函数
    └── test/dart_basics_test.dart
```

## 运行方式

```bash
cd dart_basics
dart pub get
dart run                              # 四组示例
dart run bin/safety_refactor.dart     # 作业1
dart run bin/report_generator.dart    # 作业2
dart run bin/grade.dart               # 作业3
dart analyze                          # 静态检查
dart test                             # 单元测试
```

## AI 使用标注

- 本仓库代码由本人使用 TraeCode 辅助生成初稿，再逐行阅读、修改并用 `dart run`、`dart analyze`、`dart test` 验证。
- 涉及 AI 辅助的文件在文件头与进度报告第七节均有标注，说明用途、指令摘要与验证方式。
- 对拍练习中本人先独立作答，再看 AI 参考答案，分歧逐题复核并记录在 `lecture2/ai_quiz_round1.md`。
