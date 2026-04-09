# 学员列表页使用文档

---

## 文件说明

`lib/pages/student_list_page.dart` 包含三个页面：

1. **StudentListPage** - 学员列表页
2. **StudentDetailPage** - 学员详情页
3. **StudentFormPage** - 学员表单页（创建/编辑）

---

## 功能特性

### StudentListPage

**核心功能：**
- ✅ 从 Provider 加载学员数据
- ✅ 实时搜索（姓名、联系方式、备注）
- ✅ 下拉刷新
- ✅ 显示学员总数
- ✅ 点击查看详情
- ✅ 创建新学员
- ✅ 编辑学员
- ✅ 删除学员（带确认）

**状态处理：**
- 初始状态 - 显示空状态提示
- 加载中 - 显示 CircularProgressIndicator
- 错误状态 - 显示错误信息和重试按钮
- 空数据 - 显示相应提示

**列表项展示：**
- 学员头像（首字母）
- 姓名（加粗）
- 性别 + 联系方式
- 备注（如有）
- 快捷操作：查看课程规划、编辑、删除

### StudentDetailPage

**核心功能：**
- ✅ 显示学员详细信息
- ✅ 显示课程规划列表
- ✅ 编辑学员
- ✅ 自动加载数据

**信息展示：**
- 基本信息：姓名、性别、联系方式、备注、创建时间
- 课程规划列表：目标、完成率

### StudentFormPage

**核心功能：**
- ✅ 创建新学员
- ✅ 编辑现有学员
- ✅ 表单验证
- ✅ 保存中状态
- ✅ 保存后自动返回并提示

**表单字段：**
- 姓名（必填）
- 性别（可选）
- 联系方式（必填）
- 备注（可选）

---

## 使用方法

### 1. 在 main.dart 中初始化

```dart
import 'package:flutter/material.dart';
import 'package:student_manager/pages/student_list_page.dart';
import 'package:student_manager/providers/student_provider.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化数据库
  final database = await openDatabase(
    'student_manager.db',
    version: 1,
    onCreate: (db, version) async {
      // 执行建表 SQL（参考 schema.sql）
      await db.execute('...');
    },
  );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(database),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '普拉提学员管理系统',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudentListPage(),
    );
  }
}
```

### 2. 导航到学员列表页

```dart
// 作为首页
home: const StudentListPage(),

// 或从其他页面跳转
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const StudentListPage(),
  ),
);
```

### 3. 导航到详情页

```dart
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => StudentDetailPage(
      studentId: 1, // 学员ID
    ),
  ),
);
```

### 4. 导航到表单页

```dart
// 创建新学员
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const StudentFormPage(),
  ),
);

// 编辑现有学员
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => StudentFormPage(
      studentId: 1, // 学员ID
    ),
  ),
);
```

---

## 数据流程

### 列表页加载流程

```
StudentListPage 初始化
    ↓
initState() 调用 notifier.fetchAll()
    ↓
Provider 设置 state = loading
    ↓
数据库查询返回数据
    ↓
Provider 设置 state = data(students, filtered, query)
    ↓
UI 重建显示列表
```

### 搜索流程

```
用户输入搜索关键词
    ↓
TextField onChanged 触发
    ↓
调用 notifier.search(query)
    ↓
Provider 过滤 students 更新 filtered
    ↓
UI 重建显示过滤结果
```

### 创建学员流程

```
用户点击 + 按钮
    ↓
导航到 StudentFormPage
    ↓
填写表单并点击保存
    ↓
调用 notifier.create(...)
    ↓
数据库插入新记录
    ↓
Notifier 调用 fetchAll() 重新加载
    ↓
返回列表页，UI 自动更新
```

---

## UI 组件说明

### 搜索栏

```dart
TextField(
  decoration: InputDecoration(
    hintText: '搜索学员姓名、联系方式或备注',
    prefixIcon: const Icon(Icons.search),
    suffixIcon: _searchController.text.isNotEmpty
        ? IconButton(icon: const Icon(Icons.clear), ...)
        : null,
  ),
  onChanged: (query) {
    ref.read(studentNotifierProvider.notifier).search(query);
  },
)
```

### 列表项

```dart
ListTile(
  leading: CircleAvatar(child: Text(name[0])),
  title: Text(name),
  subtitle: Column(
    children: [
      Text('性别 · 联系方式'),
      Text('备注'),
    ],
  ),
  trailing: Row(
    children: [
      IconButton(icon: Icon(Icons.folder_open)), // 查看课程规划
      PopupMenuButton(...), // 编辑、删除
    ],
  ),
  onTap: () => _navigateToDetail(studentId),
)
```

