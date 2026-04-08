# 普拉提学员课程管理系统 - 数据库设计文档

---

## 一、数据库概述

- **数据库类型**: SQLite
- **命名规范**: snake_case
- **时间格式**: ISO8601 字符串 (TEXT)
- **布尔值**: INTEGER (0/1)
- **外键约束**: 启用 (PRAGMA foreign_keys = ON)

---

## 二、表结构设计

### 2.1 核心业务表

#### students（学员表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| name | TEXT | NOT NULL | 姓名 |
| gender | TEXT | | 性别（可选） |
| contact | TEXT | NOT NULL | 联系方式 |
| notes | TEXT | | 备注 |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

---

#### course_plans（课程规划表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| student_id | INTEGER | NOT NULL, FK | 学员ID |
| goal | TEXT | NOT NULL | 课程目标（枚举） |
| blueprint | TEXT | | 蓝图描述 |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**外键**: `student_id` → `students.id` (ON DELETE CASCADE)

---

#### sessions（课时表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| course_plan_id | INTEGER | NOT NULL, FK | 课程规划ID |
| session_number | INTEGER | NOT NULL | 课时序号（从1开始） |
| scheduled_time | TEXT | | 上课时间（ISO8601） |
| status | TEXT | NOT NULL DEFAULT 'pending' | 状态: pending/completed/skipped |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**外键**: `course_plan_id` → `course_plans.id` (ON DELETE CASCADE)

**唯一约束**: `UNIQUE(course_plan_id, session_number)`

---

#### training_blocks（训练块表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| session_id | INTEGER | NOT NULL, FK | 课时ID |
| action_id | INTEGER | FK | 动作ID |
| equipment_id | INTEGER | FK | 器械ID |
| tool_id | INTEGER | FK | 工具ID |
| reps | TEXT | | 次数（如 "12-15"） |
| sets | TEXT | | 组数（如 "3"） |
| duration | TEXT | | 时长（如 "30秒"） |
| intensity | TEXT | | 强度（如 "中等"） |
| notes | TEXT | | 备注 |
| is_custom | INTEGER | NOT NULL DEFAULT 0 | 是否自定义 (0/1) |
| sort_order | INTEGER | NOT NULL | 排序序号（从0开始） |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**外键**:
- `session_id` → `sessions.id` (ON DELETE CASCADE)
- `action_id` → `actions.id` (ON DELETE SET NULL)
- `equipment_id` → `equipments.id` (ON DELETE SET NULL)
- `tool_id` → `tools.id` (ON DELETE SET NULL)

---

### 2.2 基础数据表

#### actions（动作表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| name | TEXT | NOT NULL, UNIQUE | 动作名称（唯一） |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**唯一约束**: `UNIQUE(name)`

---

#### equipments（器械表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| name | TEXT | NOT NULL, UNIQUE | 器械名称（唯一） |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**唯一约束**: `UNIQUE(name)`

---

#### tools（工具表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| name | TEXT | NOT NULL, UNIQUE | 工具名称（唯一） |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**唯一约束**: `UNIQUE(name)`

---

### 2.3 默认配置表

#### goal_configs（课程目标默认配置表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| goal | TEXT | NOT NULL, UNIQUE | 课程目标（唯一） |
| blueprint | TEXT | | 默认蓝图 |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**唯一约束**: `UNIQUE(goal)`

---

#### goal_config_sessions（默认配置课时模板表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| goal_config_id | INTEGER | NOT NULL, FK | 默认配置ID |
| session_number | INTEGER | NOT NULL | 课时序号（1-12） |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**外键**: `goal_config_id` → `goal_configs.id` (ON DELETE CASCADE)

**唯一约束**: `UNIQUE(goal_config_id, session_number)`

---

#### goal_config_training_blocks（默认配置训练块模板表）

| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | INTEGER | PRIMARY KEY | 主键 |
| goal_config_session_id | INTEGER | NOT NULL, FK | 默认配置课时ID |
| action_id | INTEGER | FK | 动作ID |
| equipment_id | INTEGER | FK | 器械ID |
| tool_id | INTEGER | FK | 工具ID |
| reps | TEXT | | 次数 |
| sets | TEXT | | 组数 |
| duration | TEXT | | 时长 |
| intensity | TEXT | | 强度 |
| notes | TEXT | | 备注 |
| is_custom | INTEGER | NOT NULL DEFAULT 0 | 是否自定义 |
| sort_order | INTEGER | NOT NULL | 排序序号 |
| created_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TEXT | DEFAULT CURRENT_TIMESTAMP | 更新时间 |

**外键**:
- `goal_config_session_id` → `goal_config_sessions.id` (ON DELETE CASCADE)
- `action_id` → `actions.id` (ON DELETE SET NULL)
- `equipment_id` → `equipments.id` (ON DELETE SET NULL)
- `tool_id` → `tools.id` (ON DELETE SET NULL)

---

## 三、索引设计

### 3.1 性能索引

