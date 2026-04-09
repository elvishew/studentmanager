# 课程规划页使用文档

---

## 文件说明

`lib/pages/course_plan_page.dart` - 课程规划页

**包含两个页面：**
1. `CoursePlanPage` - 课程规划主页（课时列表）
2. `SessionDetailPage` - 课时详情页

---

## 功能说明

### CoursePlanPage（课程规划页）

**核心功能：**
- ✅ 显示课时列表
- ✅ 显示每节课的状态
- ✅ 点击进入课时详情
- ✅ 下拉刷新

### SessionDetailPage（课时详情页）

**核心功能：**
- ✅ 显示课时基本信息
- ✅ 显示训练块列表
- ✅ 显示训练内容（动作、器械、工具、次数、组数等）

---

## 页面结构

### CoursePlanPage

```
Scaffold
├── AppBar
│   └── Title: 课程规划
└── Body (ListView)
    └── SessionTile × N
        ├── CircleAvatar (课时序号)
        ├── Title: 第 X 节课
        ├── Subtitle
        │   ├── 状态标签
        │   └── 上课时间
        └── Trailing: Icon(Icons.chevron_right)
```

### SessionDetailPage

```
Scaffold
├── AppBar
│   └── Title: 第 X 节课
└── Body (ScrollView)
    ├── 基本信息
    │   ├── 课时序号
    │   ├── 状态
    │   └── 上课时间
    └── 训练内容
        └── TrainingBlockCard × N
            ├── 序号 + 自定义标记
            ├── 动作
            ├── 器械
            ├── 工具
            ├── 次数、组数
            ├── 时长、强度
            └── 备注
```

---

## 使用方法

### 导航到课程规划页

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => CoursePlanPage(
      coursePlanId: 1, // 课程规划ID
    ),
  ),
);
```

### 导航到课时详情页

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => SessionDetailPage(
      sessionId: 1, // 课时ID
    ),
  ),
);
```

---

## 课时状态说明

### 状态枚举

| 状态 | 值 | 颜色 | 说明 |
|------|-----|------|------|
| 未开始 | pending | 橙色 | 尚未上课 |
| 已完成 | completed | 绿色 | 已消课 |
| 已跳过 | skipped | 灰色 | 跳过该节课 |

