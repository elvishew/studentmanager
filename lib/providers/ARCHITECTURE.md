# Riverpod 状态管理架构文档

---

## 一、架构概览

### 1.1 技术栈
- **Riverpod 2.x** - 状态管理框架
- **freezed** - 不可变数据类生成
- **sqflite** - SQLite 数据库

### 1.2 核心设计模式
- **Provider 模式** - 依赖注入和状态管理
- **Repository 模式** - 数据访问层抽象
- **不可变状态** - 使用 Freezed 生成不可变数据类
- **单向数据流** - State → UI → Event → State

---

## 二、Provider 架构

### 2.1 Provider 层次结构

```
databaseProvider (全局单例)
    ↓
┌─────────────────┬───────────────────┬────────────────────┐
│                 │                   │                    │
studentProvider  coursePlanProvider  sessionProvider   [其他 providers]
    ↓               ↓                   ↓
StudentNotifier  CoursePlanNotifier  SessionNotifier
    ↓               ↓                   ↓
StudentState    CoursePlanState      SessionState
```

### 2.2 Provider 类型

| Provider | 类型 | 用途 |
|----------|------|------|
| `databaseProvider` | Provider | 提供 Database 实例 |
| `studentNotifierProvider` | NotifierProvider | 学员状态管理 |
| `coursePlanNotifierProvider` | NotifierProvider | 课程规划状态管理 |
| `sessionNotifierProvider` | NotifierProvider | 课时状态管理 |
| `studentCountProvider` | Provider | 计算属性：学员总数 |
| `selectedCoursePlanProvider` | Provider | 计算属性：选中的课程规划 |
| `sessionStatisticsProvider` | Provider | 计算属性：课时统计 |

---

## 三、State 结构设计

### 3.1 通用状态模式

所有 State 都遵循相同的模式：

```dart
@freezed
class XxxState with _$XxxState {
  const factory XxxState.initial() = _XxxInitial;
  const factory XxxState.loading() = _XxxLoading;
  const factory XxxState.data({ ... }) = _XxxData;
  const factory XxxState.error(Object error, StackTrace stackTrace) = _XxxError;
}
```

### 3.2 StudentState

```dart
StudentState
  ├── initial() - 初始状态
  ├── loading() - 加载中
  ├── data({
  │     students: List<Student>,           // 所有学员
  │     filteredStudents: List<Student>,   // 搜索过滤后的结果
  │     searchQuery: String,               // 当前搜索关键词
  │   })
  └── error(error, stackTrace) - 错误状态
```

### 3.3 CoursePlanState

```dart
CoursePlanState
  ├── initial() - 初始状态
  ├── loading() - 加载中
  ├── data({
  │     coursePlans: List<CoursePlan>,     // 所有课程规划
  │     selectedCoursePlan: CoursePlan?,   // 当前选中的课程规划
  │     selectedStudentId: int?,           // 当前筛选的学员ID
  │   })
  └── error(error, stackTrace) - 错误状态
```

### 3.4 SessionState

```dart
SessionState
  ├── initial() - 初始状态
  ├── loading() - 加载中
  ├── data({
  │     sessions: List<Session>,           // 所有课时
  │     selectedSession: Session?,         // 当前选中的课时
  │     coursePlanId: int?,                // 所属的课程规划ID
  │   })
  └── error(error, stackTrace) - 错误状态
```

---

## 四、数据模型设计

### 4.1 数据模型特性

所有数据模型都使用 Freezed 生成，具有以下特性：

- **不可变性** - 所有字段都是 final
- **copyWith** - 方便创建修改后的副本
- **fromMap/toMap** - 与数据库 Map 互转
- **关联数据** - 可选的关联对象（如 CoursePlan 包含 Student）

### 4.2 核心数据模型

| 模型 | 说明 | 关联 |
|------|------|------|
| `Student` | 学员 | - |
| `CoursePlan` | 课程规划 | Student, Sessions |
| `Session` | 课时 | TrainingBlocks |
| `TrainingBlock` | 训练块 | Action, Equipment, Tool |
| `Action` | 动作 | - |
| `Equipment` | 器械 | - |
| `Tool` | 工具 | - |

### 4.3 枚举类型

```dart
SessionStatus
  ├── pending('未开始')
  ├── completed('已完成')
  └── skipped('已跳过')

CourseGoal
  ├── postpartum('产后修复')
  ├── neckShoulder('肩颈理疗')
  ├── backShoulder('肩背打造')
  ├── backPain('腰酸治疗')
  ├── waistAbs('腰腹塑形')
  ├── fullBody('全身塑形')
  ├── gluteLeg('臀腿打造')
  ├── kneePain('膝盖疼痛')
  └── custom('自定义')
```

