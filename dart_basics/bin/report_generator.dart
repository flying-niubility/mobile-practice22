/// 作业任务2：为“实验报告生成器”设计命名参数函数，并给出三种调用。
library;

/// 生成实验报告文本。
///
/// [course] 与 [student] 为必填命名参数；[week] 有默认值；
/// [score]、[comment] 可空；[includeAppendix] 控制是否附加附录说明。
String generateReport({
  required String course,
  required String student,
  int week = 1,
  double? score,
  String? comment,
  bool includeAppendix = false,
}) {
  final buffer = StringBuffer()
    ..writeln('【实验报告】$course · 第 $week 周')
    ..writeln('学生：$student')
    ..writeln('成绩：${score?.toStringAsFixed(1) ?? '未评分'}');
  if (comment != null && comment.isNotEmpty) {
    buffer.writeln('评语：$comment');
  }
  if (includeAppendix) {
    buffer.writeln('附录：运行截图与提交记录见仓库 lecture2/ 目录');
  }
  return buffer.toString();
}

void main() {
  print('===== 命名参数：实验报告生成器 =====');

  // 调用一：只传必填参数，其余走默认值 / null
  print(generateReport(course: '移动应用开发', student: '李华'));

  // 调用二：补充可选参数，顺序无关
  print(generateReport(course: '移动应用开发', student: '李华', week: 4, score: 92.5));

  // 调用三：全部参数（含评语与附录开关）
  print(
    generateReport(
      course: '移动应用开发',
      student: '李华',
      week: 4,
      score: 92.5,
      comment: '空安全改写解释清楚，命名参数使用规范。',
      includeAppendix: true,
    ),
  );
}
