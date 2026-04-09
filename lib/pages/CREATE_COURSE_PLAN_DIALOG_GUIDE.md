# 创建课程规划弹窗使用文档

---

## 文件说明

`lib/pages/create_course_plan_dialog.dart` - 创建课程规划弹窗

---

## 功能说明

### CreateCoursePlanDialog

一个简洁的弹窗组件，用于创建新的课程规划。

**功能：**
- ✅ 选择课程目标（9个选项）
- ✅ 单选按钮（Radio）
- ✅ 确认/取消按钮
- ✅ 创建中状态
- ✅ 返回创建结果

---

## 使用方法

### 方式1：使用辅助函数（推荐）

```dart
// 在任何页面中调用
await showCreateCoursePlanDialog(
  context,
  studentId: 1, // 学员ID
);
```

### 方式2：直接导航

```dart
final result = await Navigator.of(context).push<bool>(
  MaterialPageRoute(
    builder: (context) => CreateCoursePlanDialog(
      studentId: 1,
    ),
  ),
);

if (result == true) {
  // 创建成功
} else {
  // 用户取消或创建失败
}
```

### 方式3：作为对话框

```dart
final result = await showDialog<bool>(
  context: context,
  builder: (context) => CreateCoursePlanDialog(
    studentId: 1,
  ),
);

if (result == true) {
  // 创建成功
}
```

---

## 完整示例

### 在学员详情页使用

```dart
class StudentDetailPage extends ConsumerStatefulWidget {
  final int studentId;

  const StudentDetailPage({super.key, required this.studentId});

  @override
  ConsumerState<StudentDetailPage> createState() => _StudentDetailPageState();
}

class _StudentDetailPageState extends ConsumerState<StudentDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('学员详情'),
      ),
      body: Column(
        children: [
          // 学员信息...
          // 课程规划列表...

          // 新建按钮
          ElevatedButton(
            onPressed: () async {
              await showCreateCoursePlanDialog(
                context,
                studentId: studentId,
              );
            },
            child: const Text('新建课程规划'),
          ),
        ],
      ),
    );
  }
}
```

---

## 数据流程

```
用户点击"新建课程规划"
    ↓
显示 CreateCoursePlanDialog
    ↓
用户选择课程目标（Radio 单选）
    ↓
点击"确认"按钮
    ↓
调用 coursePlanNotifier.create()
    ↓
Repository 复制默认配置（前12节课）
    ↓
数据库插入课程规划和课时
    ↓
显示 CircularProgressIndicator（创建中）
    ↓
创建成功：
  - Navigator.pop(true)
  - 显示 SnackBar 提示
    ↓
课程规划列表自动刷新
```

---

## UI 结构

```
AlertDialog
├── title: "创建课程规划"
├── content
│   ├── Text: "请选择课程目标"
│   └── ListView
│       └── ListTile × 9
│           ├── Radio (选中状态)
│           └── Text (目标名称)
└── actions
    ├── TextButton: "取消"
    └── ElevatedButton: "确认"
```

---

## 课程目标列表

弹窗包含以下9个课程目标选项：

| 序号 | 目标 | 值 |
|------|------|-----|
| 1 | 产后修复 | postpartum |
| 2 | 肩颈理疗 | neckShoulder |
| 3 | 肩背打造 | backShoulder |
| 4 | 腰酸治疗 | backPain |
| 5 | 腰腹塑形 | waistAbs |
| 6 | 全身塑形 | fullBody |
| 7 | 臀腿打造 | gluteLeg |
| 8 | 膝盖疼痛 | kneePain |
| 9 | 自定义 | custom |

---

## 状态管理

### 创建中状态

```dart
bool _isCreating = false;

Future<void> _createCoursePlan() async {
  setState(() {
    _isCreating = true; // 开始创建
  });

  await notifier.create(...);

  if (mounted) {
    setState(() {
      _isCreating = false; // 创建完成
    });
  }
}
```

### UI 反映状态

```dart
ElevatedButton(
  onPressed: _isCreating || _selectedGoal == null ? null : _createCoursePlan,
  child: _isCreating
      ? SizedBox(
          width: 16,
          height: 16,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
      : const Text('确认'),
)
```

---

## Provider 集成

### 使用的 Provider

```dart
coursePlanNotifierProvider
```

### 调用方法

```dart
final notifier = ref.read(coursePlanNotifierProvider.notifier);
final coursePlanId = await notifier.create(
  studentId: widget.studentId,
  goal: _selectedGoal!.value,
);
```

---

## 返回值

### showCreateCoursePlanDialog 返回值

```dart
Future<bool> showCreateCoursePlanDialog(...)
```

- **true** - 创建成功
- **false** - 用户取消或创建失败

### 使用返回值

```dart
final success = await showCreateCoursePlanDialog(
  context,
  studentId: 1,
);

if (success) {
  print('创建成功');
  // 执行后续操作，如刷新列表
} else {
  print('取消或失败');
}
```

---

## 错误处理

### 创建失败处理

```dart
final coursePlanId = await notifier.create(...);

if (coursePlanId == null) {
  // 创建失败（数据库错误或其他原因）
  // Navigator.of(context).pop(false) 自动返回 false
} else {
  // 创建成功
  Navigator.of(context).pop(true);
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('课程规划已创建')),
  );
}
```

---

## 样式自定义

### 修改 Radio 样式

```dart
Radio<CourseGoal>(
  value: goal,
  groupValue: _selectedGoal,
  onChanged: (value) {
    setState(() {
      _selectedGoal = value;
    });
  },
  activeColor: Colors.blue,  // 添加自定义颜色
)
```

### 修改 ListTile 样式

```dart
ListTile(
  leading: Radio(...),
  title: Text(goal.label),
  selected: isSelected,
  selectedColor: Colors.blue,  // 添加选中颜色
  tileColor: MaterialStateProperty.resolveWith((states) {
    if (states.contains(MaterialState.selected)) {
      return Colors.blue.withOpacity(0.1);
    }
    return null;
  }),
)
```

---

## 注意事项

1. **必须选择目标** - 只有选择了目标后，"确认"按钮才可点击
2. **创建中禁用** - 创建过程中禁用所有按钮，防止重复提交
3. **自动关闭** - 创建成功后自动关闭弹窗
4. **成功提示** - 创建成功后显示 SnackBar 提示
5. **Provider 依赖** - 需要确保 `coursePlanNotifierProvider` 可用

---

## 后续扩展

可以添加的功能（当前未实现）：

1. **自定义目标** - 添加文本输入框
2. **蓝图编辑** - 允许在创建时编辑蓝图
3. **课时数量** - 允许指定课时数量
4. **批量创建** - 一次创建多个课程规划
5. **模板预览** - 显示默认配置的预览

---

## 完整代码参考

```dart
// 导入弹窗
import 'create_course_plan_dialog.dart';

// 在按钮点击事件中调用
ElevatedButton(
  onPressed: () async {
    await showCreateCoursePlanDialog(
      context,
      studentId: studentId,
    );
  },
  child: const Text('新建课程规划'),
);
```

---

## 测试场景

1. **取消操作** - 点击"取消"按钮
2. **未选择目标** - 点击"确认"按钮（应该禁用）
3. **选择目标** - 点击任意目标
4. **创建成功** - 选择目标后确认
5. **创建失败** - 模拟数据库错误
6. **重复点击** - 创建中多次点击确认按钮