---

## 五、Notifier 设计

### 5.1 Notifier 职责

每个 Notifier 负责：
1. **状态管理** - 管理对应的 State
2. **业务逻辑** - 封装业务操作
3. **数据访问** - 调用 Repository 进行数据库操作
4. **状态更新** - 更新 State 并触发 UI 刷新

### 5.2 StudentNotifier

```dart
class StudentNotifier {
  // 查询操作
  fetchAll()                          // 查询所有学员
  getById(id)                         // 根据 ID 查询
  search(query)                       // 搜索学员

  // 写入操作
  create(...)                         // 创建学员
  update(...)                         // 更新学员
  delete(id)                          // 删除学员

  // 状态操作
  reset()                             // 重置状态
}
```

### 5.3 CoursePlanNotifier

```dart
class CoursePlanNotifier {
  // 查询操作
  fetchAll()                          // 查询所有课程规划
  fetchByStudentId(id)                // 查询指定学员的课程规划
  getDetailById(id)                   // 获取详情（含课时）

  // 写入操作
  create(...)                         // 创建课程规划（调用 Repository）
  update(...)                         // 更新课程规划
  delete(id)                          // 删除课程规划

  // 选择操作
  selectCoursePlan(id?)               // 选择/取消选择课程规划

  // 状态操作
  reset()                             // 重置状态
}
```

### 5.4 SessionNotifier

```dart
class SessionNotifier {
  // 查询操作
  fetchByCoursePlanId(id)             // 查询课程规划的课时
  getDetailById(id)                   // 获取详情（含训练块）

  // 写入操作
  addSession(...)                     // 添加课时
  addSessionsBatch(...)               // 批量添加课时
  insertSessionAt(...)                // 指定位置插入
  updateSession(...)                  // 更新课时
  moveSession(...)                    // 移动课时位置
  deleteSession(...)                  // 删除课时

  // 选择操作
  selectSession(id?)                  // 选择/取消选择课时

  // 状态操作
  reset()                             // 重置状态
}
```

---

## 六、计算属性 Provider

### 6.1 作用

计算属性 Provider 用于：
- **派生数据** - 从现有 State 计算得出
- **自动缓存** - 只在依赖变化时重新计算
- **简化 UI** - UI 直接使用计算结果

### 6.2 计算属性列表

| Provider | 依赖 | 返回值 |
|----------|------|--------|
| `studentCountProvider` | StudentState | int - 学员总数 |
| `filteredStudentsProvider` | StudentState | List\<Student\> - 过滤后的学员 |
| `selectedCoursePlanProvider` | CoursePlanState | CoursePlan? - 选中的课程规划 |
| `coursePlanCountProvider` | CoursePlanState | int - 课程规划总数 |
| `selectedSessionProvider` | SessionState | Session? - 选中的课时 |
| `sessionCountProvider` | SessionState | int - 课时总数 |
| `completedSessionCountProvider` | SessionState | int - 已完成课时数 |
| `sessionCompletionRateProvider` | 计算属性 | double - 完成率 |
| `sessionStatisticsProvider` | SessionState | SessionStatistics - 完整统计 |

---

## 七、数据流设计

### 7.1 查询流程

```
UI 调用 notifier.fetchAll()
    ↓
Notifier 设置 state = loading
    ↓
Notifier 调用 database.query()
    ↓
数据库返回 Map 列表
    ↓
转换为模型对象
    ↓
Notifier 设置 state = data
    ↓
UI 自动重建
```

### 7.2 写入流程

```
UI 调用 notifier.create(...)
    ↓
Notifier 调用 database.insert()
    ↓
数据库返回新记录 ID
    ↓
Notifier 调用 fetchAll() 重新加载数据
    ↓
UI 自动重建
```

### 7.3 乐观更新流程

```
UI 调用 notifier.delete(id)
    ↓
Notifier 立即更新 state（移除数据）
    ↓
UI 立即刷新（无需等待数据库）
    ↓
Notifier 调用 database.delete()（后台）
    ↓
如果失败，恢复原状态并显示错误
```

---

## 八、错误处理

### 8.1 错误状态

所有 Provider 都有统一的错误状态：

```dart
const XxxState.error(Object error, StackTrace stackTrace)
```

### 8.2 错误处理方式

1. **State 中捕获** - catch 异常并设置 error state
2. **UI 中处理** - 使用 `when()` 方法处理 error 状态
3. **监听错误** - 使用 `ref.listen()` 监听并显示提示

### 8.3 错误处理示例

```dart
// Notifier 中
try {
  final data = await database.query(...);
  state = XxxState.data(data);
} catch (e, stackTrace) {
  state = XxxState.error(e, stackTrace);
}

// UI 中
state.when(
  error: (e, stackTrace) {
    return ErrorWidget(e.toString());
  },
  // ...
);
```

