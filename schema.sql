-- ============================================
-- 普拉提学员课程管理系统 - 数据库建表脚本
-- 版本: v1.0
-- 创建日期: 2025-01-07
-- ============================================

-- 启用外键约束
PRAGMA foreign_keys = ON;

-- ============================================
-- 一、基础数据表
-- ============================================

-- 动作表
CREATE TABLE actions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 器械表
CREATE TABLE equipments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 工具表
CREATE TABLE tools (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- 二、核心业务表
-- ============================================

-- 学员表
CREATE TABLE students (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    gender TEXT,
    contact TEXT NOT NULL,
    notes TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 课程规划表
CREATE TABLE course_plans (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    goal TEXT NOT NULL,
    blueprint TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE
);

-- 课时表
CREATE TABLE sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_plan_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    scheduled_time TEXT,
    status TEXT NOT NULL DEFAULT 'pending' CHECK(status IN ('pending', 'completed', 'skipped')),
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (course_plan_id) REFERENCES course_plans(id) ON DELETE CASCADE,
    UNIQUE(course_plan_id, session_number)
);

-- 训练块表
CREATE TABLE training_blocks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    session_id INTEGER NOT NULL,
    action_id INTEGER,
    equipment_id INTEGER,
    tool_id INTEGER,
    reps TEXT,
    sets TEXT,
    duration TEXT,
    intensity TEXT,
    notes TEXT,
    is_custom INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (session_id) REFERENCES sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (action_id) REFERENCES actions(id) ON DELETE SET NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipments(id) ON DELETE SET NULL,
    FOREIGN KEY (tool_id) REFERENCES tools(id) ON DELETE SET NULL
);

-- ============================================
-- 三、默认配置表
-- ============================================

-- 课程目标默认配置表
CREATE TABLE goal_configs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    goal TEXT NOT NULL UNIQUE,
    blueprint TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP
);

-- 默认配置课时模板表
CREATE TABLE goal_config_sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    goal_config_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (goal_config_id) REFERENCES goal_configs(id) ON DELETE CASCADE,
    UNIQUE(goal_config_id, session_number)
);

-- 默认配置训练块模板表
CREATE TABLE goal_config_training_blocks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    goal_config_session_id INTEGER NOT NULL,
    action_id INTEGER,
    equipment_id INTEGER,
    tool_id INTEGER,
    reps TEXT,
    sets TEXT,
    duration TEXT,
    intensity TEXT,
    notes TEXT,
    is_custom INTEGER NOT NULL DEFAULT 0,
    sort_order INTEGER NOT NULL DEFAULT 0,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP,
    updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (goal_config_session_id) REFERENCES goal_config_sessions(id) ON DELETE CASCADE,
    FOREIGN KEY (action_id) REFERENCES actions(id) ON DELETE SET NULL,
    FOREIGN KEY (equipment_id) REFERENCES equipments(id) ON DELETE SET NULL,
    FOREIGN KEY (tool_id) REFERENCES tools(id) ON DELETE SET NULL
);

-- ============================================
-- 四、索引创建
-- ============================================

-- 核心业务查询索引
CREATE INDEX idx_sessions_course_plan ON sessions(course_plan_id);
CREATE INDEX idx_training_blocks_session ON training_blocks(session_id);
CREATE INDEX idx_course_plans_student ON course_plans(student_id);

-- 默认配置查询索引
CREATE INDEX idx_goal_config_sessions_config ON goal_config_sessions(goal_config_id);
CREATE INDEX idx_goal_config_training_blocks_session ON goal_config_training_blocks(goal_config_session_id);

-- 状态筛选索引
CREATE INDEX idx_sessions_status ON sessions(status);

-- 时间查询索引
CREATE INDEX idx_sessions_scheduled_time ON sessions(scheduled_time);

-- ============================================
-- 五、初始数据插入
-- ============================================

-- 5.1 插入默认动作
INSERT INTO actions (name) VALUES
    ('宽蹲'),
    ('侧弓步蹲'),
    ('侧蹬腿'),
    ('站姿弓步（一）'),
    ('站姿弓步（二）'),
    ('站姿弓步（三）');

-- 5.2 插入默认器械
INSERT INTO equipments (name) VALUES
    ('核心床（Reformer）'),
    ('凯迪拉克床（Cadillac）'),
    ('稳踏椅（Chair）'),
    ('梯桶（Ladder Barrel）'),
    ('ARC');

-- 5.3 插入默认工具
INSERT INTO tools (name) VALUES
    ('盒子'),
    ('小球'),
    ('弹力带'),
    ('普拉提环'),
    ('泡沫轴'),
    ('瑜伽砖');

-- ============================================
-- 六、创建触发器（自动更新 updated_at）
-- ============================================

-- 学员表触发器
CREATE TRIGGER update_students_timestamp
AFTER UPDATE ON students
BEGIN
    UPDATE students SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 课程规划表触发器
CREATE TRIGGER update_course_plans_timestamp
AFTER UPDATE ON course_plans
BEGIN
    UPDATE course_plans SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 课时表触发器
CREATE TRIGGER update_sessions_timestamp
AFTER UPDATE ON sessions
BEGIN
    UPDATE sessions SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 训练块表触发器
CREATE TRIGGER update_training_blocks_timestamp
AFTER UPDATE ON training_blocks
BEGIN
    UPDATE training_blocks SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 动作表触发器
CREATE TRIGGER update_actions_timestamp
AFTER UPDATE ON actions
BEGIN
    UPDATE actions SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 器械表触发器
CREATE TRIGGER update_equipments_timestamp
AFTER UPDATE ON equipments
BEGIN
    UPDATE equipments SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 工具表触发器
CREATE TRIGGER update_tools_timestamp
AFTER UPDATE ON tools
BEGIN
    UPDATE tools SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 课程目标默认配置表触发器
CREATE TRIGGER update_goal_configs_timestamp
AFTER UPDATE ON goal_configs
BEGIN
    UPDATE goal_configs SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 默认配置课时模板表触发器
CREATE TRIGGER update_goal_config_sessions_timestamp
AFTER UPDATE ON goal_config_sessions
BEGIN
    UPDATE goal_config_sessions SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- 默认配置训练块模板表触发器
CREATE TRIGGER update_goal_config_training_blocks_timestamp
AFTER UPDATE ON goal_config_training_blocks
BEGIN
    UPDATE goal_config_training_blocks SET updated_at = CURRENT_TIMESTAMP WHERE id = NEW.id;
END;

-- ============================================
-- 完成提示
-- ============================================
-- 数据库结构创建完成！
-- 包含 10 张表、8 个索引、10 个触发器、初始数据已插入
