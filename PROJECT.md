# 学员课程管理系统 - 项目现状

## 技术栈

- **Flutter** (Dart SDK ^3.11.1) + Material 3
- **Riverpod** (flutter_riverpod + riverpod_annotation + riverpod_generator) 状态管理
- **Freezed** 不可变数据模型 + 代码生成
- **sqflite** 本地 SQLite 数据库
- 代码生成依赖 `build_runner`
- **模板系统** — assets JSON 文件存储模板定义

## 项目结构

```
assets/
└── templates/                       # 教学模板 JSON 文件
    ├── templates.json               # 模板索引（列出所有可用模板）
    ├── pilates.json                 # 普拉提教练
    ├── vocal.json                   # 声乐老师
    ├── piano.json                   # 钢琴老师
    ├── yoga.json                    # 瑜伽教练
    ├── dance.json                   # 舞蹈老师
    ├── swimming.json                # 游泳教练
    ├── math.json                    # 数学辅导
    ├── english.json                 # 英语辅导
    ├── art.json                     # 美术老师
    ├── chess.json                   # 国际象棋教练
    ├── taekwondo.json               # 跆拳道教练
    └── custom.json                  # 自定义
lib/
├── main.dart                          # 入口：DB初始化 + 模板选择路由
├── utils/
│   └── template_loader.dart          # 模板加载工具（读JSON + 写入DB + 默认课程类型）
├── database/                          # 数据访问层（Repository 模式）
│   ├── content_field_repository.dart # 内容字段 + 字段选项 CRUD
│   ├── content_block_repository.dart # 内容块 CRUD（EAV模式）
│   ├── course_plan_repository.dart   # 课程规划 + 课程目标默认配置
│   ├── session_repository.dart       # 课时 CRUD（纯教学内容，无排期）
│   ├── course_type_repository.dart   # 课程类型 CRUD
│   ├── scheduled_class_repository.dart # 排课 CRUD + 日期/学员/状态查询 + 统计
│   ├── payment_repository.dart       # 学员付费 CRUD + 统计查询
│   └── album_repository.dart         # 相册 CRUD + 文件管理
├── providers/                         # Riverpod 状态管理
│   ├── states.dart                    # 所有 Freezed 数据模型 + 枚举
│   ├── student_provider.dart          # 学员 Provider + DB Provider
│   ├── course_plan_provider.dart      # 课程规划 Provider
│   ├── session_provider.dart          # 课时 Provider（无排期方法）
│   ├── course_type_provider.dart      # 课程类型 Provider
│   ├── scheduled_class_provider.dart  # 排课 Provider + 日期/视图状态
│   ├── payment_provider.dart          # 付费记录 Provider
│   ├── statistics_provider.dart       # 统计数据 Provider
│   ├── content_field_provider.dart    # 内容字段/内容块/字段选项/课程目标 Provider
│   ├── goal_config_provider.dart      # 课程目标默认配置 Provider
│   └── album_provider.dart            # 相册 Provider
├── pages/                             # 页面
│   ├── main_shell_page.dart           # 底部导航 4 Tab 容器
│   ├── template_selection_page.dart   # 模板选择页（首次启动）
│   ├── schedule_page.dart             # 课表 Tab（日/周/月视图切换）
│   ├── scheduled_class_detail_page.dart # 排课详情 + 消课/出勤管理
│   ├── create_scheduled_class_dialog.dart # 快速排课底部面板
│   ├── student_list_page.dart         # 学员列表（搜索+新建）
│   ├── student_detail_page.dart       # 学员详情（课程规划+上课记录+付费记录+相册）
│   ├── student_payment_page.dart      # 新增付费记录
│   ├── course_plan_page.dart          # 课程规划（目标/蓝图/课时列表/进度/排课）
│   ├── session_detail_page.dart       # 课时详情（动态内容块编辑器+状态管理）
│   ├── statistics_page.dart           # 统计 Tab
│   ├── profile_page.dart              # 我的 Tab（课程类型/字段/目标/配置/模板切换）
│   ├── course_type_list_page.dart     # 课程类型管理列表
│   ├── course_type_form_page.dart     # 课程类型编辑表单
│   ├── content_field_list_page.dart   # 内容字段管理列表
│   ├── content_field_form_page.dart   # 内容字段编辑表单
│   ├── field_option_list_page.dart    # 字段选项管理列表
│   ├── goal_list_page.dart            # 课程目标管理
│   ├── goal_config_list_page.dart     # 课程目标配置列表
│   ├── goal_config_detail_page.dart   # 课程目标配置详情
│   ├── goal_config_session_detail_page.dart  # 配置课时模板详情
│   ├── create_course_plan_dialog.dart # 新建课程规划弹窗
│   ├── edit_course_plan_dialog.dart   # 编辑课程目标/蓝图弹窗
│   ├── create_album_dialog.dart       # 新建相册弹窗
│   └── album_detail_page.dart         # 相册详情（照片网格+拍照/选取）
└── widgets/                           # 复用组件
    ├── content_block_editor.dart      # 动态内容块编辑器（根据字段定义生成表单）
    ├── content_block_tile.dart        # 动态内容块展示卡片（根据字段类型渲染）
    ├── session_action_dialogs.dart    # 课时操作弹窗（消课/跳过等）
    ├── schedule_day_view.dart         # 课表日视图（0-24h 时间轴）
    ├── schedule_week_view.dart        # 课表周视图（7列网格）
    ├── schedule_month_view.dart       # 课表月视图（日历网格）
    ├── class_participant_list.dart    # 参与人列表 + 出勤管理
    └── payment_list_tile.dart         # 付费记录列表项
```