---

## 九、性能优化

### 9.1 自动缓存

计算属性 Provider 自动缓存结果：

```dart
@riverpod
int studentCount(StudentCountRef ref) {
  final studentState = ref.watch(studentNotifierProvider);
  return studentState.maybeWhen(
    data: (students) => students.students.length,
    orElse: () => 0,
  );
}
```

- 只有 `studentNotifierProvider` 变化时才重新计算
- 多个 Widget 读取同一个计算属性时，只计算一次

### 9.2 选择性监听

UI 可以只监听需要的数据：

```dart
// 只监听学员总数（不影响其他 UI）
final count = ref.watch(studentCountProvider);

// 只监听过滤后的列表
final filtered = ref.watch(filteredStudentsProvider);
```

### 9.3 避免不必要的重建

使用 `select()` 只监听特定字段：

```dart
final selectedCoursePlan = ref.watch(
  coursePlanNotifierProvider.select((state) => state.maybeWhen(
    data: (_, selected, __) => selected,
    orElse: () => null,
  )),
);
```

---

## 十、最佳实践

### 10.1 Provider 命名规范

- **Notifier Provider**: `{name}NotifierProvider`
- **计算属性 Provider**: `{name}Provider`（小写开头）
- **State**: `{name}State`
- **Model**: `{Name}`（大写开头）

### 10.2 状态更新原则

1. **单一数据源** - 只在 Notifier 中修改状态
2. **不可变性** - 使用 `copyWith` 创建新状态
3. **原子操作** - 一个方法只做一件事
4. **错误处理** - 捕获所有异常并更新状态

### 10.3 UI 分离原则

- Provider 不包含任何 UI 代码
- UI 通过 `ref.watch()` 监听状态
- UI 通过 `ref.read()` 调用方法

### 10.4 依赖注入

```dart
// 在 main.dart 中覆盖依赖
final container = ProviderContainer(
  overrides: [
    databaseProvider.overrideWithValue(database),
  ],
);
```

---

## 十一、测试策略

### 11.1 单元测试

```dart
test('create student should add to state', () async {
  // 创建测试容器
  final container = ProviderContainer();

  // 调用方法
  final notifier = container.read(studentNotifierProvider.notifier);
  await notifier.create(name: 'Test', contact: '123');

  // 验证状态
  final state = container.read(studentNotifierProvider);
  expect(state, isA<_StudentData>());
});
```

### 11.2 Mock Repository

```dart
// 提供 Mock Repository
final container = ProviderContainer(
  overrides: [
    studentRepositoryProvider.overrideWithValue(mockRepository),
  ],
);
```

---

## 十二、文件结构

```
lib/providers/
├── states.dart                      # State 和数据模型定义
├── student_provider.dart            # 学员 Provider
├── course_plan_provider.dart        # 课程规划 Provider
├── session_provider.dart            # 课时 Provider
├── provider_example.dart            # 使用示例
└── ARCHITECTURE.md                  # 本文档
```

---

## 十三、后续扩展

### 13.1 可添加的 Provider

- `trainingBlockNotifierProvider` - 训练块管理
- `actionNotifierProvider` - 动作管理
- `equipmentNotifierProvider` - 器械管理
- `toolNotifierProvider` - 工具管理
- `goalConfigNotifierProvider` - 默认配置管理

### 13.2 可添加的功能

- **状态持久化** - 将 State 保存到本地
- **乐观更新** - 提前更新 UI，失败时回滚
- **批量操作** - 支持批量删除、批量更新
- **缓存策略** - 实现更复杂的缓存逻辑
- **错误重试** - 自动重试失败的操作

---

## 十四、常见问题

### Q1: 何时使用 `ref.watch()` vs `ref.read()`?

- **`ref.watch()`** - 在 `build()` 方法中，需要监听变化
- **`ref.read()`** - 在回调函数中，不需要监听变化

### Q2: 如何处理异步操作?

在 Notifier 方法中使用 `async/await`，并在 `try-catch` 中处理错误。

### Q3: 如何避免不必要的重建?

- 使用计算属性 Provider
- 使用 `select()` 只监听特定字段
- 将状态拆分为更小的单元

### Q4: 如何在 Provider 之间共享数据?

通过 `ref.read()` 或 `ref.watch()` 读取其他 Provider 的状态。

---

## 十五、参考资料

- [Riverpod 官方文档](https://riverpod.dev/)
- [Freezed 文档](https://pub.dev/packages/freezed)
- [Flutter 状态管理最佳实践](https://docs.flutter.dev/data-and-backend/state-mgmt/options)
