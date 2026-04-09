# 学员详情页使用文档

---

## 功能说明

`lib/pages/student_detail_page.dart` - 学员详情页

### 核心功能

1. **学员信息展示**
   - 头像（姓名首字母）
   - 姓名、性别
   - 联系方式
   - 备注
   - 创建时间

2. **课程规划列表**
   - 显示该学员的所有课程规划
   - 每个课程规划显示：
     - 目标（带图标和颜色）
     - 蓝图描述
     - 课时进度（已完成/总数）
     - 完成率百分比

3. **新建课程规划按钮**
   - 点击弹出选择目标对话框
   - 选择目标后自动创建课程规划（带默认配置）

---

## 页面结构

```
Scaffold
├── AppBar
│   └── Title: 学员详情
└── Body (SingleChildScrollView)
    ├── 学员信息卡片
    │   ├── 头像 + 姓名 + 性别
    │   └── 信息行（联系方式、备注、创建时间）
    └── 课程规划部分
        ├── 标题 + 新建按钮
        └── 课程规划列表
            └── 课程规划卡片
                ├── 目标（图标 + 颜色）
                ├── 蓝图
                ├── 课时进度
                └── 完成率
```

---

## 数据流程

### 页面加载

```
StudentDetailPage 初始化
    ↓
initState()
    ├→ _loadStudent()          // 加载学员信息
    └→ PostFrameCallback
       └→ fetchByStudentId()   // 加载课程规划列表
```

### 新建课程规划

```
点击"新建"按钮
    ↓
显示 _SelectGoalDialog
    ↓
用户选择目标
    ↓
coursePlanNotifier.create()
    ↓
Repository 复制默认配置
    ↓
创建前12节课
    ↓
显示 SnackBar 提示
    ↓
课程规划列表自动刷新
```

---

## 使用方法

### 导航到详情页

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => StudentDetailPage(
      studentId: 1, // 学员ID
    ),
  ),
);
```

### 刷新数据

```dart
// 重新加载学员信息
await ref.read(studentNotifierProvider.notifier).getById(studentId);

// 重新加载课程规划
await ref.read(coursePlanNotifierProvider.notifier).fetchByStudentId(studentId);
```

---

## UI 组件说明

### 学员信息卡片

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
      children: [
        // 头像 + 基本信息
        Row(
          children: [
            CircleAvatar(child: Text(name[0])),
            SizedBox(width: 16),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: titleLarge),
                Text(gender),
              ],
            )),
          ],
        ),
        Divider(),
        // 信息行
        _buildInfoRow(
          icon: Icons.phone,
          label: '联系方式',
          value: contact,
        ),
        _buildInfoRow(
          icon: Icons.note,
          label: '备注',
          value: notes,
        ),
        _buildInfoRow(
          icon: Icons.access_time,
          label: '创建时间',
          value: formattedDateTime,
        ),
      ],
    ),
  ),
)
```

### 课程规划卡片

```dart
Card(
  child: ListTile(
    leading: CircleAvatar(
      backgroundColor: _getGoalColor(goal),
      child: Icon(_getGoalIcon(goal), color: Colors.white),
    ),
    title: Text(goal),
    subtitle: Column(
      children: [
        Text(blueprint),
        Row(
          children: [
            Icon(Icons.fitness_center, size: 14),
            Text('完成数/总数'),
            Icon(Icons.pie_chart, size: 14),
            Text('完成率'),
          ],
        ),
      ],
    ),
    trailing: Icon(Icons.chevron_right),
    onTap: () {
      // TODO: 跳转到课程规划详情
    },
  ),
)
```

### 选择目标对话框

```dart
Dialog(
  title: Text('选择课程目标'),
  content: ListView.builder(
    itemCount: CourseGoal.values.length,
    itemBuilder: (context, index) {
      final goal = CourseGoal.values[index];
      return ListTile(
        leading: Icon(_getGoalIcon(goal)),
        title: Text(goal.label),
        onTap: () => Navigator.pop(context, goal),
      );
    },
  ),
)
```

---

## 课程目标映射

### 图标和颜色