### 状态标签样式

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  decoration: BoxDecoration(
    color: color.withOpacity(0.1),
    borderRadius: BorderRadius.circular(4),
    border: Border.all(color: color, width: 1),
  ),
  child: Text(
    label,
    style: TextStyle(
      color: color,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
)
```

---

## UI 组件说明

### 课时列表项

```dart
ListTile(
  leading: CircleAvatar(
    backgroundColor: _getStatusColor(session.status),
    child: Text('${session.sessionNumber}'),
  ),
  title: Text('第 X 节课'),
  subtitle: Column(
    children: [
      _buildStatusLabel(session.status),
      if (session.scheduledTime != null)
        Text(formattedDateTime),
    ],
  ),
  onTap: () => _navigateToSessionDetail(session.id),
)
```

### 训练块卡片

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(12.0),
    child: Column(
      children: [
        // 标题：序号 + 自定义标记
        Row(
          children: [
            Text('训练块 X'),
            if (block.isCustom)
              Container(
                decoration: BoxDecoration(
                  color: Colors.purple.withOpacity(0.1),
                  border: Border.all(color: Colors.purple),
                ),
                child: Text('自定义'),
              ),
          ],
        ),
        // 动作、器械、工具
        _buildDetailRow('动作', action.name),
        _buildDetailRow('器械', equipment.name),
        _buildDetailRow('工具', tool.name),
        // 次数、组数
        Row(
          children: [
            Expanded(child: _buildDetailItem('次数', reps)),
            Expanded(child: _buildDetailItem('组数', sets)),
          ],
        ),
        // 时长、强度、备注
        _buildDetailRow('时长', duration),
        _buildDetailRow('强度', intensity),
        _buildDetailRow('备注', notes),
      ],
    ),
  ),
)
```

---

## 数据流程

### 页面加载

```
CoursePlanPage 初始化
    ↓
initState()
    ↓
PostFrameCallback
    ↓
sessionNotifier.fetchByCoursePlanId()
    ↓
查询数据库
    ↓
State 更新为 data
    ↓
UI 重建显示列表
```

### 点击课时

```
用户点击课时卡片
    ↓
Navigator.push(SessionDetailPage)
    ↓
SessionDetailPage.initState()
    ↓
_loadSession()
    ↓
sessionNotifier.getDetailById()
    ↓
查询课时 + 训练块
    ↓
显示详情
```

---

## Provider 集成

### 使用的 Provider

```dart
sessionNotifierProvider
```

### 读取数据

```dart
// 监听课时列表状态
final sessionState = ref.watch(sessionNotifierProvider);

// 读取方法
final notifier = ref.read(sessionNotifierProvider.notifier);
await notifier.fetchByCoursePlanId(coursePlanId);

// 获取详情
final session = await notifier.getDetailById(sessionId);
```

---

## 状态处理

### 加载状态

```dart
sessionState.when(
  initial: () => _buildInitialView(),
  loading: () => _buildLoadingView(),
  error: (error, _) => _buildErrorView(error),
  data: (sessions, _, __) {
    // 显示课时列表
    final coursePlanSessions = sessions
        .where((s) => s.coursePlanId == widget.coursePlanId)
        .toList();

    return _buildSessionList(coursePlanSessions);
  },
)
```

### 错误处理

```dart
Widget _buildErrorView(Object error) {
  return Center(
    child: Column(
      children: [
        Icon(Icons.error_outline),
        Text('加载失败'),
        Text(error.toString()),
        ElevatedButton(
          onPressed: () {
            ref.read(sessionNotifierProvider.notifier)
                .fetchByCoursePlanId(widget.coursePlanId);
          },
          child: Text('重试'),
        ),
      ],
    ),
  );
}
```

---

## 格式化函数

### 日期时间格式化

```dart
String _formatDateTime(DateTime dateTime) {
  return '${dateTime.month}月${dateTime.day}日 '
      '${dateTime.hour.toString().padLeft(2, '0')}:'
      '${dateTime.minute.toString().padLeft(2, '0')}';
}
```

示例输出：`1月15日 10:00`

### 状态颜色映射

```dart
Color _getStatusColor(SessionStatus status) {
  switch (status) {
    case SessionStatus.pending:   return Colors.orange;
    case SessionStatus.completed: return Colors.green;
    case SessionStatus.skipped:   return Colors.grey;
  }
}
```

---

## 训练内容展示

### 训练块包含的字段

- **序号** - 排序序号（1, 2, 3...）
- **自定义标记** - 紫色标签（如果 is_custom = true）
- **动作** - 动作名称（如"宽蹲"）
- **器械** - 器械名称（如"核心床"）
- **工具** - 工具名称（如"小球"）
- **次数** - 次数（如"12"）
- **组数** - 组数（如"3"）
- **时长** - 时长（如"30秒"）
- **强度** - 强度（如"中等"）
- **备注** - 备注信息

---

## 下拉刷新

```dart
RefreshIndicator(
  onRefresh: () async {
    await ref.read(sessionNotifierProvider.notifier)
        .fetchByCoursePlanId(widget.coursePlanId);
  },
  child: ListView.separated(...),
)
```

---

## 注意事项

1. **数据过滤** - 页面只显示当前课程规划的课时
2. **自动加载** - 页面初始化时自动加载数据
3. **错误重试** - 提供重试按钮
4. **空状态处理** - 没有课时时显示友好提示
5. **自定义标记** - 训练块显示自定义标记
6. **关联数据** - 课时详情包含完整的训练块信息

---

## 后续扩展

可以添加的功能（当前未实现）：

1. **编辑课时** - 修改上课时间和状态
2. **添加课时** - 添加新课时
3. **删除课时** - 删除课时
4. **移动课时** - 调整课时顺序
5. **编辑训练块** - 修改训练内容
6. **训练块排序** - 拖拽排序
7. **添加训练块** - 添加新的训练块
8. **状态筛选** - 按状态筛选课时

---

## 测试场景

1. **有数据的课程规划** - 查看有课时的课程规划
2. **无数据的课程规划** - 查看没有课时的课程规划
3. **不同状态的课时** - 查看未开始/已完成/已跳过的课时
4. **有训练内容的课时** - 查看包含训练块的课时详情
5. **无训练内容的课时** - 查看没有训练块的课时
6. **自定义训练块** - 查看包含自定义训练块的课时
7. **下拉刷新** - 测试刷新功能
8. **错误状态** - 模拟加载失败

---

## 完整示例

### 在学员详情页使用

```dart
// 在 student_detail_page.dart 中
Widget _buildCoursePlanCard(CoursePlan coursePlan) {
  return Card(
    child: ListTile(
      title: Text(coursePlan.goal),
      subtitle: Text('完成率: ${coursePlan.completionRate * 100}%'),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CoursePlanPage(
              coursePlanId: coursePlan.id,
            ),
          ),
        );
      },
    ),
  );
}
```
