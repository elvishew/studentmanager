# 课时详情页使用文档

---

## 文件说明

`lib/pages/course_plan_page.dart` - 已调整 SessionDetailPage

**包含两个页面：**
1. `CoursePlanPage` - 课程规划页（课时列表）
2. `SessionDetailPage` - 课时详情页（训练块管理）

---

## SessionDetailPage 功能说明

### 核心功能

- ✅ 训练块列表显示
- ✅ 添加训练块
- ✅ 编辑训练块
- ✅ 删除训练块
- ✅ 上移/下移排序

---

## 页面结构

### SessionDetailPage

```
Scaffold
├── AppBar
│   └── Title: 第 X 节课
└── Body (ScrollView)
    ├── 基本信息 Section
    │   ├── 课时序号
    │   ├── 状态
    │   └── 上课时间
    └── 训练内容 Section
        ├── 标题 + 添加按钮
        └── 训练块卡片 × N
            ├── 序号 + 自定义标记
            ├── 上移/下移按钮
            ├── 编辑按钮
            ├── 删除按钮
            ├── 动作、器械、工具
            ├── 次数、组数
            ├── 时长、强度、备注
```

---

## UI 组件说明

### 训练块卡片

```dart
Card(
  child: Column(
    children: [
      // 标题行：序号 + 自定义标记 + 操作按钮
      Row(
        children: [
          Text('训练块 X'),
          if (isCustom) Container('自定义'),
          Spacer(),
          IconButton(Icons.arrow_upward),    // 上移
          IconButton(Icons.arrow_downward),  // 下移
          IconButton(Icons.edit),            // 编辑
          IconButton(Icons.delete),          // 删除
        ],
      ),
      // 内容行
      _buildDetailRow('动作', action.name),
      _buildDetailRow('器械', equipment.name),
      _buildDetailRow('工具', tool.name),
      Row(
        children: [
          Expanded(child: _buildDetailItem('次数', reps)),
          Expanded(child: _buildDetailItem('组数', sets)),
        ],
      ),
      _buildDetailRow('时长', duration),
      _buildDetailRow('强度', intensity),
      _buildDetailRow('备注', notes),
    ],
  ),
)
```

### 操作按钮

```dart
// 上移按钮
IconButton(
  icon: Icon(Icons.arrow_upward),
  onPressed: block.sortOrder > 0 ? _moveUp : null,
)

// 下移按钮
IconButton(
  icon: Icon(Icons.arrow_downward),
  onPressed: block.sortOrder < maxOrder ? _moveDown : null,
)

// 编辑按钮
IconButton(
  icon: Icon(Icons.edit),
  onPressed: () => _editTrainingBlock(block),
)

// 删除按钮
IconButton(
  icon: Icon(Icons.delete),
  onPressed: () => _deleteTrainingBlock(block),
)
```

---

## 使用方法

### 导航到课时详情页

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => SessionDetailPage(
      sessionId: 1,
    ),
  ),
);
```

---

## 数据流程

### 添加训练块

```
用户点击"添加"按钮
    ↓
Navigator.push(TrainingBlockFormPage)
    ↓
用户填写表单并保存
    ↓
trainingBlockNotifier.addTrainingBlock()
    ↓
添加到最后位置
    ↓
返回 true
    ↓
_loadSession() 重新加载
    ↓
显示 SnackBar 提示
```

### 编辑训练块

```
用户点击"编辑"按钮
    ↓
Navigator.push(TrainingBlockFormPage with blockId)
    ↓
加载现有数据
    ↓
用户修改并保存
    ↓
trainingBlockNotifier.updateTrainingBlock()
    ↓
返回 true
    ↓
_loadSession() 重新加载
    ↓
显示 SnackBar 提示
```

### 删除训练块

```
用户点击"删除"按钮
    ↓
显示确认对话框
    ↓
用户确认
    ↓
trainingBlockNotifier.deleteTrainingBlock()
    ↓
自动重新编号后续训练块
    ↓
_loadSession() 重新加载
    ↓
显示 SnackBar 提示
```

### 上移训练块

```
用户点击"上移"按钮
    ↓
trainingBlockNotifier.reorderTrainingBlock(newSortOrder: current - 1)
    ↓
训练块前移
    ↓
_loadSession() 重新加载
```

### 下移训练块

```
用户点击"下移"按钮
    ↓
trainingBlockNotifier.reorderTrainingBlock(newSortOrder: current + 1)
    ↓
训练块后移
    ↓
_loadSession() 重新加载
```

---

## Provider 集成

### 使用的 Provider

```dart
// 训练块操作
trainingBlockNotifierProvider

// 数据库访问
databaseProvider
```

### 读取数据

```dart
// 监听训练块列表状态（不直接使用，通过重新加载获取）
final session = await ref.read(sessionNotifierProvider.notifier).getDetailById(sessionId);