| 目标 | 图标 | 颜色 |
|------|------|------|
| 产后修复 | Icons.pregnant_woman | Colors.pink |
| 肩颈理疗 | Icons.accessibility_new | Colors.blue |
| 肩背打造 | Icons.rowing | Colors.purple |
| 腰酸治疗 | Icons.healing | Colors.orange |
| 腰腹塑形 | Icons.monitor_heart | Colors.red |
| 全身塑形 | Icons.fitness_center | Colors.green |
| 臀腿打造 | Icons.directions_run | Colors.teal |
| 膝盖疼痛 | Icons.airline_seat_recline_extra | Colors.amber |
| 自定义 | Icons.event_note | Colors.grey |

---

## 状态处理

### 学员信息加载

```dart
Student? _student;

Future<void> _loadStudent() async {
  final notifier = ref.read(studentNotifierProvider.notifier);
  final student = await notifier.getById(widget.studentId);
  if (mounted) {
    setState(() {
      _student = student;
    });
  }
}
```

### 课程规划加载

```dart
final coursePlanState = ref.watch(coursePlanNotifierProvider);

coursePlanState.when(
  initial: () => _buildEmptyState('暂无课程规划'),
  loading: () => CircularProgressIndicator(),
  error: (e, _) => _buildErrorState(e),
  data: (coursePlans, selectedCoursePlan, filteredStudentId) {
    // 过滤当前学员的课程规划
    final studentPlans = coursePlans
        .where((plan) => plan.studentId == widget.studentId)
        .toList();

    if (studentPlans.isEmpty) {
      return _buildEmptyState('暂无课程规划');
    }

    return Column(
      children: studentPlans.map((plan) {
        return _buildCoursePlanCard(plan);
      }).toList(),
    );
  },
)
```

---

## Provider 集成

### 使用的 Provider

```dart
// 学员数据
studentNotifierProvider

// 课程规划数据
coursePlanNotifierProvider
```

### 读取数据

```dart
// 监听课程规划状态
final coursePlanState = ref.watch(coursePlanNotifierProvider);

// 读取方法
final notifier = ref.read(coursePlanNotifierProvider.notifier);
await notifier.create(
  studentId: widget.studentId,
  goal: selectedGoal.value,
);
```

---

## 错误处理

### 加载失败

```dart
Widget _buildErrorState(Object error) {
  return Container(
    padding: EdgeInsets.all(32.0),
    child: Column(
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red),
        SizedBox(height: 12),
        Text('加载失败', style: TextStyle(color: Colors.red)),
        SizedBox(height: 8),
        Text(error.toString(), textAlign: TextAlign.center),
      ],
    ),
  );
}
```

---

## 完成率颜色

```dart
Color _getCompletionRateColor(double rate) {
  if (rate >= 1.0) return Colors.green;  // 100% 完成
  if (rate >= 0.5) return Colors.orange;  // 50% 以上
  return Colors.grey;                     // 50% 以下
}
```

---

## 后续扩展

可以添加的功能：

1. **编辑学员** - 添加编辑按钮
2. **删除学员** - 添加删除功能
3. **课程规划详情** - 点击卡片进入课程规划详情页
4. **课时日历视图** - 显示课时的日历视图
5. **数据统计** - 显示学员的训练统计图表
6. **导出功能** - 导出学员数据为 PDF/Excel

---

## 注意事项

1. **自动加载** - 页面初始化时自动加载课程规划列表
2. **状态持久化** - 使用 `_hasLoadedCoursePlans` 防止重复加载
3. **错误处理** - 所有异步操作都有错误处理
4. **空状态** - 当没有课程规划时显示友好提示
5. **完成率计算** - 自动计算并显示完成率
6. **目标映射** - 根据不同目标显示不同图标和颜色

---

## 测试场景

1. **有数据的学员** - 查看有课程规划的学员
2. **无数据的学员** - 查看没有课程规划的学员
3. **新建课程规划** - 测试创建流程
4. **多个课程规划** - 查看有多个课程规划的学员
5. **加载中状态** - 测试加载过程
6. **错误状态** - 模拟网络错误