### 空状态

```dart
Center(
  child: Column(
    children: [
      Icon(Icons.people_outline, size: 64),
      Text('暂无学员数据'),
      Text('点击右下角 + 按钮添加学员'),
    ],
  ),
)
```

---

## Provider 集成

### 使用的 Provider

```dart
// 状态管理
studentNotifierProvider

// 计算属性
studentCountProvider          // 学员总数
filteredStudentsProvider      // 过滤后的学员列表

// 其他页面使用
coursePlanNotifierProvider    // 课程规划状态
```

### 数据绑定

```dart
// 监听状态
final studentState = ref.watch(studentNotifierProvider);

// 读取方法
final notifier = ref.read(studentNotifierProvider.notifier);

// 监听计算属性
final count = ref.watch(studentCountProvider);
```

---

## 错误处理

### 加载失败

```dart
error: (error, stackTrace) => Center(
  child: Column(
    children: [
      Icon(Icons.error_outline),
      Text('加载失败'),
      Text(error.toString()),
      ElevatedButton(
        onPressed: () => ref.read(studentNotifierProvider.notifier).fetchAll(),
        child: Text('重试'),
      ),
    ],
  ),
)
```

### 删除确认

```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('确认删除'),
    content: Text('确定要删除学员「${student.name}」吗？'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('取消'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text('删除'),
      ),
    ],
  ),
);
```

---

## 性能优化

### 1. 防抖搜索

可以在 TextField 的 `onChanged` 中添加防抖：

```dart
Timer? _debounce;

onChanged: (query) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 300), () {
    ref.read(studentNotifierProvider.notifier).search(query);
  });
}

@override
void dispose() {
  _debounce?.cancel();
  super.dispose();
}
```

### 2. 列表优化

使用 `ListView.separated` 而不是 `ListView.builder` + `Divider`，更高效。

### 3. 下拉刷新

使用 `RefreshIndicator` 包裹 ListView：

```dart
RefreshIndicator(
  onRefresh: () => ref.read(studentNotifierProvider.notifier).fetchAll(),
  child: ListView.separated(...),
)
```

---

## 自定义

### 修改列表项样式

编辑 `_buildStudentTile` 方法：

```dart
Widget _buildStudentTile(Student student) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(student.name),
          Text(student.contact),
        ],
      ),
    ),
  );
}
```

### 添加更多操作

在 `PopupMenuButton` 中添加更多选项：

```dart
PopupMenuButton<String>(
  onSelected: (value) {
    switch (value) {
      case 'edit':
        // 编辑
        break;
      case 'delete':
        // 删除
        break;
      case 'export':
        // 导出数据
        break;
    }
  },
  itemBuilder: (context) => [
    PopupMenuItem(value: 'edit', child: Text('编辑')),
    PopupMenuItem(value: 'delete', child: Text('删除')),
    PopupMenuItem(value: 'export', child: Text('导出')),
  ],
)
```

---

## 注意事项

1. **数据库初始化** - 必须在使用前初始化数据库并覆盖 `databaseProvider`
2. **Provider 作用域** - 确保在 `ProviderScope` 内使用页面
3. **异步操作** - 所有数据库操作都是异步的，需要正确处理 Future
4. **状态更新** - 不要直接修改 State，通过 Notifier 方法更新
5. **内存泄漏** - 在 dispose 中清理 Controller 和 FocusNode

---

## 测试

### 运行页面

```bash
# 确保依赖已安装
flutter pub get

# 运行应用
flutter run
```

### 测试场景

1. **空状态** - 首次打开应用，没有学员数据
2. **创建学员** - 点击 + 按钮，填写表单并保存
3. **搜索** - 输入关键词搜索学员
4. **查看详情** - 点击列表项进入详情页
5. **编辑学员** - 在详情页点击编辑按钮
6. **删除学员** - 删除学员并确认
7. **下拉刷新** - 下拉列表刷新数据
8. **错误处理** - 模拟数据库错误，查看错误提示

---

## 后续扩展

可以添加的功能：

- 批量操作（批量删除、批量导出）
- 学员分组/标签
- 高级筛选（按性别、创建时间等）
- 数据导出（导出为 Excel/CSV）
- 学员统计图表
- 照片上传
- 课程日历视图