```sql
-- 课时查询
CREATE INDEX idx_sessions_course_plan ON sessions(course_plan_id);

-- 训练块查询
CREATE INDEX idx_training_blocks_session ON training_blocks(session_id);

-- 课程规划查询
CREATE INDEX idx_course_plans_student ON course_plans(student_id);

-- 默认配置查询
CREATE INDEX idx_goal_config_sessions_config ON goal_config_sessions(goal_config_id);
CREATE INDEX idx_goal_config_training_blocks_session ON goal_config_training_blocks(goal_config_session_id);

-- 状态筛选
CREATE INDEX idx_sessions_status ON sessions(status);

-- 时间查询
CREATE INDEX idx_sessions_scheduled_time ON sessions(scheduled_time);
```

---

## 四、ER 关系图

```
students (1) ───< (N) course_plans (1) ───< (N) sessions (1) ───< (N) training_blocks
                                                                                |  |
                                                                                |  +-- actions
                                                                                |  +-- equipments
                                                                                +-- tools

goal_configs (1) ───< (N) goal_config_sessions (1) ───< (N) goal_config_training_blocks
                                                                                |  |
                                                                                |  +-- actions
                                                                                |  +-- equipments
                                                                                +-- tools
```

---

## 五、业务规则约束

### 5.1 唯一性约束

- ✅ 动作名称唯一 (`actions.name`)
- ✅ 器械名称唯一 (`equipments.name`)
- ✅ 工具名称唯一 (`tools.name`)
- ✅ 课程目标配置唯一 (`goal_configs.goal`)
- ✅ 课时序号唯一 (`sessions(course_plan_id, session_number)`)
- ✅ 默认课时序号唯一 (`goal_config_sessions(goal_config_id, session_number)`)

### 5.2 删除策略

| 关系 | 删除策略 | 说明 |
|------|----------|------|
| student → course_plan | CASCADE | 删除学员时级联删除课程规划 |
| course_plan → session | CASCADE | 删除课程规划时级联删除课时 |
| session → training_block | CASCADE | 删除课时时级联删除训练块 |
| action → training_block | SET NULL | 删除动作时训练块保留，action_id 置 NULL |
| equipment → training_block | SET NULL | 删除器械时训练块保留，equipment_id 置 NULL |
| tool → training_block | SET NULL | 删除工具时训练块保留，tool_id 置 NULL |

### 5.3 默认配置复制机制

创建课程规划时的数据流：

```
1. 读取 goal_configs (根据 goal)
2. 读取 goal_config_sessions (前12节)
3. 读取 goal_config_training_blocks
4. 创建 course_plan
5. 创建 sessions (1-12)
6. 创建 training_blocks (复制数据)
```

**关键点**：
- 默认配置与实例数据完全隔离
- 复制后两者独立，互不影响
- 修改默认配置不影响历史数据

---

## 六、课程目标枚举值

```text
- 产后修复
- 肩颈理疗
- 肩背打造
- 腰酸治疗
- 腰腹塑形
- 全身塑形
- 臀腿打造
- 膝盖疼痛
- 自定义
```

**注意**: "自定义" 目标不使用默认配置

---

## 七、课时状态枚举值

```text
- pending    // 未开始
- completed  // 已完成（消课）
- skipped    // 已跳过
```

---

## 八、初始数据

### 8.1 默认动作

```text
- 宽蹲
- 侧弓步蹲
- 侧蹬腿
- 站姿弓步（一）
- 站姿弓步（二）
- 站姿弓步（三）
```

### 8.2 默认器械

```text
- 核心床（Reformer）
- 凯迪拉克床（Cadillac）
- 稳踏椅（Chair）
- 梯桶（Ladder Barrel）
- ARC
```

### 8.3 默认工具

```text
- 盒子
- 小球
- 弹力带
- 普拉提环
- 泡沫轴
- 瑜伽砖
```

---

## 九、查询示例

### 9.1 查询学员的所有课程规划

```sql
SELECT cp.*, s.name as student_name
FROM course_plans cp
JOIN students s ON cp.student_id = s.id
WHERE s.id = ?
```

### 9.2 查询课程规划的课时列表（含进度）

```sql
SELECT
    s.*,
    COUNT(CASE WHEN s.status = 'completed' THEN 1 END) as completed_count,
    COUNT(*) as total_count
FROM sessions s
WHERE s.course_plan_id = ?
GROUP BY s.id
ORDER BY s.session_number
```

### 9.3 查询课时的训练块（按排序）

```sql
SELECT
    tb.*,
    a.name as action_name,
    e.name as equipment_name,
    t.name as tool_name
FROM training_blocks tb
LEFT JOIN actions a ON tb.action_id = a.id
LEFT JOIN equipments e ON tb.equipment_id = e.id
LEFT JOIN tools t ON tb.tool_id = t.id
WHERE tb.session_id = ?
ORDER BY tb.sort_order ASC
```

---

## 十、注意事项

1. **外键启用**: 必须执行 `PRAGMA foreign_keys = ON;`
2. **时间格式**: 统一使用 ISO8601 格式 (如 `2025-01-01T10:00:00Z`)
3. **布尔值**: 使用 INTEGER 0 (false) 和 1 (true)
4. **自定义目标**: 创建课程规划时，若 goal="自定义"，则不从默认配置复制数据
5. **课时序号**: 删除中间课时时需要重新编号或留空，建议重新编号
6. **训练块排序**: 新增训练块时需正确设置 `sort_order`

---

## 十一、数据库版本

当前版本: **v1.0**
创建日期: 2025-01-07