## 数据库表 (SQLite, version 1)

| 表名 | 说明 |
|------|------|
| `app_settings` | 应用设置（key-value，存储已选模板等） |
| `content_fields` | 内容字段定义 (field_type: select/number/text/multiline; is_required; sort_order; is_deprecated 软删除) |
| `field_options` | 字段选项 (FK → content_fields, CASCADE; value UNIQUE per field; is_deprecated 软删除) |
| `students` | 学员信息 |
| `course_goals` | 课程目标 (name UNIQUE, is_deprecated 软删除) |
| `course_plans` | 课程规划 (FK → students, CASCADE; FK → course_goals) |
| `sessions` | 课时 (FK → course_plans, CASCADE; status: pending/completed/skipped; 纯教学内容，无排期字段) |
| `content_blocks` | 内容块 (FK → sessions, CASCADE; sort_order) |
| `content_block_values` | 内容块字段值 (FK → content_blocks, CASCADE; FK → content_fields, CASCADE; EAV 模式) |
| `goal_configs` | 课程目标默认配置 (FK → course_goals; 默认蓝图) |
| `goal_config_sessions` | 默认配置中的课时模板 (FK → goal_configs, CASCADE) |
| `goal_config_content_blocks` | 默认配置中的内容块模板 (FK → goal_config_sessions, CASCADE) |
| `goal_config_content_block_values` | 默认配置内容块值 (FK → goal_config_content_blocks, CASCADE; FK → content_fields, CASCADE; EAV) |
| `course_types` | 课程类型 (name UNIQUE; icon/color/duration/is_group/max_students/pricing/commission; is_deprecated 软删除) |
| `scheduled_classes` | 排课记录 (FK → course_types; FK → sessions ON DELETE SET NULL; status: scheduled/completed/cancelled/no_show) |
| `class_participants` | 参与人 (FK → scheduled_classes, CASCADE; FK → students, CASCADE; student_id 或 guest_name 至少填一) |
| `student_payments` | 学员付费记录 (FK → students, CASCADE; FK → course_types; FK → course_plans; commission_type/value/earned) |
| `albums` | 相册 (FK → students, CASCADE) |
| `album_photos` | 相册照片 (FK → albums, CASCADE; file_path 存储在 App 沙盒) |

## 核心数据模型 (states.dart)

