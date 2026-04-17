import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In zh, this message translates to:
  /// **'学员课程管理系统'**
  String get appName;

  /// No description provided for @confirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In zh, this message translates to:
  /// **'编辑'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get add;

  /// No description provided for @retry.
  ///
  /// In zh, this message translates to:
  /// **'重试'**
  String get retry;

  /// No description provided for @loading.
  ///
  /// In zh, this message translates to:
  /// **'加载中...'**
  String get loading;

  /// No description provided for @unknown.
  ///
  /// In zh, this message translates to:
  /// **'未知'**
  String get unknown;

  /// No description provided for @btnConfirm.
  ///
  /// In zh, this message translates to:
  /// **'确认'**
  String get btnConfirm;

  /// No description provided for @btnCancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get btnCancel;

  /// No description provided for @btnSave.
  ///
  /// In zh, this message translates to:
  /// **'保存'**
  String get btnSave;

  /// No description provided for @btnDelete.
  ///
  /// In zh, this message translates to:
  /// **'删除'**
  String get btnDelete;

  /// No description provided for @btnAdd.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get btnAdd;

  /// No description provided for @btnConfirmDelete.
  ///
  /// In zh, this message translates to:
  /// **'确认删除'**
  String get btnConfirmDelete;

  /// No description provided for @btnConfirmSwitch.
  ///
  /// In zh, this message translates to:
  /// **'确认切换'**
  String get btnConfirmSwitch;

  /// No description provided for @navSchedule.
  ///
  /// In zh, this message translates to:
  /// **'课表'**
  String get navSchedule;

  /// No description provided for @navStudents.
  ///
  /// In zh, this message translates to:
  /// **'学员'**
  String get navStudents;

  /// No description provided for @navStatistics.
  ///
  /// In zh, this message translates to:
  /// **'统计'**
  String get navStatistics;

  /// No description provided for @navProfile.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get navProfile;

  /// No description provided for @statusPending.
  ///
  /// In zh, this message translates to:
  /// **'未开始'**
  String get statusPending;

  /// No description provided for @statusCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get statusCompleted;

  /// No description provided for @statusSkipped.
  ///
  /// In zh, this message translates to:
  /// **'已跳过'**
  String get statusSkipped;

  /// No description provided for @statusScheduled.
  ///
  /// In zh, this message translates to:
  /// **'待上课'**
  String get statusScheduled;

  /// No description provided for @statusCancelled.
  ///
  /// In zh, this message translates to:
  /// **'已取消'**
  String get statusCancelled;

  /// No description provided for @statusNoShow.
  ///
  /// In zh, this message translates to:
  /// **'未到'**
  String get statusNoShow;

  /// No description provided for @attendancePending.
  ///
  /// In zh, this message translates to:
  /// **'待记录'**
  String get attendancePending;

  /// No description provided for @attendancePresent.
  ///
  /// In zh, this message translates to:
  /// **'出勤'**
  String get attendancePresent;

  /// No description provided for @attendanceAbsent.
  ///
  /// In zh, this message translates to:
  /// **'缺勤'**
  String get attendanceAbsent;

  /// No description provided for @attendanceLate.
  ///
  /// In zh, this message translates to:
  /// **'迟到'**
  String get attendanceLate;

  /// No description provided for @commissionNone.
  ///
  /// In zh, this message translates to:
  /// **'无'**
  String get commissionNone;

  /// No description provided for @commissionFixed.
  ///
  /// In zh, this message translates to:
  /// **'固定金额'**
  String get commissionFixed;

  /// No description provided for @commissionPercent.
  ///
  /// In zh, this message translates to:
  /// **'百分比'**
  String get commissionPercent;

  /// No description provided for @genderMale.
  ///
  /// In zh, this message translates to:
  /// **'男'**
  String get genderMale;

  /// No description provided for @genderFemale.
  ///
  /// In zh, this message translates to:
  /// **'女'**
  String get genderFemale;

  /// No description provided for @guestBadge.
  ///
  /// In zh, this message translates to:
  /// **'客'**
  String get guestBadge;

  /// No description provided for @groupBadge.
  ///
  /// In zh, this message translates to:
  /// **'团'**
  String get groupBadge;

  /// No description provided for @deprecatedBadge.
  ///
  /// In zh, this message translates to:
  /// **'弃'**
  String get deprecatedBadge;

  /// No description provided for @schedulePageTitle.
  ///
  /// In zh, this message translates to:
  /// **'课表'**
  String get schedulePageTitle;

  /// No description provided for @createScheduledClass.
  ///
  /// In zh, this message translates to:
  /// **'新建排课'**
  String get createScheduledClass;

  /// No description provided for @viewModeDay.
  ///
  /// In zh, this message translates to:
  /// **'日'**
  String get viewModeDay;

  /// No description provided for @viewModeWeek.
  ///
  /// In zh, this message translates to:
  /// **'周'**
  String get viewModeWeek;

  /// No description provided for @viewModeMonth.
  ///
  /// In zh, this message translates to:
  /// **'月'**
  String get viewModeMonth;

  /// No description provided for @todayClassSummary.
  ///
  /// In zh, this message translates to:
  /// **'今日 {active} 节课 / 已完成 {completed} / 待上 {scheduled}'**
  String todayClassSummary(int active, int completed, int scheduled);

  /// No description provided for @noShowCount.
  ///
  /// In zh, this message translates to:
  /// **'未到 {count}'**
  String noShowCount(int count);

  /// No description provided for @cancelledCount.
  ///
  /// In zh, this message translates to:
  /// **'已取消 {count}'**
  String cancelledCount(int count);

  /// No description provided for @breakLabel.
  ///
  /// In zh, this message translates to:
  /// **'休息'**
  String get breakLabel;

  /// No description provided for @unnamedBlock.
  ///
  /// In zh, this message translates to:
  /// **'未命名'**
  String get unnamedBlock;

  /// No description provided for @editScheduledClass.
  ///
  /// In zh, this message translates to:
  /// **'编辑排课'**
  String get editScheduledClass;

  /// No description provided for @courseTypeLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程类型'**
  String get courseTypeLabel;

  /// No description provided for @dateLabel.
  ///
  /// In zh, this message translates to:
  /// **'日期'**
  String get dateLabel;

  /// No description provided for @startTimeLabel.
  ///
  /// In zh, this message translates to:
  /// **'开始时间'**
  String get startTimeLabel;

  /// No description provided for @endTimeLabel.
  ///
  /// In zh, this message translates to:
  /// **'结束时间'**
  String get endTimeLabel;

  /// No description provided for @participantsLabel.
  ///
  /// In zh, this message translates to:
  /// **'参与人'**
  String get participantsLabel;

  /// No description provided for @searchStudents.
  ///
  /// In zh, this message translates to:
  /// **'搜索学员'**
  String get searchStudents;

  /// No description provided for @participantsFull.
  ///
  /// In zh, this message translates to:
  /// **'人数已满'**
  String get participantsFull;

  /// No description provided for @temporaryPerson.
  ///
  /// In zh, this message translates to:
  /// **'临时人员'**
  String get temporaryPerson;

  /// No description provided for @titleOptionalLabel.
  ///
  /// In zh, this message translates to:
  /// **'标题（可选）'**
  String get titleOptionalLabel;

  /// No description provided for @locationOptionalLabel.
  ///
  /// In zh, this message translates to:
  /// **'地点（可选）'**
  String get locationOptionalLabel;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注（可选）'**
  String get notesOptionalLabel;

  /// No description provided for @pleaseSelectCourseTypeAndParticipant.
  ///
  /// In zh, this message translates to:
  /// **'请先选择课程类型、添加参与人'**
  String get pleaseSelectCourseTypeAndParticipant;

  /// No description provided for @participantOverflow.
  ///
  /// In zh, this message translates to:
  /// **'参与人数量超过「{typeName}」的上限（最多 {max} 人）'**
  String participantOverflow(String typeName, int max);

  /// No description provided for @addTemporaryPerson.
  ///
  /// In zh, this message translates to:
  /// **'添加临时人员'**
  String get addTemporaryPerson;

  /// No description provided for @guestNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'姓名'**
  String get guestNameLabel;

  /// No description provided for @guestAlreadyAdded.
  ///
  /// In zh, this message translates to:
  /// **'该临时人员已添加'**
  String get guestAlreadyAdded;

  /// No description provided for @duplicateNameTitle.
  ///
  /// In zh, this message translates to:
  /// **'姓名重复'**
  String get duplicateNameTitle;

  /// No description provided for @duplicateNameConfirm.
  ///
  /// In zh, this message translates to:
  /// **'{name}已在参与人列表中作为正式学员，确定再添加为临时人员吗？'**
  String duplicateNameConfirm(String name);

  /// No description provided for @confirmAddDuplicate.
  ///
  /// In zh, this message translates to:
  /// **'确定添加'**
  String get confirmAddDuplicate;

  /// No description provided for @atLeastOneParticipant.
  ///
  /// In zh, this message translates to:
  /// **'请至少添加一位参与人'**
  String get atLeastOneParticipant;

  /// No description provided for @markCompleted.
  ///
  /// In zh, this message translates to:
  /// **'完成上课（消课）'**
  String get markCompleted;

  /// No description provided for @cancelScheduledClass.
  ///
  /// In zh, this message translates to:
  /// **'取消排课'**
  String get cancelScheduledClass;

  /// No description provided for @markNoShow.
  ///
  /// In zh, this message translates to:
  /// **'标记未到'**
  String get markNoShow;

  /// No description provided for @restoreToScheduled.
  ///
  /// In zh, this message translates to:
  /// **'恢复为待上课'**
  String get restoreToScheduled;

  /// No description provided for @restoreCompleted.
  ///
  /// In zh, this message translates to:
  /// **'撤销完成'**
  String get restoreCompleted;

  /// No description provided for @confirmCompleteTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认消课'**
  String get confirmCompleteTitle;

  /// No description provided for @confirmCompleteMessage.
  ///
  /// In zh, this message translates to:
  /// **'确认标记此排课为已完成？关联的课时也会自动标记完成。'**
  String get confirmCompleteMessage;

  /// No description provided for @confirmCancelTitle.
  ///
  /// In zh, this message translates to:
  /// **'取消排课'**
  String get confirmCancelTitle;

  /// No description provided for @confirmCancelMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要取消此排课吗？取消后可以随时恢复。'**
  String get confirmCancelMessage;

  /// No description provided for @confirmNoShowTitle.
  ///
  /// In zh, this message translates to:
  /// **'标记未到'**
  String get confirmNoShowTitle;

  /// No description provided for @confirmNoShowMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要将此排课标记为学员未到吗？'**
  String get confirmNoShowMessage;

  /// No description provided for @confirmRestoreTitle.
  ///
  /// In zh, this message translates to:
  /// **'恢复排课'**
  String get confirmRestoreTitle;

  /// No description provided for @confirmRestoreMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要将此排课恢复为待上课状态吗？'**
  String get confirmRestoreMessage;

  /// No description provided for @confirmDeleteScheduledClassTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认删除'**
  String get confirmDeleteScheduledClassTitle;

  /// No description provided for @confirmDeleteScheduledClassMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除此排课记录吗？此操作不可撤销。'**
  String get confirmDeleteScheduledClassMessage;

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败'**
  String get saveFailed;

  /// No description provided for @createFailed.
  ///
  /// In zh, this message translates to:
  /// **'创建失败'**
  String get createFailed;

  /// No description provided for @workingHoursWarningTitle.
  ///
  /// In zh, this message translates to:
  /// **'提示'**
  String get workingHoursWarningTitle;

  /// No description provided for @workingHoursWarningMessage.
  ///
  /// In zh, this message translates to:
  /// **'「{start}-{end}」不在工作时间（{hours}）范围内。超出部分在日视图中可能无法正常显示，可在周视图中查看。'**
  String workingHoursWarningMessage(String start, String end, String hours);

  /// No description provided for @goBackToEdit.
  ///
  /// In zh, this message translates to:
  /// **'返回修改'**
  String get goBackToEdit;

  /// No description provided for @confirmScheduleOutsideHours.
  ///
  /// In zh, this message translates to:
  /// **'确认排课'**
  String get confirmScheduleOutsideHours;

  /// No description provided for @noStudentsToAdd.
  ///
  /// In zh, this message translates to:
  /// **'没有可添加的学员'**
  String get noStudentsToAdd;

  /// No description provided for @scheduledClassNotFound.
  ///
  /// In zh, this message translates to:
  /// **'排课记录不存在'**
  String get scheduledClassNotFound;

  /// No description provided for @sessionFeeLabel.
  ///
  /// In zh, this message translates to:
  /// **'课时费'**
  String get sessionFeeLabel;

  /// No description provided for @participantsCountLabel.
  ///
  /// In zh, this message translates to:
  /// **'参与人（{count}）'**
  String participantsCountLabel(int count);

  /// No description provided for @relatedSessionLabel.
  ///
  /// In zh, this message translates to:
  /// **'关联课时'**
  String get relatedSessionLabel;

  /// No description provided for @sessionNumberLabel.
  ///
  /// In zh, this message translates to:
  /// **'第 {number} 课时'**
  String sessionNumberLabel(int number);

  /// No description provided for @coursePlanLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程规划：{name}'**
  String coursePlanLabel(String name);

  /// No description provided for @notesTitle.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get notesTitle;

  /// No description provided for @timeLabel.
  ///
  /// In zh, this message translates to:
  /// **'时间'**
  String get timeLabel;

  /// No description provided for @durationLabel.
  ///
  /// In zh, this message translates to:
  /// **'时长'**
  String get durationLabel;

  /// No description provided for @locationLabel.
  ///
  /// In zh, this message translates to:
  /// **'地点'**
  String get locationLabel;

  /// No description provided for @minutesSuffix.
  ///
  /// In zh, this message translates to:
  /// **'分钟'**
  String get minutesSuffix;

  /// No description provided for @scheduleSettingsTitle.
  ///
  /// In zh, this message translates to:
  /// **'课表设置'**
  String get scheduleSettingsTitle;

  /// No description provided for @customWorkingHoursToggle.
  ///
  /// In zh, this message translates to:
  /// **'自定义工作时间'**
  String get customWorkingHoursToggle;

  /// No description provided for @customWorkingHoursDescription.
  ///
  /// In zh, this message translates to:
  /// **'启用后日视图仅显示配置的时段'**
  String get customWorkingHoursDescription;

  /// No description provided for @workingHoursSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'工作时段'**
  String get workingHoursSectionTitle;

  /// No description provided for @addTimeSlotTooltip.
  ///
  /// In zh, this message translates to:
  /// **'添加时段'**
  String get addTimeSlotTooltip;

  /// No description provided for @noTimeSlotsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无时段，点击 + 添加'**
  String get noTimeSlotsMessage;

  /// No description provided for @timeSlotNumberLabel.
  ///
  /// In zh, this message translates to:
  /// **'时段 {number}'**
  String timeSlotNumberLabel(int number);

  /// No description provided for @studentsPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'学员'**
  String get studentsPageTitle;

  /// No description provided for @totalStudentsCount.
  ///
  /// In zh, this message translates to:
  /// **'共 {count} 人'**
  String totalStudentsCount(int count);

  /// No description provided for @addStudentTooltip.
  ///
  /// In zh, this message translates to:
  /// **'添加学员'**
  String get addStudentTooltip;

  /// No description provided for @searchStudentHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索学员姓名、联系方式或备注'**
  String get searchStudentHint;

  /// No description provided for @noStudentsDataMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无学员数据'**
  String get noStudentsDataMessage;

  /// No description provided for @clickToAddStudentMessage.
  ///
  /// In zh, this message translates to:
  /// **'点击 + 按钮添加学员'**
  String get clickToAddStudentMessage;

  /// No description provided for @loadingFailedMessage.
  ///
  /// In zh, this message translates to:
  /// **'加载失败'**
  String get loadingFailedMessage;

  /// No description provided for @noMatchingStudents.
  ///
  /// In zh, this message translates to:
  /// **'未找到匹配的学员'**
  String get noMatchingStudents;

  /// No description provided for @tryDifferentKeywords.
  ///
  /// In zh, this message translates to:
  /// **'尝试使用其他关键词搜索'**
  String get tryDifferentKeywords;

  /// No description provided for @viewCoursePlanTooltip.
  ///
  /// In zh, this message translates to:
  /// **'查看课程规划'**
  String get viewCoursePlanTooltip;

  /// No description provided for @confirmDeleteStudentTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认删除'**
  String get confirmDeleteStudentTitle;

  /// No description provided for @confirmDeleteStudentMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除学员「{name}」吗？删除后将同时删除该学员的所有课程规划、课时数据和相册照片，此操作不可恢复。'**
  String confirmDeleteStudentMessage(String name);

  /// No description provided for @studentDeleted.
  ///
  /// In zh, this message translates to:
  /// **'学员已删除'**
  String get studentDeleted;

  /// No description provided for @studentUpdated.
  ///
  /// In zh, this message translates to:
  /// **'学员已更新'**
  String get studentUpdated;

  /// No description provided for @studentCreated.
  ///
  /// In zh, this message translates to:
  /// **'学员已创建'**
  String get studentCreated;

  /// No description provided for @editStudentTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑学员'**
  String get editStudentTitle;

  /// No description provided for @addStudentTitle.
  ///
  /// In zh, this message translates to:
  /// **'添加学员'**
  String get addStudentTitle;

  /// No description provided for @nameLabel.
  ///
  /// In zh, this message translates to:
  /// **'姓名'**
  String get nameLabel;

  /// No description provided for @enterStudentNameHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入学员姓名'**
  String get enterStudentNameHint;

  /// No description provided for @studentNameRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入学员姓名'**
  String get studentNameRequired;

  /// No description provided for @genderLabel.
  ///
  /// In zh, this message translates to:
  /// **'性别'**
  String get genderLabel;

  /// No description provided for @contactLabel.
  ///
  /// In zh, this message translates to:
  /// **'联系方式'**
  String get contactLabel;

  /// No description provided for @enterContactHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入手机号或邮箱'**
  String get enterContactHint;

  /// No description provided for @contactRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入联系方式'**
  String get contactRequired;

  /// No description provided for @notesLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get notesLabel;

  /// No description provided for @enterNotesHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入备注信息（可选）'**
  String get enterNotesHint;

  /// No description provided for @studentDetailTitle.
  ///
  /// In zh, this message translates to:
  /// **'学员详情'**
  String get studentDetailTitle;

  /// No description provided for @contactInfoLabel.
  ///
  /// In zh, this message translates to:
  /// **'联系方式'**
  String get contactInfoLabel;

  /// No description provided for @createdAtLabel.
  ///
  /// In zh, this message translates to:
  /// **'创建时间'**
  String get createdAtLabel;

  /// No description provided for @coursePlanSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程规划'**
  String get coursePlanSectionTitle;

  /// No description provided for @newButton.
  ///
  /// In zh, this message translates to:
  /// **'新建'**
  String get newButton;

  /// No description provided for @noCoursePlansMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无课程规划'**
  String get noCoursePlansMessage;

  /// No description provided for @classRecordsSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'上课记录'**
  String get classRecordsSectionTitle;

  /// No description provided for @noClassRecordsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无上课记录'**
  String get noClassRecordsMessage;

  /// No description provided for @paymentRecordsSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'付费记录'**
  String get paymentRecordsSectionTitle;

  /// No description provided for @addPaymentButton.
  ///
  /// In zh, this message translates to:
  /// **'新增'**
  String get addPaymentButton;

  /// No description provided for @noPaymentRecordsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无付费记录'**
  String get noPaymentRecordsMessage;

  /// No description provided for @totalPaymentLabel.
  ///
  /// In zh, this message translates to:
  /// **'总消费：{amount}'**
  String totalPaymentLabel(String amount);

  /// No description provided for @albumsSectionTitle.
  ///
  /// In zh, this message translates to:
  /// **'相册'**
  String get albumsSectionTitle;

  /// No description provided for @noAlbumsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无相册'**
  String get noAlbumsMessage;

  /// No description provided for @deleteAlbumTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除相册'**
  String get deleteAlbumTitle;

  /// No description provided for @confirmDeleteAlbumMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除相册「{name}」吗？删除后将同时删除所有照片，此操作不可恢复。'**
  String confirmDeleteAlbumMessage(String name);

  /// No description provided for @albumCreated.
  ///
  /// In zh, this message translates to:
  /// **'相册已创建'**
  String get albumCreated;

  /// No description provided for @albumDeleted.
  ///
  /// In zh, this message translates to:
  /// **'相册已删除'**
  String get albumDeleted;

  /// No description provided for @deleteAlbumFailed.
  ///
  /// In zh, this message translates to:
  /// **'删除失败：{error}'**
  String deleteAlbumFailed(String error);

  /// No description provided for @deleteCoursePlanTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除课程规划'**
  String get deleteCoursePlanTitle;

  /// No description provided for @confirmDeleteCoursePlanMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「{name}」吗？删除后将同时删除该规划下的所有课时和训练记录，此操作不可恢复。'**
  String confirmDeleteCoursePlanMessage(String name);

  /// No description provided for @coursePlanDeleted.
  ///
  /// In zh, this message translates to:
  /// **'课程规划已删除'**
  String get coursePlanDeleted;

  /// No description provided for @sessionDetailTitle.
  ///
  /// In zh, this message translates to:
  /// **'课时详情'**
  String get sessionDetailTitle;

  /// No description provided for @confirmDeleteContentBlockTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认删除'**
  String get confirmDeleteContentBlockTitle;

  /// No description provided for @confirmDeleteContentBlockMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除内容块 {number} 吗？'**
  String confirmDeleteContentBlockMessage(int number);

  /// No description provided for @sessionDeleted.
  ///
  /// In zh, this message translates to:
  /// **'课时已删除'**
  String get sessionDeleted;

  /// No description provided for @deleteSessionTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除课时'**
  String get deleteSessionTitle;

  /// No description provided for @confirmDeleteSessionMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「第{number}节课」吗？删除后将同时删除该课时的所有教学记录，此操作不可恢复。'**
  String confirmDeleteSessionMessage(int number);

  /// No description provided for @deleteSessionFailed.
  ///
  /// In zh, this message translates to:
  /// **'删除失败：{error}'**
  String deleteSessionFailed(String error);

  /// No description provided for @changeStatusTitle.
  ///
  /// In zh, this message translates to:
  /// **'更改状态'**
  String get changeStatusTitle;

  /// No description provided for @sessionNumberDetail.
  ///
  /// In zh, this message translates to:
  /// **'第 {number} 节课'**
  String sessionNumberDetail(int number);

  /// No description provided for @deleteSessionTooltip.
  ///
  /// In zh, this message translates to:
  /// **'删除课时'**
  String get deleteSessionTooltip;

  /// No description provided for @basicInfoSection.
  ///
  /// In zh, this message translates to:
  /// **'基本信息'**
  String get basicInfoSection;

  /// No description provided for @sessionNumberLabelDetail.
  ///
  /// In zh, this message translates to:
  /// **'课时序号'**
  String get sessionNumberLabelDetail;

  /// No description provided for @statusLabel.
  ///
  /// In zh, this message translates to:
  /// **'状态'**
  String get statusLabel;

  /// No description provided for @teachingContentSection.
  ///
  /// In zh, this message translates to:
  /// **'教学内容'**
  String get teachingContentSection;

  /// No description provided for @addContentButton.
  ///
  /// In zh, this message translates to:
  /// **'添加'**
  String get addContentButton;

  /// No description provided for @noTeachingContentMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无教学内容'**
  String get noTeachingContentMessage;

  /// No description provided for @statisticsPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'统计'**
  String get statisticsPageTitle;

  /// No description provided for @currentMonthButton.
  ///
  /// In zh, this message translates to:
  /// **'本月'**
  String get currentMonthButton;

  /// No description provided for @statisticsLoadingFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败：{error}'**
  String statisticsLoadingFailed(String error);

  /// No description provided for @courseTypeDistributionTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程类型分布'**
  String get courseTypeDistributionTitle;

  /// No description provided for @studentSpendingRankingTitle.
  ///
  /// In zh, this message translates to:
  /// **'学员消费排行'**
  String get studentSpendingRankingTitle;

  /// No description provided for @teachingHoursLabel.
  ///
  /// In zh, this message translates to:
  /// **'授课课时'**
  String get teachingHoursLabel;

  /// No description provided for @studentSpendingLabel.
  ///
  /// In zh, this message translates to:
  /// **'学员消费'**
  String get studentSpendingLabel;

  /// No description provided for @teacherIncomeLabel.
  ///
  /// In zh, this message translates to:
  /// **'教师收入'**
  String get teacherIncomeLabel;

  /// No description provided for @attendanceRateLabel.
  ///
  /// In zh, this message translates to:
  /// **'出勤率'**
  String get attendanceRateLabel;

  /// No description provided for @noStatisticsDataMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无数据'**
  String get noStatisticsDataMessage;

  /// No description provided for @customRangeOption.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get customRangeOption;

  /// No description provided for @statisticsRangeWeek.
  ///
  /// In zh, this message translates to:
  /// **'本周'**
  String get statisticsRangeWeek;

  /// No description provided for @statisticsRangeMonth.
  ///
  /// In zh, this message translates to:
  /// **'本月'**
  String get statisticsRangeMonth;

  /// No description provided for @statisticsRangeQuarter.
  ///
  /// In zh, this message translates to:
  /// **'本季'**
  String get statisticsRangeQuarter;

  /// No description provided for @statisticsRangeCustom.
  ///
  /// In zh, this message translates to:
  /// **'自定义'**
  String get statisticsRangeCustom;

  /// No description provided for @selectTeachingTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'选择教学模板'**
  String get selectTeachingTemplateTitle;

  /// No description provided for @switchTeachingTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'切换教学模板'**
  String get switchTeachingTemplateTitle;

  /// No description provided for @applyTemplateFailed.
  ///
  /// In zh, this message translates to:
  /// **'应用模板失败：{error}'**
  String applyTemplateFailed(String error);

  /// No description provided for @confirmSwitchTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'确认切换模板'**
  String get confirmSwitchTemplateTitle;

  /// No description provided for @confirmSwitchTemplateMessage.
  ///
  /// In zh, this message translates to:
  /// **'切换到「{name}」将清空以下数据：\n· 教学内容字段\n· 字段选项\n· 课程目标\n· 课程目标默认配置\n\n已有学员和课程规划不受影响，但已有内容可能无法正常显示。'**
  String confirmSwitchTemplateMessage(String name);

  /// No description provided for @switchTemplateWarning.
  ///
  /// In zh, this message translates to:
  /// **'切换模板将清空教学内容字段、字段选项、课程目标及其默认配置'**
  String get switchTemplateWarning;

  /// No description provided for @welcomeMessage.
  ///
  /// In zh, this message translates to:
  /// **'欢迎使用学员课程管理系统'**
  String get welcomeMessage;

  /// No description provided for @selectTeachingTypeMessage.
  ///
  /// In zh, this message translates to:
  /// **'请选择您的教学类型，系统将为您自动配置对应的内容字段和课程目标。'**
  String get selectTeachingTypeMessage;

  /// No description provided for @newPaymentRecordTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增付费记录'**
  String get newPaymentRecordTitle;

  /// No description provided for @courseTypeOptionalLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程类型（可选）'**
  String get courseTypeOptionalLabel;

  /// No description provided for @amountRequiredLabel.
  ///
  /// In zh, this message translates to:
  /// **'金额 *'**
  String get amountRequiredLabel;

  /// No description provided for @invalidAmountMessage.
  ///
  /// In zh, this message translates to:
  /// **'请输入有效金额'**
  String get invalidAmountMessage;

  /// No description provided for @paymentDescriptionLabel.
  ///
  /// In zh, this message translates to:
  /// **'描述'**
  String get paymentDescriptionLabel;

  /// No description provided for @salesCommissionLabel.
  ///
  /// In zh, this message translates to:
  /// **'销售提成'**
  String get salesCommissionLabel;

  /// No description provided for @percentageLabel.
  ///
  /// In zh, this message translates to:
  /// **'百分比 (%)'**
  String get percentageLabel;

  /// No description provided for @paymentDateLabel.
  ///
  /// In zh, this message translates to:
  /// **'付款日期'**
  String get paymentDateLabel;

  /// No description provided for @paymentNotesLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get paymentNotesLabel;

  /// No description provided for @paymentSaved.
  ///
  /// In zh, this message translates to:
  /// **'付费记录已保存'**
  String get paymentSaved;

  /// No description provided for @commissionDisplay.
  ///
  /// In zh, this message translates to:
  /// **'提成 ¥{amount}'**
  String commissionDisplay(String amount);

  /// No description provided for @editCourseTypeTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑课程类型'**
  String get editCourseTypeTitle;

  /// No description provided for @newCourseTypeTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增课程类型'**
  String get newCourseTypeTitle;

  /// No description provided for @courseTypeNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'名称 *'**
  String get courseTypeNameLabel;

  /// No description provided for @courseTypeNameValidation.
  ///
  /// In zh, this message translates to:
  /// **'请输入名称'**
  String get courseTypeNameValidation;

  /// No description provided for @iconLabel.
  ///
  /// In zh, this message translates to:
  /// **'图标'**
  String get iconLabel;

  /// No description provided for @colorLabel.
  ///
  /// In zh, this message translates to:
  /// **'颜色'**
  String get colorLabel;

  /// No description provided for @defaultDurationLabel.
  ///
  /// In zh, this message translates to:
  /// **'默认时长（分钟）'**
  String get defaultDurationLabel;

  /// No description provided for @groupClassLabel.
  ///
  /// In zh, this message translates to:
  /// **'团课'**
  String get groupClassLabel;

  /// No description provided for @groupClassDescription.
  ///
  /// In zh, this message translates to:
  /// **'允许多人同时参加'**
  String get groupClassDescription;

  /// No description provided for @maxStudentsLabel.
  ///
  /// In zh, this message translates to:
  /// **'最大人数'**
  String get maxStudentsLabel;

  /// No description provided for @defaultStudentPriceLabel.
  ///
  /// In zh, this message translates to:
  /// **'学员默认价格'**
  String get defaultStudentPriceLabel;

  /// No description provided for @defaultSessionFeeLabel.
  ///
  /// In zh, this message translates to:
  /// **'教师课时费'**
  String get defaultSessionFeeLabel;

  /// No description provided for @courseTypeNameExistsMessage.
  ///
  /// In zh, this message translates to:
  /// **'名称已存在或保存失败'**
  String get courseTypeNameExistsMessage;

  /// No description provided for @profilePageTitle.
  ///
  /// In zh, this message translates to:
  /// **'我的'**
  String get profilePageTitle;

  /// No description provided for @basicDataManagementSection.
  ///
  /// In zh, this message translates to:
  /// **'基础数据管理'**
  String get basicDataManagementSection;

  /// No description provided for @courseTypeManagementTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程类型管理'**
  String get courseTypeManagementTitle;

  /// No description provided for @contentFieldManagementTitle.
  ///
  /// In zh, this message translates to:
  /// **'教学内容字段'**
  String get contentFieldManagementTitle;

  /// No description provided for @goalManagementTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程目标管理'**
  String get goalManagementTitle;

  /// No description provided for @goalConfigManagementTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程目标配置'**
  String get goalConfigManagementTitle;

  /// No description provided for @teachingTemplateSection.
  ///
  /// In zh, this message translates to:
  /// **'教学模板'**
  String get teachingTemplateSection;

  /// No description provided for @currentTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'当前模板'**
  String get currentTemplateTitle;

  /// No description provided for @noTemplateSelected.
  ///
  /// In zh, this message translates to:
  /// **'未选择'**
  String get noTemplateSelected;

  /// No description provided for @scheduleSettingsSection.
  ///
  /// In zh, this message translates to:
  /// **'课表设置'**
  String get scheduleSettingsSection;

  /// No description provided for @workingHoursTitle.
  ///
  /// In zh, this message translates to:
  /// **'工作时间'**
  String get workingHoursTitle;

  /// No description provided for @workingHoursDescription.
  ///
  /// In zh, this message translates to:
  /// **'设置日视图显示的时段'**
  String get workingHoursDescription;

  /// No description provided for @aboutSection.
  ///
  /// In zh, this message translates to:
  /// **'关于'**
  String get aboutSection;

  /// No description provided for @versionLabel.
  ///
  /// In zh, this message translates to:
  /// **'版本'**
  String get versionLabel;

  /// No description provided for @addPhotoFailed.
  ///
  /// In zh, this message translates to:
  /// **'添加照片失败：{error}'**
  String addPhotoFailed(String error);

  /// No description provided for @deletePhotoTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除照片'**
  String get deletePhotoTitle;

  /// No description provided for @confirmDeletePhotoMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除这张照片吗？此操作不可恢复。'**
  String get confirmDeletePhotoMessage;

  /// No description provided for @photoDeleted.
  ///
  /// In zh, this message translates to:
  /// **'照片已删除'**
  String get photoDeleted;

  /// No description provided for @albumUpdated.
  ///
  /// In zh, this message translates to:
  /// **'相册已更新'**
  String get albumUpdated;

  /// No description provided for @takePhotoButton.
  ///
  /// In zh, this message translates to:
  /// **'拍照'**
  String get takePhotoButton;

  /// No description provided for @chooseFromGalleryButton.
  ///
  /// In zh, this message translates to:
  /// **'从相册选取'**
  String get chooseFromGalleryButton;

  /// No description provided for @albumNotesTitle.
  ///
  /// In zh, this message translates to:
  /// **'相册备注'**
  String get albumNotesTitle;

  /// No description provided for @notesConfirmButton.
  ///
  /// In zh, this message translates to:
  /// **'确定'**
  String get notesConfirmButton;

  /// No description provided for @noPhotosMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无照片'**
  String get noPhotosMessage;

  /// No description provided for @clickToAddPhotoMessage.
  ///
  /// In zh, this message translates to:
  /// **'点击右下角按钮添加照片'**
  String get clickToAddPhotoMessage;

  /// No description provided for @editAlbumDialogTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑相册'**
  String get editAlbumDialogTitle;

  /// No description provided for @albumNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'相册名称'**
  String get albumNameLabel;

  /// No description provided for @albumNotesLabel.
  ///
  /// In zh, this message translates to:
  /// **'备注'**
  String get albumNotesLabel;

  /// No description provided for @albumNotesOptionalHint.
  ///
  /// In zh, this message translates to:
  /// **'选填'**
  String get albumNotesOptionalHint;

  /// No description provided for @cannotLoadImage.
  ///
  /// In zh, this message translates to:
  /// **'无法加载图片'**
  String get cannotLoadImage;

  /// No description provided for @contentBlockUpdated.
  ///
  /// In zh, this message translates to:
  /// **'内容块已更新'**
  String get contentBlockUpdated;

  /// No description provided for @contentBlockAdded.
  ///
  /// In zh, this message translates to:
  /// **'内容块已添加'**
  String get contentBlockAdded;

  /// No description provided for @editContentTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑内容'**
  String get editContentTitle;

  /// No description provided for @addContentTitle.
  ///
  /// In zh, this message translates to:
  /// **'添加内容'**
  String get addContentTitle;

  /// No description provided for @deprecatedSuffix.
  ///
  /// In zh, this message translates to:
  /// **'（已弃用）'**
  String get deprecatedSuffix;

  /// No description provided for @moveUpTooltip.
  ///
  /// In zh, this message translates to:
  /// **'上移'**
  String get moveUpTooltip;

  /// No description provided for @moveDownTooltip.
  ///
  /// In zh, this message translates to:
  /// **'下移'**
  String get moveDownTooltip;

  /// No description provided for @contentBlockPrefix.
  ///
  /// In zh, this message translates to:
  /// **'内容块 {number}'**
  String contentBlockPrefix(int number);

  /// No description provided for @emptyValue.
  ///
  /// In zh, this message translates to:
  /// **'（空）'**
  String get emptyValue;

  /// No description provided for @noParticipants.
  ///
  /// In zh, this message translates to:
  /// **'暂无参与人'**
  String get noParticipants;

  /// No description provided for @paymentDefaultTitle.
  ///
  /// In zh, this message translates to:
  /// **'付费'**
  String get paymentDefaultTitle;

  /// No description provided for @participantsCountShort.
  ///
  /// In zh, this message translates to:
  /// **'等{count}人'**
  String participantsCountShort(int count);

  /// No description provided for @courseTypePrivate.
  ///
  /// In zh, this message translates to:
  /// **'一对一私教'**
  String get courseTypePrivate;

  /// No description provided for @courseTypeGroup.
  ///
  /// In zh, this message translates to:
  /// **'团课'**
  String get courseTypeGroup;

  /// No description provided for @courseTypeTrial.
  ///
  /// In zh, this message translates to:
  /// **'体验课'**
  String get courseTypeTrial;

  /// No description provided for @rangeWeekdayMon.
  ///
  /// In zh, this message translates to:
  /// **'周一'**
  String get rangeWeekdayMon;

  /// No description provided for @rangeWeekdayTue.
  ///
  /// In zh, this message translates to:
  /// **'周二'**
  String get rangeWeekdayTue;

  /// No description provided for @rangeWeekdayWed.
  ///
  /// In zh, this message translates to:
  /// **'周三'**
  String get rangeWeekdayWed;

  /// No description provided for @rangeWeekdayThu.
  ///
  /// In zh, this message translates to:
  /// **'周四'**
  String get rangeWeekdayThu;

  /// No description provided for @rangeWeekdayFri.
  ///
  /// In zh, this message translates to:
  /// **'周五'**
  String get rangeWeekdayFri;

  /// No description provided for @rangeWeekdaySat.
  ///
  /// In zh, this message translates to:
  /// **'周六'**
  String get rangeWeekdaySat;

  /// No description provided for @rangeWeekdaySun.
  ///
  /// In zh, this message translates to:
  /// **'周日'**
  String get rangeWeekdaySun;

  /// No description provided for @dateFormatFull.
  ///
  /// In zh, this message translates to:
  /// **'{year}年{month}月{day}日 {weekday}'**
  String dateFormatFull(int year, int month, int day, String weekday);

  /// No description provided for @timeRange.
  ///
  /// In zh, this message translates to:
  /// **'{start} - {end}'**
  String timeRange(String start, String end);

  /// No description provided for @durationMinutes.
  ///
  /// In zh, this message translates to:
  /// **'{minutes}分钟'**
  String durationMinutes(int minutes);

  /// No description provided for @addOptionTooltip.
  ///
  /// In zh, this message translates to:
  /// **'新增选项'**
  String get addOptionTooltip;

  /// No description provided for @searchOptionHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索选项...'**
  String get searchOptionHint;

  /// No description provided for @noOptionsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无选项'**
  String get noOptionsMessage;

  /// No description provided for @activateTooltip.
  ///
  /// In zh, this message translates to:
  /// **'启用'**
  String get activateTooltip;

  /// No description provided for @deprecateTooltip.
  ///
  /// In zh, this message translates to:
  /// **'弃用'**
  String get deprecateTooltip;

  /// No description provided for @optionNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'选项名称'**
  String get optionNameLabel;

  /// No description provided for @optionNameExists.
  ///
  /// In zh, this message translates to:
  /// **'该选项名称已存在'**
  String get optionNameExists;

  /// No description provided for @editOptionTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑选项'**
  String get editOptionTitle;

  /// No description provided for @newOptionTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增选项'**
  String get newOptionTitle;

  /// No description provided for @confirmDeleteOptionMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除选项「{name}」吗？'**
  String confirmDeleteOptionMessage(String name);

  /// No description provided for @optionDeleted.
  ///
  /// In zh, this message translates to:
  /// **'选项已删除'**
  String get optionDeleted;

  /// No description provided for @optionInUse.
  ///
  /// In zh, this message translates to:
  /// **'该选项已被使用，无法删除'**
  String get optionInUse;

  /// No description provided for @optionNotFound.
  ///
  /// In zh, this message translates to:
  /// **'选项不存在'**
  String get optionNotFound;

  /// No description provided for @editFieldTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑字段'**
  String get editFieldTitle;

  /// No description provided for @newFieldTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增字段'**
  String get newFieldTitle;

  /// No description provided for @fieldNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'字段名称'**
  String get fieldNameLabel;

  /// No description provided for @fieldNameHint.
  ///
  /// In zh, this message translates to:
  /// **'例如：动作、曲目、练习内容'**
  String get fieldNameHint;

  /// No description provided for @fieldNameRequired.
  ///
  /// In zh, this message translates to:
  /// **'请输入字段名称'**
  String get fieldNameRequired;

  /// No description provided for @fieldTypeLabel.
  ///
  /// In zh, this message translates to:
  /// **'字段类型'**
  String get fieldTypeLabel;

  /// No description provided for @fieldTypeSelect.
  ///
  /// In zh, this message translates to:
  /// **'下拉选择'**
  String get fieldTypeSelect;

  /// No description provided for @fieldTypeNumber.
  ///
  /// In zh, this message translates to:
  /// **'数字'**
  String get fieldTypeNumber;

  /// No description provided for @fieldTypeText.
  ///
  /// In zh, this message translates to:
  /// **'文本'**
  String get fieldTypeText;

  /// No description provided for @fieldTypeMultiline.
  ///
  /// In zh, this message translates to:
  /// **'多行文本'**
  String get fieldTypeMultiline;

  /// No description provided for @selectTypeHint.
  ///
  /// In zh, this message translates to:
  /// **'下拉选择类型支持预设选项列表，其他类型为自由输入。'**
  String get selectTypeHint;

  /// No description provided for @requiredLabel.
  ///
  /// In zh, this message translates to:
  /// **'必填'**
  String get requiredLabel;

  /// No description provided for @requiredSubtitle.
  ///
  /// In zh, this message translates to:
  /// **'创建内容块时必须填写此字段'**
  String get requiredSubtitle;

  /// No description provided for @fieldUpdated.
  ///
  /// In zh, this message translates to:
  /// **'字段已更新'**
  String get fieldUpdated;

  /// No description provided for @fieldCreated.
  ///
  /// In zh, this message translates to:
  /// **'字段已创建'**
  String get fieldCreated;

  /// No description provided for @fieldNameExists.
  ///
  /// In zh, this message translates to:
  /// **'已存在同名字段'**
  String get fieldNameExists;

  /// No description provided for @fieldDeleted.
  ///
  /// In zh, this message translates to:
  /// **'字段已删除'**
  String get fieldDeleted;

  /// No description provided for @contentFieldPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'教学内容字段'**
  String get contentFieldPageTitle;

  /// No description provided for @addFieldTooltip.
  ///
  /// In zh, this message translates to:
  /// **'新增字段'**
  String get addFieldTooltip;

  /// No description provided for @noContentFieldsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无内容字段'**
  String get noContentFieldsMessage;

  /// No description provided for @manageOptionsTooltip.
  ///
  /// In zh, this message translates to:
  /// **'管理选项'**
  String get manageOptionsTooltip;

  /// No description provided for @editCoursePlanTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑课程规划'**
  String get editCoursePlanTitle;

  /// No description provided for @courseGoalLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程目标'**
  String get courseGoalLabel;

  /// No description provided for @courseGoalChangeNote.
  ///
  /// In zh, this message translates to:
  /// **'修改课程目标不会影响已有课时的训练内容'**
  String get courseGoalChangeNote;

  /// No description provided for @blueprintLabel.
  ///
  /// In zh, this message translates to:
  /// **'蓝图描述（可选）'**
  String get blueprintLabel;

  /// No description provided for @blueprintHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入蓝图描述'**
  String get blueprintHint;

  /// No description provided for @saveFailedRetry.
  ///
  /// In zh, this message translates to:
  /// **'保存失败，请重试'**
  String get saveFailedRetry;

  /// No description provided for @updateFailed.
  ///
  /// In zh, this message translates to:
  /// **'更新失败'**
  String get updateFailed;

  /// No description provided for @goalListPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程目标管理'**
  String get goalListPageTitle;

  /// No description provided for @searchGoalHint.
  ///
  /// In zh, this message translates to:
  /// **'搜索课程目标...'**
  String get searchGoalHint;

  /// No description provided for @deprecateGoalTitle.
  ///
  /// In zh, this message translates to:
  /// **'弃用目标'**
  String get deprecateGoalTitle;

  /// No description provided for @confirmDeprecateGoalMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要弃用「{name}」吗？\n\n弃用后，将不再显示在课程规划的选择列表中，但可在管理页面恢复。'**
  String confirmDeprecateGoalMessage(String name);

  /// No description provided for @confirmDeprecate.
  ///
  /// In zh, this message translates to:
  /// **'确认弃用'**
  String get confirmDeprecate;

  /// No description provided for @restoreGoalTitle.
  ///
  /// In zh, this message translates to:
  /// **'恢复目标'**
  String get restoreGoalTitle;

  /// No description provided for @confirmRestoreGoalMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要恢复「{name}」吗？\n\n恢复后，将重新显示在课程规划的选择列表中。'**
  String confirmRestoreGoalMessage(String name);

  /// No description provided for @confirmRestore.
  ///
  /// In zh, this message translates to:
  /// **'确认恢复'**
  String get confirmRestore;

  /// No description provided for @cannotDeleteTitle.
  ///
  /// In zh, this message translates to:
  /// **'无法删除'**
  String get cannotDeleteTitle;

  /// No description provided for @goalInUseMessage.
  ///
  /// In zh, this message translates to:
  /// **'该课程目标被 {count} 个课程规划引用。\n\n建议：您可以先将其弃用，弃用后将不会在选择列表中显示。'**
  String goalInUseMessage(int count);

  /// No description provided for @iKnow.
  ///
  /// In zh, this message translates to:
  /// **'我知道了'**
  String get iKnow;

  /// No description provided for @deprecateThisGoal.
  ///
  /// In zh, this message translates to:
  /// **'弃用该目标'**
  String get deprecateThisGoal;

  /// No description provided for @confirmDeleteGoalMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「{name}」吗？\n\n此操作不可恢复。'**
  String confirmDeleteGoalMessage(String name);

  /// No description provided for @goalNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'目标名称'**
  String get goalNameLabel;

  /// No description provided for @goalNameHint.
  ///
  /// In zh, this message translates to:
  /// **'请输入课程目标名称'**
  String get goalNameHint;

  /// No description provided for @editGoalTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑课程目标'**
  String get editGoalTitle;

  /// No description provided for @newGoalTitle.
  ///
  /// In zh, this message translates to:
  /// **'新增课程目标'**
  String get newGoalTitle;

  /// No description provided for @deprecatedLabel.
  ///
  /// In zh, this message translates to:
  /// **'已弃用'**
  String get deprecatedLabel;

  /// No description provided for @restoreTooltip.
  ///
  /// In zh, this message translates to:
  /// **'恢复'**
  String get restoreTooltip;

  /// No description provided for @courseTypeListPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程类型管理'**
  String get courseTypeListPageTitle;

  /// No description provided for @newCourseTypeTooltip.
  ///
  /// In zh, this message translates to:
  /// **'新增课程类型'**
  String get newCourseTypeTooltip;

  /// No description provided for @noCourseTypesMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无课程类型'**
  String get noCourseTypesMessage;

  /// No description provided for @errorMessage.
  ///
  /// In zh, this message translates to:
  /// **'错误：{error}'**
  String errorMessage(String error);

  /// No description provided for @goalConfigPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程目标配置'**
  String get goalConfigPageTitle;

  /// No description provided for @sessionTemplatesCount.
  ///
  /// In zh, this message translates to:
  /// **'已配置 {count} 节课时模板'**
  String sessionTemplatesCount(int count);

  /// No description provided for @notConfigured.
  ///
  /// In zh, this message translates to:
  /// **'未配置'**
  String get notConfigured;

  /// No description provided for @sessionTemplateDetailTitle.
  ///
  /// In zh, this message translates to:
  /// **'课时模板详情'**
  String get sessionTemplateDetailTitle;

  /// No description provided for @sessionTemplateNumber.
  ///
  /// In zh, this message translates to:
  /// **'第 {number} 节课模板'**
  String sessionTemplateNumber(int number);

  /// No description provided for @contentBlockDeleted.
  ///
  /// In zh, this message translates to:
  /// **'内容块已删除'**
  String get contentBlockDeleted;

  /// No description provided for @resetConfigTooltip.
  ///
  /// In zh, this message translates to:
  /// **'重置配置'**
  String get resetConfigTooltip;

  /// No description provided for @addSessionTemplateTooltip.
  ///
  /// In zh, this message translates to:
  /// **'添加课时模板'**
  String get addSessionTemplateTooltip;

  /// No description provided for @blueprintTitle.
  ///
  /// In zh, this message translates to:
  /// **'蓝图'**
  String get blueprintTitle;

  /// No description provided for @editBlueprintTooltip.
  ///
  /// In zh, this message translates to:
  /// **'编辑蓝图'**
  String get editBlueprintTooltip;

  /// No description provided for @blueprintNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置蓝图'**
  String get blueprintNotSet;

  /// No description provided for @blockCount.
  ///
  /// In zh, this message translates to:
  /// **'{count} 个训练块'**
  String blockCount(int count);

  /// No description provided for @noTrainingContent.
  ///
  /// In zh, this message translates to:
  /// **'暂无训练内容'**
  String get noTrainingContent;

  /// No description provided for @noSessionTemplates.
  ///
  /// In zh, this message translates to:
  /// **'暂无课时模板'**
  String get noSessionTemplates;

  /// No description provided for @clickToAddSessionTemplate.
  ///
  /// In zh, this message translates to:
  /// **'点击右下角按钮添加课时模板'**
  String get clickToAddSessionTemplate;

  /// No description provided for @editBlueprintTitle.
  ///
  /// In zh, this message translates to:
  /// **'编辑蓝图'**
  String get editBlueprintTitle;

  /// No description provided for @blueprintCleared.
  ///
  /// In zh, this message translates to:
  /// **'蓝图已清除，配置已重置'**
  String get blueprintCleared;

  /// No description provided for @blueprintUpdated.
  ///
  /// In zh, this message translates to:
  /// **'蓝图已更新'**
  String get blueprintUpdated;

  /// No description provided for @maxSessionsReached.
  ///
  /// In zh, this message translates to:
  /// **'已达到最大课时数（12节）'**
  String get maxSessionsReached;

  /// No description provided for @addSessionTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'添加课时模板'**
  String get addSessionTemplateTitle;

  /// No description provided for @sessionNumberLabelField.
  ///
  /// In zh, this message translates to:
  /// **'课时序号'**
  String get sessionNumberLabelField;

  /// No description provided for @sessionTemplateAdded.
  ///
  /// In zh, this message translates to:
  /// **'课时模板已添加'**
  String get sessionTemplateAdded;

  /// No description provided for @sessionTemplateExists.
  ///
  /// In zh, this message translates to:
  /// **'添加失败，该课时序号已存在'**
  String get sessionTemplateExists;

  /// No description provided for @deleteSessionTemplateTitle.
  ///
  /// In zh, this message translates to:
  /// **'删除课时模板'**
  String get deleteSessionTemplateTitle;

  /// No description provided for @confirmDeleteSessionTemplateMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要删除「第{number}节课模板」吗？\n\n删除后将同时删除该课时的所有训练块模板，此操作不可恢复。'**
  String confirmDeleteSessionTemplateMessage(int number);

  /// No description provided for @lastSessionDeletedReset.
  ///
  /// In zh, this message translates to:
  /// **'最后一个课时已删除，配置已重置'**
  String get lastSessionDeletedReset;

  /// No description provided for @resetConfigTitle.
  ///
  /// In zh, this message translates to:
  /// **'重置配置'**
  String get resetConfigTitle;

  /// No description provided for @confirmResetConfigMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要重置「{name}」的默认配置吗？\n\n蓝图和所有课时模板将被删除，此操作不可恢复。'**
  String confirmResetConfigMessage(String name);

  /// No description provided for @confirmReset.
  ///
  /// In zh, this message translates to:
  /// **'确认重置'**
  String get confirmReset;

  /// No description provided for @configReset.
  ///
  /// In zh, this message translates to:
  /// **'配置已重置'**
  String get configReset;

  /// No description provided for @createAlbumTitle.
  ///
  /// In zh, this message translates to:
  /// **'新建相册'**
  String get createAlbumTitle;

  /// No description provided for @createButton.
  ///
  /// In zh, this message translates to:
  /// **'创建'**
  String get createButton;

  /// No description provided for @weekdayMon.
  ///
  /// In zh, this message translates to:
  /// **'一'**
  String get weekdayMon;

  /// No description provided for @weekdayTue.
  ///
  /// In zh, this message translates to:
  /// **'二'**
  String get weekdayTue;

  /// No description provided for @weekdayWed.
  ///
  /// In zh, this message translates to:
  /// **'三'**
  String get weekdayWed;

  /// No description provided for @weekdayThu.
  ///
  /// In zh, this message translates to:
  /// **'四'**
  String get weekdayThu;

  /// No description provided for @weekdayFri.
  ///
  /// In zh, this message translates to:
  /// **'五'**
  String get weekdayFri;

  /// No description provided for @weekdaySat.
  ///
  /// In zh, this message translates to:
  /// **'六'**
  String get weekdaySat;

  /// No description provided for @weekdaySun.
  ///
  /// In zh, this message translates to:
  /// **'日'**
  String get weekdaySun;

  /// No description provided for @weekdayFullSun.
  ///
  /// In zh, this message translates to:
  /// **'周日'**
  String get weekdayFullSun;

  /// No description provided for @weekdayFullMon.
  ///
  /// In zh, this message translates to:
  /// **'周一'**
  String get weekdayFullMon;

  /// No description provided for @weekdayFullTue.
  ///
  /// In zh, this message translates to:
  /// **'周二'**
  String get weekdayFullTue;

  /// No description provided for @weekdayFullWed.
  ///
  /// In zh, this message translates to:
  /// **'周三'**
  String get weekdayFullWed;

  /// No description provided for @weekdayFullThu.
  ///
  /// In zh, this message translates to:
  /// **'周四'**
  String get weekdayFullThu;

  /// No description provided for @weekdayFullFri.
  ///
  /// In zh, this message translates to:
  /// **'周五'**
  String get weekdayFullFri;

  /// No description provided for @weekdayFullSat.
  ///
  /// In zh, this message translates to:
  /// **'周六'**
  String get weekdayFullSat;

  /// No description provided for @coursePlanPageTitle.
  ///
  /// In zh, this message translates to:
  /// **'课程规划'**
  String get coursePlanPageTitle;

  /// No description provided for @courseGoalSectionLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程目标'**
  String get courseGoalSectionLabel;

  /// No description provided for @editCoursePlanTooltip.
  ///
  /// In zh, this message translates to:
  /// **'编辑课程规划'**
  String get editCoursePlanTooltip;

  /// No description provided for @goalNotSet.
  ///
  /// In zh, this message translates to:
  /// **'未设置'**
  String get goalNotSet;

  /// No description provided for @blueprintSectionLabel.
  ///
  /// In zh, this message translates to:
  /// **'蓝图'**
  String get blueprintSectionLabel;

  /// No description provided for @coursePlanUpdated.
  ///
  /// In zh, this message translates to:
  /// **'课程规划已更新'**
  String get coursePlanUpdated;

  /// No description provided for @totalSessionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'总课时'**
  String get totalSessionsLabel;

  /// No description provided for @completedSessionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'已完成'**
  String get completedSessionsLabel;

  /// No description provided for @pendingSessionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'未开始'**
  String get pendingSessionsLabel;

  /// No description provided for @skippedSessionsLabel.
  ///
  /// In zh, this message translates to:
  /// **'已跳过'**
  String get skippedSessionsLabel;

  /// No description provided for @noSessionsMessage.
  ///
  /// In zh, this message translates to:
  /// **'暂无课时'**
  String get noSessionsMessage;

  /// No description provided for @sessionNumberDisplay.
  ///
  /// In zh, this message translates to:
  /// **'第 {number} 节课'**
  String sessionNumberDisplay(int number);

  /// No description provided for @scheduleClassTooltip.
  ///
  /// In zh, this message translates to:
  /// **'排课'**
  String get scheduleClassTooltip;

  /// No description provided for @markCompletedTooltip.
  ///
  /// In zh, this message translates to:
  /// **'标记完成'**
  String get markCompletedTooltip;

  /// No description provided for @skipTooltip.
  ///
  /// In zh, this message translates to:
  /// **'跳过'**
  String get skipTooltip;

  /// No description provided for @confirmMarkCompletedTitle.
  ///
  /// In zh, this message translates to:
  /// **'标记为已完成'**
  String get confirmMarkCompletedTitle;

  /// No description provided for @confirmMarkCompletedMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要将第{number}节课标记为已完成吗？'**
  String confirmMarkCompletedMessage(int number);

  /// No description provided for @markedAsCompleted.
  ///
  /// In zh, this message translates to:
  /// **'已标记为完成'**
  String get markedAsCompleted;

  /// No description provided for @confirmMarkSkippedTitle.
  ///
  /// In zh, this message translates to:
  /// **'标记为已跳过'**
  String get confirmMarkSkippedTitle;

  /// No description provided for @confirmMarkSkippedMessage.
  ///
  /// In zh, this message translates to:
  /// **'确定要将第{number}节课标记为已跳过吗？'**
  String confirmMarkSkippedMessage(int number);

  /// No description provided for @markedAsSkipped.
  ///
  /// In zh, this message translates to:
  /// **'已标记为跳过'**
  String get markedAsSkipped;

  /// No description provided for @operationFailed.
  ///
  /// In zh, this message translates to:
  /// **'操作失败，请重试'**
  String get operationFailed;

  /// No description provided for @templateNotFoundWarning.
  ///
  /// In zh, this message translates to:
  /// **'未找到模板数据，将手动创建'**
  String get templateNotFoundWarning;

  /// No description provided for @templateLimitedSessions.
  ///
  /// In zh, this message translates to:
  /// **'模板仅有 {count} 节课，超出部分为空课时'**
  String templateLimitedSessions(int count);

  /// No description provided for @templateDetectFailed.
  ///
  /// In zh, this message translates to:
  /// **'检测模板失败：{error}'**
  String templateDetectFailed(String error);

  /// No description provided for @coursePlanCreatedWithCount.
  ///
  /// In zh, this message translates to:
  /// **'课程规划已创建（{count}节课）'**
  String coursePlanCreatedWithCount(int count);

  /// No description provided for @stepCreateCoursePlan.
  ///
  /// In zh, this message translates to:
  /// **'创建课程规划 (1/3)'**
  String get stepCreateCoursePlan;

  /// No description provided for @stepDetectTemplate.
  ///
  /// In zh, this message translates to:
  /// **'检测模板数据 (2/3)'**
  String get stepDetectTemplate;

  /// No description provided for @stepEditBlueprint.
  ///
  /// In zh, this message translates to:
  /// **'编辑蓝图 (3/3)'**
  String get stepEditBlueprint;

  /// No description provided for @createCoursePlanTitle.
  ///
  /// In zh, this message translates to:
  /// **'创建课程规划'**
  String get createCoursePlanTitle;

  /// No description provided for @courseGoalFieldLabel.
  ///
  /// In zh, this message translates to:
  /// **'课程目标'**
  String get courseGoalFieldLabel;

  /// No description provided for @loadGoalsFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载目标失败：{error}'**
  String loadGoalsFailed(String error);

  /// No description provided for @selectGoalHint.
  ///
  /// In zh, this message translates to:
  /// **'请选择课程目标'**
  String get selectGoalHint;

  /// No description provided for @sessionCountLabel.
  ///
  /// In zh, this message translates to:
  /// **'课时数量'**
  String get sessionCountLabel;

  /// No description provided for @selectSessionCount.
  ///
  /// In zh, this message translates to:
  /// **'选择课时数量'**
  String get selectSessionCount;

  /// No description provided for @sessionCountUnit.
  ///
  /// In zh, this message translates to:
  /// **'节 (1-60)'**
  String get sessionCountUnit;

  /// No description provided for @defaultDurationTitle.
  ///
  /// In zh, this message translates to:
  /// **'默认课时时长'**
  String get defaultDurationTitle;

  /// No description provided for @selectDuration.
  ///
  /// In zh, this message translates to:
  /// **'选择课时时长'**
  String get selectDuration;

  /// No description provided for @durationUnit.
  ///
  /// In zh, this message translates to:
  /// **'分钟 (1-180)'**
  String get durationUnit;

  /// No description provided for @orCustomLabel.
  ///
  /// In zh, this message translates to:
  /// **'或自定义：'**
  String get orCustomLabel;

  /// No description provided for @detectingTemplate.
  ///
  /// In zh, this message translates to:
  /// **'正在检测模板数据...'**
  String get detectingTemplate;

  /// No description provided for @summaryGoal.
  ///
  /// In zh, this message translates to:
  /// **'课程目标：{name}'**
  String summaryGoal(String name);

  /// No description provided for @summarySessions.
  ///
  /// In zh, this message translates to:
  /// **'课时数量：{count} 节'**
  String summarySessions(int count);

  /// No description provided for @summaryDuration.
  ///
  /// In zh, this message translates to:
  /// **'默认时长：{duration} 分钟'**
  String summaryDuration(int duration);

  /// No description provided for @summaryTemplateSessions.
  ///
  /// In zh, this message translates to:
  /// **'模板课时：{count} 节'**
  String summaryTemplateSessions(int count);

  /// No description provided for @useTemplateData.
  ///
  /// In zh, this message translates to:
  /// **'使用模板数据'**
  String get useTemplateData;

  /// No description provided for @useTemplateOn.
  ///
  /// In zh, this message translates to:
  /// **'将复制模板课时内容'**
  String get useTemplateOn;

  /// No description provided for @useTemplateOff.
  ///
  /// In zh, this message translates to:
  /// **'将创建空白课时'**
  String get useTemplateOff;

  /// No description provided for @nextStep.
  ///
  /// In zh, this message translates to:
  /// **'下一步'**
  String get nextStep;

  /// No description provided for @prevStep.
  ///
  /// In zh, this message translates to:
  /// **'上一步'**
  String get prevStep;

  /// No description provided for @applyingTemplate.
  ///
  /// In zh, this message translates to:
  /// **'正在应用模板...'**
  String get applyingTemplate;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return SEn();
    case 'zh':
      return SZh();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
