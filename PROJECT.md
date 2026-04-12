# 普拉提学员课程管理系统 - 项目现状

## 技术栈

- **Flutter** (Dart SDK ^3.11.1) + Material 3
- **Riverpod** (flutter_riverpod + riverpod_annotation + riverpod_generator) 状态管理
- **Freezed** 不可变数据模型 + 代码生成
- **sqflite** 本地 SQLite 数据库
- 代码生成依赖 `build_runner`

## 项目结构

```
lib/
├── main.dart                          # 入口：DB初始化 + ProviderScope
├── database/                          # 数据访问层（Repository 模式）
│   ├── course_plan_repository.dart    # 课程规划 + 课程目标默认配置
│   ├── session_repository.dart        # 课时 CRUD
│   ├── training_block_repository.dart # 训练块 CRUD
│   ├── album_repository.dart          # 相册 CRUD + 文件管理
│   └── item_repository.dart           # 动作/器械/工具 CRUD（统一泛型）
├── providers/                         # Riverpod 状态管理
│   ├── states.dart                    # 所有 Freezed 数据模型 + 枚举
│   ├── student_provider.dart          # 学员 Provider + DB Provider
│   ├── course_plan_provider.dart      # 课程规划 Provider
│   ├── session_provider.dart          # 课时 Provider
│   ├── album_provider.dart            # 相册 Provider
│   └── item_provider.dart             # 动作/器械/工具 Provider
├── pages/                             # 页面
│   ├── student_list_page.dart         # 学员列表（搜索+新建）
│   ├── student_detail_page.dart       # 学员详情（基本信息+课程规划列表）
│   ├── course_plan_page.dart          # 课程规划（目标/蓝图/课时列表/进度）
│   ├── session_detail_page.dart       # 课时详情（训练块编辑器+状态管理）
│   ├── create_course_plan_dialog.dart # 新建课程规划弹窗
│   ├── edit_course_plan_dialog.dart   # 编辑课程目标/蓝图弹窗
│   ├── create_album_dialog.dart       # 新建相册弹窗
│   ├── album_detail_page.dart         # 相册详情（照片网格+拍照/选取）
│   ├── settings_page.dart             # 设置入口
│   ├── item_list_page.dart            # 动作/器械/工具列表管理
│   └── item_form_page.dart            # 新增/编辑动作/器械/工具表单
└── widgets/                           # 复用组件
    ├── session_edit_dialog.dart       # 课时编辑弹窗
    └── session_action_dialogs.dart    # 课时操作弹窗（消课/跳过等）
```

## 数据库表 (SQLite, version 6)

| 表名 | 说明 |
|------|------|
| `students` | 学员信息 |
| `course_plans` | 课程规划 (FK → students, CASCADE; default_duration 默认课时时长) |
| `sessions` | 课时 (FK → course_plans, CASCADE; status: pending/completed/skipped; duration_override 可选时长覆盖) |
| `training_blocks` | 训练块 (FK → sessions, CASCADE; FK → actions/equipments/tools, SET NULL) |
| `actions` | 动作 (is_deprecated 软删除) |
| `equipments` | 器械 (is_deprecated 软删除) |
| `tools` | 工具 (is_deprecated 软删除) |
| `goal_configs` | 课程目标默认配置 (默认蓝图) |
| `goal_config_sessions` | 默认配置中的课时模板 |
| `goal_config_training_blocks` | 默认配置中的训练块模板 |
| `albums` | 相册 (FK → students, CASCADE) |
| `album_photos` | 相册照片 (FK → albums, CASCADE; file_path 存储在 App 沙盒) |

## 核心数据模型 (states.dart)

- **Student** / **CoursePlan** / **Session** / **TrainingBlock** - Freezed 模型，含 fromMap/toMap
- **Action** / **Equipment** / **Tool** - 基础数据，isDeprecated 软删除
- **Album** / **AlbumPhoto** - 相册模型，Album 含 photoCount 计算字段
- **CourseGoal** 枚举 - 9种课程目标（含"自定义"）
- **SessionStatus** 枚举 - pending/completed/skipped
- 状态类：StudentState / CoursePlanState / SessionState / AlbumState（initial/loading/data/error）

## 已实现功能

- [x] 学员 CRUD + 搜索
- [x] 课程规划创建（非自定义目标自动填充12节课模板）
- [x] 课程规划编辑（修改目标、蓝图）
- [x] 课时管理（新增/删除/排序）
- [x] 训练块编辑（动作/器械/工具/次数/组数/时长/强度/备注/自定义标记）
- [x] 排课与消课（设置时间、标记完成/跳过）
- [x] 进度统计（已完成/剩余课时）
- [x] 课时时长管理（课程规划默认时长 + 课时可选覆盖）
- [x] 动作/器械/工具管理（CRUD + 软删除/恢复）
- [x] 课程目标默认配置数据层（goal_configs 表 + Repository）
- [x] 学员相册（创建/删除相册、拍照/选取照片、查看/删除照片）

## 未实现功能

- [ ] 课程目标默认配置管理 UI（PRD 4.5节）
- [ ] 日历视图 / 数据统计 / 内容复用 / 数据导出（PRD 第七章非MVP）

## 架构约定

- **数据流**：Widget → Provider → Repository → SQLite
- **模型转换**：Freezed 模型通过 fromMap/toMap 与 DB 互转
- **软删除**：动作/器械/工具删除仅标记 is_deprecated，保留历史数据引用完整性
- **DB 注入**：databaseProvider 在 main.dart 通过 overrideWithValue 注入
- **代码生成**：修改 Freezed/Riverpod 注解后需执行 `dart run build_runner build`