// 读取训练块操作
final notifier = ref.read(trainingBlockNotifierProvider.notifier);
await notifier.addTrainingBlock(...);
await notifier.updateTrainingBlock(...);
await notifier.deleteTrainingBlock(...);
await notifier.reorderTrainingBlock(...);
```

---

## TrainingBlockFormPage

### 功能

- ✅ 添加新训练块
- ✅ 编辑现有训练块
- ✅ 表单验证
- ✅ 下拉选择（动作、器械、工具）
- ✅ 保存中状态

### 表单字段

| 字段 | 类型 | 说明 |
|------|------|------|
| 动作 | 下拉选择 | 从 actions 表选择 |
| 器械 | 下拉选择 | 从 equipments 表选择 |
| 工具 | 下拉选择 | 从 tools 表选择 |
| 次数 | 文本输入 | 可选 |
| 组数 | 文本输入 | 可选 |
| 时长 | 文本输入 | 可选 |
| 强度 | 文本输入 | 可选 |
| 备注 | 多行文本 | 可选 |
| 自定义 | 开关 | 标记为自定义内容 |

---

## 状态处理

### 加载训练块

```dart
Future<void> _loadSession() async {
  final notifier = ref.read(sessionNotifierProvider.notifier);
  final session = await notifier.getDetailById(widget.sessionId);
  if (mounted) {
    setState(() {
      _session = session;
    });
  }
}
```

### 加载基础数据

```dart
Future<void> _loadBasicData() async {
  final db = ref.read(databaseProvider);

  final actions = await db.query('actions', orderBy: 'name ASC');
  final equipments = await db.query('equipments', orderBy: 'name ASC');
  final tools = await db.query('tools', orderBy: 'name ASC');

  if (mounted) {
    setState(() {
      _actions = actions.map((e) => {'id': e['id'], 'name': e['name']}).toList();
      _equipments = equipments.map((e) => {'id': e['id'], 'name': e['name']}).toList();
      _tools = tools.map((e) => {'id': e['id'], 'name': e['name']}.toList();
    });
  }
}
```

---

## 错误处理

### 删除确认

```dart
final confirmed = await showDialog<bool>(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('确认删除'),
    content: Text('确定要删除训练块 X 吗？'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('取消'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text('删除', style: TextStyle(color: Colors.red)),
      ),
    ],
  ),
);

if (confirmed == true) {
  await notifier.deleteTrainingBlock(blockId: block.id);
}
```

---

## 操作按钮状态

### 上移/下移按钮

```dart
// 上移：第一项禁用
IconButton(
  icon: Icon(Icons.arrow_upward),
  onPressed: block.sortOrder > 0 ? _moveUp : null,
)

// 下移：最后一项禁用
IconButton(
  icon: Icon(Icons.arrow_downward),
  onPressed: block.sortOrder < maxOrder ? _moveDown : null,
)
```

---

## 自定义标记

### 显示样式

```dart
if (block.isCustom)
  Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: Colors.purple.withOpacity(0.1),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: Colors.purple, width: 1),
    ),
    child: Text(
      '自定义',
      style: TextStyle(
        color: Colors.purple,
        fontSize: 10,
        fontWeight: FontWeight.w500,
      ),
    ),
  )
```

---

## 注意事项

1. **自动重新加载** - 所有操作后都调用 `_loadSession()` 重新加载
2. **按钮状态** - 上移/下移按钮根据位置自动启用/禁用
3. **下拉选择** - 动作、器械、工具从数据库动态加载
4. **可选字段** - 次数、组数等字段都可选，允许为空
5. **自定义标记** - 可以标记训练块为自定义内容
6. **排序自动调整** - 移动后其他训练块自动调整序号

---

## 后续扩展

可以添加的功能（当前未实现）：

1. **复制训练块** - 一键复制现有训练块
2. **批量操作** - 批量删除、批量编辑
3. **拖拽排序** - 长按拖拽调整顺序
4. **模板选择** - 从预设模板快速添加
5. **历史记录** - 查看训练块修改历史

---

## 测试场景

1. **添加训练块** - 测试添加新训练块
2. **编辑训练块** - 测试修改现有训练块
3. **删除训练块** - 测试删除和确认对话框
4. **上移训练块** - 测试向上移动
5. **下移训练块** - 测试向下移动
6. **边界情况** - 第一项上移、最后一项下移
7. **自定义标记** - 测试自定义标记显示
8. **空列表** - 没有训练块时的显示
9. **表单验证** - 测试表单验证规则
10. **保存中状态** - 测试保存中状态显示

---

## 完整示例

### 在课程规划页使用

```dart
// CoursePlanPage 中
ListTile(
  title: Text('第 X 节课'),
  subtitle: _buildStatusLabel(session.status),
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SessionDetailPage(
          sessionId: session.id,
        ),
      ),
    );
  },
)
```

---

## 数据格式

### 训练块数据

```dart
TrainingBlock {
  id: int,
  sessionId: int,
  actionId: int?,
  equipmentId: int?,
  toolId: int?,
  reps: String?,
  sets: String?,
  duration: String?,
  intensity: String?,
  notes: String?,
  isCustom: bool,
  sortOrder: int,
  action: Action?,
  equipment: Equipment?,
  tool: Tool?,
}
```

---

## 文件依赖

需要导入的 Provider：

```dart
import 'package:student_manager/providers/session_provider.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:student_manager/providers/states.dart';
```

---

## 总结

SessionDetailPage 已更新，包含完整的训练块管理功能：

- ✅ 列表展示
- ✅ 添加
- ✅ 编辑
- ✅ 删除
- ✅ 排序（上移/下移）
- ✅ 自定义标记
- ✅ 所有操作都使用 Repository
- ✅ 操作后自动刷新

代码简洁，只实现要求的功能！
