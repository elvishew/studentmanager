// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class SZh extends S {
  SZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => '学员课程管理系统';

  @override
  String get confirm => '确认';

  @override
  String get cancel => '取消';

  @override
  String get save => '保存';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get add => '添加';

  @override
  String get retry => '重试';

  @override
  String get loading => '加载中...';

  @override
  String get unknown => '未知';

  @override
  String get btnConfirm => '确认';

  @override
  String get btnCancel => '取消';

  @override
  String get btnSave => '保存';

  @override
  String get btnDelete => '删除';

  @override
  String get btnAdd => '添加';

  @override
  String get btnConfirmDelete => '确认删除';

  @override
  String get btnConfirmSwitch => '确认切换';

  @override
  String get navSchedule => '课表';

  @override
  String get navStudents => '学员';

  @override
  String get navStatistics => '统计';

  @override
  String get navProfile => '我的';

  @override
  String get statusPending => '未开始';

  @override
  String get statusCompleted => '已完成';

  @override
  String get statusSkipped => '已跳过';

  @override
  String get statusScheduled => '待上课';

  @override
  String get statusCancelled => '已取消';

  @override
  String get statusNoShow => '未到';

  @override
  String get attendancePending => '待记录';

  @override
  String get attendancePresent => '出勤';

  @override
  String get attendanceAbsent => '缺勤';

  @override
  String get attendanceLate => '迟到';

  @override
  String get commissionNone => '无';

  @override
  String get commissionFixed => '固定金额';

  @override
  String get commissionPercent => '百分比';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get guestBadge => '客';

  @override
  String get groupBadge => '团';

  @override
  String get deprecatedBadge => '弃';

  @override
  String get schedulePageTitle => '课表';

  @override
  String get createScheduledClass => '新建排课';

  @override
  String get viewModeDay => '日';

  @override
  String get viewModeWeek => '周';

  @override
  String get viewModeMonth => '月';

  @override
  String todayClassSummary(int active, int completed, int scheduled) {
    return '今日 $active 节课 / 已完成 $completed / 待上 $scheduled';
  }

  @override
  String noShowCount(int count) {
    return '未到 $count';
  }

  @override
  String cancelledCount(int count) {
    return '已取消 $count';
  }

  @override
  String get breakLabel => '休息';

  @override
  String get unnamedBlock => '未命名';

  @override
  String get editScheduledClass => '编辑排课';

  @override
  String get courseTypeLabel => '课程类型';

  @override
  String get dateLabel => '日期';

  @override
  String get startTimeLabel => '开始时间';

  @override
  String get endTimeLabel => '结束时间';

  @override
  String get participantsLabel => '参与人';

  @override
  String get searchStudents => '搜索学员';

  @override
  String get participantsFull => '人数已满';

  @override
  String get temporaryPerson => '临时人员';

  @override
  String get titleOptionalLabel => '标题（可选）';

  @override
  String get locationOptionalLabel => '地点（可选）';

  @override
  String get notesOptionalLabel => '备注（可选）';

  @override
  String get pleaseSelectCourseTypeAndParticipant => '请先选择课程类型、添加参与人';

  @override
  String participantOverflow(String typeName, int max) {
    return '参与人数量超过「$typeName」的上限（最多 $max 人）';
  }

  @override
  String get addTemporaryPerson => '添加临时人员';

  @override
  String get guestNameLabel => '姓名';

  @override
  String get guestAlreadyAdded => '该临时人员已添加';

  @override
  String get duplicateNameTitle => '姓名重复';

  @override
  String duplicateNameConfirm(String name) {
    return '$name已在参与人列表中作为正式学员，确定再添加为临时人员吗？';
  }

  @override
  String get confirmAddDuplicate => '确定添加';

  @override
  String get atLeastOneParticipant => '请至少添加一位参与人';

  @override
  String get markCompleted => '完成上课（消课）';

  @override
  String get cancelScheduledClass => '取消排课';

  @override
  String get markNoShow => '标记未到';

  @override
  String get restoreToScheduled => '恢复为待上课';

  @override
  String get restoreCompleted => '撤销完成';

  @override
  String get confirmCompleteTitle => '确认消课';

  @override
  String get confirmCompleteMessage => '确认标记此排课为已完成？关联的课时也会自动标记完成。';

  @override
  String get confirmCancelTitle => '取消排课';

  @override
  String get confirmCancelMessage => '确定要取消此排课吗？取消后可以随时恢复。';

  @override
  String get confirmNoShowTitle => '标记未到';

  @override
  String get confirmNoShowMessage => '确定要将此排课标记为学员未到吗？';

  @override
  String get confirmRestoreTitle => '恢复排课';

  @override
  String get confirmRestoreMessage => '确定要将此排课恢复为待上课状态吗？';

  @override
  String get confirmDeleteScheduledClassTitle => '确认删除';

  @override
  String get confirmDeleteScheduledClassMessage => '确定要删除此排课记录吗？此操作不可撤销。';

  @override
  String get saveFailed => '保存失败';

  @override
  String get createFailed => '创建失败';

  @override
  String get workingHoursWarningTitle => '提示';

  @override
  String workingHoursWarningMessage(String start, String end, String hours) {
    return '「$start-$end」不在工作时间（$hours）范围内。超出部分在日视图中可能无法正常显示，可在周视图中查看。';
  }

  @override
  String get goBackToEdit => '返回修改';

  @override
  String get confirmScheduleOutsideHours => '确认排课';

  @override
  String get noStudentsToAdd => '没有可添加的学员';

  @override
  String get scheduledClassNotFound => '排课记录不存在';

  @override
  String get sessionFeeLabel => '课时费';

  @override
  String participantsCountLabel(int count) {
    return '参与人（$count）';
  }

  @override
  String get relatedSessionLabel => '关联课时';

  @override
  String sessionNumberLabel(int number) {
    return '第 $number 课时';
  }

  @override
  String coursePlanLabel(String name) {
    return '课程规划：$name';
  }

  @override
  String get notesTitle => '备注';

  @override
  String get timeLabel => '时间';

  @override
  String get durationLabel => '时长';

  @override
  String get locationLabel => '地点';

  @override
  String get minutesSuffix => '分钟';

  @override
  String get scheduleSettingsTitle => '课表设置';

  @override
  String get customWorkingHoursToggle => '自定义工作时间';

  @override
  String get customWorkingHoursDescription => '启用后日视图仅显示配置的时段';

  @override
  String get workingHoursSectionTitle => '工作时段';

  @override
  String get addTimeSlotTooltip => '添加时段';

  @override
  String get noTimeSlotsMessage => '暂无时段，点击 + 添加';

  @override
  String timeSlotNumberLabel(int number) {
    return '时段 $number';
  }

  @override
  String get studentsPageTitle => '学员';

  @override
  String totalStudentsCount(int count) {
    return '共 $count 人';
  }

  @override
  String get addStudentTooltip => '添加学员';

  @override
  String get searchStudentHint => '搜索学员姓名、联系方式或备注';

  @override
  String get noStudentsDataMessage => '暂无学员数据';

  @override
  String get clickToAddStudentMessage => '点击 + 按钮添加学员';

  @override
  String get loadingFailedMessage => '加载失败';

  @override
  String get noMatchingStudents => '未找到匹配的学员';

  @override
  String get tryDifferentKeywords => '尝试使用其他关键词搜索';

  @override
  String get viewCoursePlanTooltip => '查看课程规划';

  @override
  String get confirmDeleteStudentTitle => '确认删除';

  @override
  String confirmDeleteStudentMessage(String name) {
    return '确定要删除学员「$name」吗？删除后将同时删除该学员的所有课程规划、课时数据和相册照片，此操作不可恢复。';
  }

  @override
  String get studentDeleted => '学员已删除';

  @override
  String get studentUpdated => '学员已更新';

  @override
  String get studentCreated => '学员已创建';

  @override
  String get editStudentTitle => '编辑学员';

  @override
  String get addStudentTitle => '添加学员';

  @override
  String get nameLabel => '姓名';

  @override
  String get enterStudentNameHint => '请输入学员姓名';

  @override
  String get studentNameRequired => '请输入学员姓名';

  @override
  String get genderLabel => '性别';

  @override
  String get contactLabel => '联系方式';

  @override
  String get enterContactHint => '请输入手机号或邮箱';

  @override
  String get contactRequired => '请输入联系方式';

  @override
  String get notesLabel => '备注';

  @override
  String get enterNotesHint => '请输入备注信息（可选）';

  @override
  String get studentDetailTitle => '学员详情';

  @override
  String get contactInfoLabel => '联系方式';

  @override
  String get createdAtLabel => '创建时间';

  @override
  String get coursePlanSectionTitle => '课程规划';

  @override
  String get newButton => '新建';

  @override
  String get noCoursePlansMessage => '暂无课程规划';

  @override
  String get classRecordsSectionTitle => '上课记录';

  @override
  String get noClassRecordsMessage => '暂无上课记录';

  @override
  String get paymentRecordsSectionTitle => '付费记录';

  @override
  String get addPaymentButton => '新增';

  @override
  String get noPaymentRecordsMessage => '暂无付费记录';

  @override
  String totalPaymentLabel(String amount) {
    return '总消费：$amount';
  }

  @override
  String get albumsSectionTitle => '相册';

  @override
  String get noAlbumsMessage => '暂无相册';

  @override
  String get deleteAlbumTitle => '删除相册';

  @override
  String confirmDeleteAlbumMessage(String name) {
    return '确定要删除相册「$name」吗？删除后将同时删除所有照片，此操作不可恢复。';
  }

  @override
  String get albumCreated => '相册已创建';

  @override
  String get albumDeleted => '相册已删除';

  @override
  String deleteAlbumFailed(String error) {
    return '删除失败：$error';
  }

  @override
  String get deleteCoursePlanTitle => '删除课程规划';

  @override
  String confirmDeleteCoursePlanMessage(String name) {
    return '确定要删除「$name」吗？删除后将同时删除该规划下的所有课时和训练记录，此操作不可恢复。';
  }

  @override
  String get coursePlanDeleted => '课程规划已删除';

  @override
  String get sessionDetailTitle => '课时详情';

  @override
  String get confirmDeleteContentBlockTitle => '确认删除';

  @override
  String confirmDeleteContentBlockMessage(int number) {
    return '确定要删除内容块 $number 吗？';
  }

  @override
  String get sessionDeleted => '课时已删除';

  @override
  String get deleteSessionTitle => '删除课时';

  @override
  String confirmDeleteSessionMessage(int number) {
    return '确定要删除「第$number节课」吗？删除后将同时删除该课时的所有教学记录，此操作不可恢复。';
  }

  @override
  String deleteSessionFailed(String error) {
    return '删除失败：$error';
  }

  @override
  String get changeStatusTitle => '更改状态';

  @override
  String sessionNumberDetail(int number) {
    return '第 $number 节课';
  }

  @override
  String get deleteSessionTooltip => '删除课时';

  @override
  String get basicInfoSection => '基本信息';

  @override
  String get sessionNumberLabelDetail => '课时序号';

  @override
  String get statusLabel => '状态';

  @override
  String get teachingContentSection => '教学内容';

  @override
  String get addContentButton => '添加';

  @override
  String get noTeachingContentMessage => '暂无教学内容';

  @override
  String get statisticsPageTitle => '统计';

  @override
  String get currentMonthButton => '本月';

  @override
  String statisticsLoadingFailed(String error) {
    return '加载失败：$error';
  }

  @override
  String get courseTypeDistributionTitle => '课程类型分布';

  @override
  String get studentSpendingRankingTitle => '学员消费排行';

  @override
  String get teachingHoursLabel => '授课课时';

  @override
  String get studentSpendingLabel => '学员消费';

  @override
  String get teacherIncomeLabel => '教师收入';

  @override
  String get attendanceRateLabel => '出勤率';

  @override
  String get noStatisticsDataMessage => '暂无数据';

  @override
  String get customRangeOption => '自定义';

  @override
  String get statisticsRangeWeek => '本周';

  @override
  String get statisticsRangeMonth => '本月';

  @override
  String get statisticsRangeQuarter => '本季';

  @override
  String get statisticsRangeCustom => '自定义';

  @override
  String get selectTeachingTemplateTitle => '选择教学模板';

  @override
  String get switchTeachingTemplateTitle => '切换教学模板';

  @override
  String applyTemplateFailed(String error) {
    return '应用模板失败：$error';
  }

  @override
  String get confirmSwitchTemplateTitle => '确认切换模板';

  @override
  String confirmSwitchTemplateMessage(String name) {
    return '切换到「$name」将清空以下数据：\n· 教学内容字段\n· 字段选项\n· 课程目标\n· 课程目标默认配置\n\n已有学员和课程规划不受影响，但已有内容可能无法正常显示。';
  }

  @override
  String get switchTemplateWarning => '切换模板将清空教学内容字段、字段选项、课程目标及其默认配置';

  @override
  String get welcomeMessage => '欢迎使用学员课程管理系统';

  @override
  String get selectTeachingTypeMessage => '请选择您的教学类型，系统将为您自动配置对应的内容字段和课程目标。';

  @override
  String get newPaymentRecordTitle => '新增付费记录';

  @override
  String get courseTypeOptionalLabel => '课程类型（可选）';

  @override
  String get amountRequiredLabel => '金额 *';

  @override
  String get invalidAmountMessage => '请输入有效金额';

  @override
  String get paymentDescriptionLabel => '描述';

  @override
  String get salesCommissionLabel => '销售提成';

  @override
  String get percentageLabel => '百分比 (%)';

  @override
  String get paymentDateLabel => '付款日期';

  @override
  String get paymentNotesLabel => '备注';

  @override
  String get paymentSaved => '付费记录已保存';

  @override
  String commissionDisplay(String amount) {
    return '提成 ¥$amount';
  }

  @override
  String get editCourseTypeTitle => '编辑课程类型';

  @override
  String get newCourseTypeTitle => '新增课程类型';

  @override
  String get courseTypeNameLabel => '名称 *';

  @override
  String get courseTypeNameValidation => '请输入名称';

  @override
  String get iconLabel => '图标';

  @override
  String get colorLabel => '颜色';

  @override
  String get defaultDurationLabel => '默认时长（分钟）';

  @override
  String get groupClassLabel => '团课';

  @override
  String get groupClassDescription => '允许多人同时参加';

  @override
  String get maxStudentsLabel => '最大人数';

  @override
  String get defaultStudentPriceLabel => '学员默认价格';

  @override
  String get defaultSessionFeeLabel => '教师课时费';

  @override
  String get courseTypeNameExistsMessage => '名称已存在或保存失败';

  @override
  String get profilePageTitle => '我的';

  @override
  String get basicDataManagementSection => '基础数据管理';

  @override
  String get courseTypeManagementTitle => '课程类型管理';

  @override
  String get contentFieldManagementTitle => '教学内容字段';

  @override
  String get goalManagementTitle => '课程目标管理';

  @override
  String get goalConfigManagementTitle => '课程目标配置';

  @override
  String get teachingTemplateSection => '教学模板';

  @override
  String get currentTemplateTitle => '当前模板';

  @override
  String get noTemplateSelected => '未选择';

  @override
  String get scheduleSettingsSection => '课表设置';

  @override
  String get workingHoursTitle => '工作时间';

  @override
  String get workingHoursDescription => '设置日视图显示的时段';

  @override
  String get aboutSection => '关于';

  @override
  String get versionLabel => '版本';

  @override
  String addPhotoFailed(String error) {
    return '添加照片失败：$error';
  }

  @override
  String get deletePhotoTitle => '删除照片';

  @override
  String get confirmDeletePhotoMessage => '确定要删除这张照片吗？此操作不可恢复。';

  @override
  String get photoDeleted => '照片已删除';

  @override
  String get albumUpdated => '相册已更新';

  @override
  String get takePhotoButton => '拍照';

  @override
  String get chooseFromGalleryButton => '从相册选取';

  @override
  String get albumNotesTitle => '相册备注';

  @override
  String get notesConfirmButton => '确定';

  @override
  String get noPhotosMessage => '暂无照片';

  @override
  String get clickToAddPhotoMessage => '点击右下角按钮添加照片';

  @override
  String get editAlbumDialogTitle => '编辑相册';

  @override
  String get albumNameLabel => '相册名称';

  @override
  String get albumNotesLabel => '备注';

  @override
  String get albumNotesOptionalHint => '选填';

  @override
  String get cannotLoadImage => '无法加载图片';

  @override
  String get contentBlockUpdated => '内容块已更新';

  @override
  String get contentBlockAdded => '内容块已添加';

  @override
  String get editContentTitle => '编辑内容';

  @override
  String get addContentTitle => '添加内容';

  @override
  String get deprecatedSuffix => '（已弃用）';

  @override
  String get moveUpTooltip => '上移';

  @override
  String get moveDownTooltip => '下移';

  @override
  String contentBlockPrefix(int number) {
    return '内容块 $number';
  }

  @override
  String get emptyValue => '（空）';

  @override
  String get noParticipants => '暂无参与人';

  @override
  String get paymentDefaultTitle => '付费';

  @override
  String participantsCountShort(int count) {
    return '等$count人';
  }

  @override
  String get courseTypePrivate => '一对一私教';

  @override
  String get courseTypeGroup => '团课';

  @override
  String get courseTypeTrial => '体验课';

  @override
  String get rangeWeekdayMon => '周一';

  @override
  String get rangeWeekdayTue => '周二';

  @override
  String get rangeWeekdayWed => '周三';

  @override
  String get rangeWeekdayThu => '周四';

  @override
  String get rangeWeekdayFri => '周五';

  @override
  String get rangeWeekdaySat => '周六';

  @override
  String get rangeWeekdaySun => '周日';

  @override
  String dateFormatFull(int year, int month, int day, String weekday) {
    return '$year年$month月$day日 $weekday';
  }

  @override
  String timeRange(String start, String end) {
    return '$start - $end';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes分钟';
  }

  @override
  String get addOptionTooltip => '新增选项';

  @override
  String get searchOptionHint => '搜索选项...';

  @override
  String get noOptionsMessage => '暂无选项';

  @override
  String get activateTooltip => '启用';

  @override
  String get deprecateTooltip => '弃用';

  @override
  String get optionNameLabel => '选项名称';

  @override
  String get optionNameExists => '该选项名称已存在';

  @override
  String get editOptionTitle => '编辑选项';

  @override
  String get newOptionTitle => '新增选项';

  @override
  String confirmDeleteOptionMessage(String name) {
    return '确定要删除选项「$name」吗？';
  }

  @override
  String get optionDeleted => '选项已删除';

  @override
  String get optionInUse => '该选项已被使用，无法删除';

  @override
  String get optionNotFound => '选项不存在';

  @override
  String get editFieldTitle => '编辑字段';

  @override
  String get newFieldTitle => '新增字段';

  @override
  String get fieldNameLabel => '字段名称';

  @override
  String get fieldNameHint => '例如：动作、曲目、练习内容';

  @override
  String get fieldNameRequired => '请输入字段名称';

  @override
  String get fieldTypeLabel => '字段类型';

  @override
  String get fieldTypeSelect => '下拉选择';

  @override
  String get fieldTypeNumber => '数字';

  @override
  String get fieldTypeText => '文本';

  @override
  String get fieldTypeMultiline => '多行文本';

  @override
  String get selectTypeHint => '下拉选择类型支持预设选项列表，其他类型为自由输入。';

  @override
  String get requiredLabel => '必填';

  @override
  String get requiredSubtitle => '创建内容块时必须填写此字段';

  @override
  String get fieldUpdated => '字段已更新';

  @override
  String get fieldCreated => '字段已创建';

  @override
  String get fieldNameExists => '已存在同名字段';

  @override
  String get fieldDeleted => '字段已删除';

  @override
  String get contentFieldPageTitle => '教学内容字段';

  @override
  String get addFieldTooltip => '新增字段';

  @override
  String get noContentFieldsMessage => '暂无内容字段';

  @override
  String get manageOptionsTooltip => '管理选项';

  @override
  String get editCoursePlanTitle => '编辑课程规划';

  @override
  String get courseGoalLabel => '课程目标';

  @override
  String get courseGoalChangeNote => '修改课程目标不会影响已有课时的训练内容';

  @override
  String get blueprintLabel => '蓝图描述（可选）';

  @override
  String get blueprintHint => '请输入蓝图描述';

  @override
  String get saveFailedRetry => '保存失败，请重试';

  @override
  String get updateFailed => '更新失败';

  @override
  String get goalListPageTitle => '课程目标管理';

  @override
  String get searchGoalHint => '搜索课程目标...';

  @override
  String get deprecateGoalTitle => '弃用目标';

  @override
  String confirmDeprecateGoalMessage(String name) {
    return '确定要弃用「$name」吗？\n\n弃用后，将不再显示在课程规划的选择列表中，但可在管理页面恢复。';
  }

  @override
  String get confirmDeprecate => '确认弃用';

  @override
  String get restoreGoalTitle => '恢复目标';

  @override
  String confirmRestoreGoalMessage(String name) {
    return '确定要恢复「$name」吗？\n\n恢复后，将重新显示在课程规划的选择列表中。';
  }

  @override
  String get confirmRestore => '确认恢复';

  @override
  String get cannotDeleteTitle => '无法删除';

  @override
  String goalInUseMessage(int count) {
    return '该课程目标被 $count 个课程规划引用。\n\n建议：您可以先将其弃用，弃用后将不会在选择列表中显示。';
  }

  @override
  String get iKnow => '我知道了';

  @override
  String get deprecateThisGoal => '弃用该目标';

  @override
  String confirmDeleteGoalMessage(String name) {
    return '确定要删除「$name」吗？\n\n此操作不可恢复。';
  }

  @override
  String get goalNameLabel => '目标名称';

  @override
  String get goalNameHint => '请输入课程目标名称';

  @override
  String get editGoalTitle => '编辑课程目标';

  @override
  String get newGoalTitle => '新增课程目标';

  @override
  String get deprecatedLabel => '已弃用';

  @override
  String get restoreTooltip => '恢复';

  @override
  String get courseTypeListPageTitle => '课程类型管理';

  @override
  String get newCourseTypeTooltip => '新增课程类型';

  @override
  String get noCourseTypesMessage => '暂无课程类型';

  @override
  String errorMessage(String error) {
    return '错误：$error';
  }

  @override
  String get goalConfigPageTitle => '课程目标配置';

  @override
  String sessionTemplatesCount(int count) {
    return '已配置 $count 节课时模板';
  }

  @override
  String get notConfigured => '未配置';

  @override
  String get sessionTemplateDetailTitle => '课时模板详情';

  @override
  String sessionTemplateNumber(int number) {
    return '第 $number 节课模板';
  }

  @override
  String get contentBlockDeleted => '内容块已删除';

  @override
  String get resetConfigTooltip => '重置配置';

  @override
  String get addSessionTemplateTooltip => '添加课时模板';

  @override
  String get blueprintTitle => '蓝图';

  @override
  String get editBlueprintTooltip => '编辑蓝图';

  @override
  String get blueprintNotSet => '未设置蓝图';

  @override
  String blockCount(int count) {
    return '$count 个训练块';
  }

  @override
  String get noTrainingContent => '暂无训练内容';

  @override
  String get noSessionTemplates => '暂无课时模板';

  @override
  String get clickToAddSessionTemplate => '点击右下角按钮添加课时模板';

  @override
  String get editBlueprintTitle => '编辑蓝图';

  @override
  String get blueprintCleared => '蓝图已清除，配置已重置';

  @override
  String get blueprintUpdated => '蓝图已更新';

  @override
  String get maxSessionsReached => '已达到最大课时数（12节）';

  @override
  String get addSessionTemplateTitle => '添加课时模板';

  @override
  String get sessionNumberLabelField => '课时序号';

  @override
  String get sessionTemplateAdded => '课时模板已添加';

  @override
  String get sessionTemplateExists => '添加失败，该课时序号已存在';

  @override
  String get deleteSessionTemplateTitle => '删除课时模板';

  @override
  String confirmDeleteSessionTemplateMessage(int number) {
    return '确定要删除「第$number节课模板」吗？\n\n删除后将同时删除该课时的所有训练块模板，此操作不可恢复。';
  }

  @override
  String get lastSessionDeletedReset => '最后一个课时已删除，配置已重置';

  @override
  String get resetConfigTitle => '重置配置';

  @override
  String confirmResetConfigMessage(String name) {
    return '确定要重置「$name」的默认配置吗？\n\n蓝图和所有课时模板将被删除，此操作不可恢复。';
  }

  @override
  String get confirmReset => '确认重置';

  @override
  String get configReset => '配置已重置';

  @override
  String get createAlbumTitle => '新建相册';

  @override
  String get createButton => '创建';

  @override
  String get weekdayMon => '一';

  @override
  String get weekdayTue => '二';

  @override
  String get weekdayWed => '三';

  @override
  String get weekdayThu => '四';

  @override
  String get weekdayFri => '五';

  @override
  String get weekdaySat => '六';

  @override
  String get weekdaySun => '日';

  @override
  String get weekdayFullSun => '周日';

  @override
  String get weekdayFullMon => '周一';

  @override
  String get weekdayFullTue => '周二';

  @override
  String get weekdayFullWed => '周三';

  @override
  String get weekdayFullThu => '周四';

  @override
  String get weekdayFullFri => '周五';

  @override
  String get weekdayFullSat => '周六';

  @override
  String get coursePlanPageTitle => '课程规划';

  @override
  String get courseGoalSectionLabel => '课程目标';

  @override
  String get editCoursePlanTooltip => '编辑课程规划';

  @override
  String get goalNotSet => '未设置';

  @override
  String get blueprintSectionLabel => '蓝图';

  @override
  String get coursePlanUpdated => '课程规划已更新';

  @override
  String get totalSessionsLabel => '总课时';

  @override
  String get completedSessionsLabel => '已完成';

  @override
  String get pendingSessionsLabel => '未开始';

  @override
  String get skippedSessionsLabel => '已跳过';

  @override
  String get noSessionsMessage => '暂无课时';

  @override
  String sessionNumberDisplay(int number) {
    return '第 $number 节课';
  }

  @override
  String get scheduleClassTooltip => '排课';

  @override
  String get markCompletedTooltip => '标记完成';

  @override
  String get skipTooltip => '跳过';

  @override
  String get confirmMarkCompletedTitle => '标记为已完成';

  @override
  String confirmMarkCompletedMessage(int number) {
    return '确定要将第$number节课标记为已完成吗？';
  }

  @override
  String get markedAsCompleted => '已标记为完成';

  @override
  String get confirmMarkSkippedTitle => '标记为已跳过';

  @override
  String confirmMarkSkippedMessage(int number) {
    return '确定要将第$number节课标记为已跳过吗？';
  }

  @override
  String get markedAsSkipped => '已标记为跳过';

  @override
  String get operationFailed => '操作失败，请重试';

  @override
  String get templateNotFoundWarning => '未找到模板数据，将手动创建';

  @override
  String templateLimitedSessions(int count) {
    return '模板仅有 $count 节课，超出部分为空课时';
  }

  @override
  String templateDetectFailed(String error) {
    return '检测模板失败：$error';
  }

  @override
  String coursePlanCreatedWithCount(int count) {
    return '课程规划已创建（$count节课）';
  }

  @override
  String get stepCreateCoursePlan => '创建课程规划 (1/3)';

  @override
  String get stepDetectTemplate => '检测模板数据 (2/3)';

  @override
  String get stepEditBlueprint => '编辑蓝图 (3/3)';

  @override
  String get createCoursePlanTitle => '创建课程规划';

  @override
  String get courseGoalFieldLabel => '课程目标';

  @override
  String loadGoalsFailed(String error) {
    return '加载目标失败：$error';
  }

  @override
  String get selectGoalHint => '请选择课程目标';

  @override
  String get sessionCountLabel => '课时数量';

  @override
  String get selectSessionCount => '选择课时数量';

  @override
  String get sessionCountUnit => '节 (1-60)';

  @override
  String get defaultDurationTitle => '默认课时时长';

  @override
  String get selectDuration => '选择课时时长';

  @override
  String get durationUnit => '分钟 (1-180)';

  @override
  String get orCustomLabel => '或自定义：';

  @override
  String get detectingTemplate => '正在检测模板数据...';

  @override
  String summaryGoal(String name) {
    return '课程目标：$name';
  }

  @override
  String summarySessions(int count) {
    return '课时数量：$count 节';
  }

  @override
  String summaryDuration(int duration) {
    return '默认时长：$duration 分钟';
  }

  @override
  String summaryTemplateSessions(int count) {
    return '模板课时：$count 节';
  }

  @override
  String get useTemplateData => '使用模板数据';

  @override
  String get useTemplateOn => '将复制模板课时内容';

  @override
  String get useTemplateOff => '将创建空白课时';

  @override
  String get nextStep => '下一步';

  @override
  String get prevStep => '上一步';

  @override
  String get applyingTemplate => '正在应用模板...';

  @override
  String classCountUnit(int count) {
    return '$count 节';
  }

  @override
  String classCountSessions(int count) {
    return '$count 节课';
  }

  @override
  String currencyAmount(String amount) {
    return '¥$amount';
  }

  @override
  String sessionProgressDisplay(int completed, int total) {
    return '$completed/$total 节课';
  }

  @override
  String photoCountDisplay(int count) {
    return '$count 张照片';
  }

  @override
  String get coursePlanOptionalLabel => '课程规划（可选）';

  @override
  String get noCoursePlansAvailable => '该学员暂无课程规划';
}