- **FieldType** 枚举 — select / number / text / multiline
- **ContentField** — 内容字段定义，含关联的 FieldOption 列表
- **FieldOption** — 字段选项（select 类型字段使用）
- **ContentBlock** — 内容块，含 Map<int, String> values（EAV 键值对）
- **GoalConfigContentBlock** — 默认配置内容块，含 Map<int, String> values
- **Student** — 学员，含 fromMap/toMap
- **CoursePlan** — 课程规划（不含 defaultDuration）
- **Session** — 课时（不含 scheduledTime/durationOverride）
- **CourseType** — 课程类型，含 fromMap/toMap
- **ScheduledClass** — 排课记录，含 courseTypeName/courseTypeColor（关联查询字段）
- **ClassParticipant** — 参与人，含 isGuest 辅助属性
- **StudentPayment** — 学员付费记录
- **GoalConfig** / **GoalConfigSession** — 课程目标配置及课时模板
- **Album** / **AlbumPhoto** — 相册模型，Album 含 photoCount 计算字段
- **SessionStatus** 枚举 — pending/completed/skipped
- **ScheduledClassStatus** 枚举 — scheduled/completed/cancelled/noShow
- **AttendanceStatus** 枚举 — pending/present/absent/late
- **CommissionType** 枚举 — none/fixed/percent
- **ScheduleViewMode** 枚举 — day/week/month
- 统计相关：StatisticsData / CourseTypeDistribution / StudentRanking / IncomeTrend
- 状态类：StudentState / CoursePlanState / SessionState / CourseTypeState / ScheduledClassState / PaymentState / GoalConfigState / AlbumState（initial/loading/data/error）
- 辅助类：FieldOptionItem / FieldOptionState / GoalItem / GoalItemState（字段选项和课程目标管理使用）

## 架构设计

### EAV 模式
内容块使用 Entity-Attribute-Value 模式存储，替代原有的硬编码字段：
- `content_blocks` 表存储内容块实体（关联 session_id）
- `content_block_values` 表存储每个内容块的动态键值对（content_field_id → value）
- 表单根据 `content_fields` 定义动态生成输入控件
- 展示卡片根据字段类型动态渲染

### 模板系统
- 模板定义为 JSON 文件，存储于 `assets/templates/`
- `TemplateLoader` 负责读取模板并初始化数据库
- 首次启动显示 `TemplateSelectionPage`
- 已选模板记录在 `app_settings` 表中
- 切换模板会清空 `content_fields`、`field_options`、`course_goals` 数据
- 模板初始化时同时创建3个默认课程类型（一对一私教、团课、体验课）

### Provider 约定
- 所有 Notifier 类和 Repository/Database provider 使用 `@Riverpod(keepAlive: true)` 防止 AutoDispose 回收
- 纯计算属性（如 `activeCourseTypes`、`studentCount`）保持默认 AutoDispose
- 不要在 widget lifecycle 方法中直接修改 provider 状态，用 `addPostFrameCallback` 延迟

### 数据流
Widget → Provider → Repository → SQLite

### 代码生成
- 修改 Freezed/Riverpod 注解后需执行 `dart run build_runner build`
- 生成的 `.g.dart` 和 `.freezed.dart` 文件已纳入版本控制

## 已实现功能

- [x] 模板选择系统（首次启动 + 切换模板 + 默认课程类型创建）
- [x] 4-tab 底部导航（课表 / 学员 / 统计 / 我的）
- [x] 学员 CRUD + 搜索
- [x] 课程规划创建（有默认配置的目标自动填充12节课模板）
- [x] 课程规划编辑（修改目标、蓝图）
- [x] 课时管理（新增/删除/排序）
- [x] 动态内容块编辑（根据内容字段定义生成表单）
- [x] 动态内容块展示（根据字段类型渲染卡片）
- [x] 课程类型管理（新增/编辑/弃用，含默认价格、课时费、提成规则）
- [x] 排课管理（创建排课、消课、取消、标记未到）
- [x] 课表视图（日视图0-24h时间轴 / 周视图 / 月视图，点击空白新建排课）
- [x] 参与人管理（正式学员 + 临时人员，出勤状态切换）
- [x] 课时排课关联（课程规划页排课按钮，排课可关联课时，消课自动标记课时完成）
- [x] 学员付费记录（新增/查看/统计）
- [x] 学员详情增强（上课记录时间线 + 付费记录）
- [x] 数据统计（时间范围筛选、课时/收入/出勤概览、课程类型分布、学员消费排行）
- [x] 进度统计（已完成/剩余课时）
- [x] 课程目标管理（CRUD + 软删除/恢复）
- [x] 内容字段管理（CRUD + 排序 + 软删除）
- [x] 字段选项管理（select 类型字段的选项 CRUD）
- [x] 课程目标默认配置管理 UI
- [x] 学员相册（创建/删除相册、拍照/选取照片、查看/删除照片）

## 未实现功能

- [ ] 教学内容复用（复制课时）
- [ ] 数据备份与恢复（导入/导出 JSON）
- [ ] 自定义模板导入/导出
- [ ] 数据导出（PDF / Excel）
