// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Student Course Manager';

  @override
  String get confirm => 'Confirm';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get unknown => 'Unknown';

  @override
  String get btnConfirm => 'Confirm';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnSave => 'Save';

  @override
  String get btnDelete => 'Delete';

  @override
  String get btnAdd => 'Add';

  @override
  String get btnConfirmDelete => 'Confirm Delete';

  @override
  String get btnConfirmSwitch => 'Confirm Switch';

  @override
  String get navSchedule => 'Schedule';

  @override
  String get navStudents => 'Students';

  @override
  String get navStatistics => 'Statistics';

  @override
  String get navProfile => 'Profile';

  @override
  String get statusPending => 'Not Started';

  @override
  String get statusCompleted => 'Completed';

  @override
  String get statusSkipped => 'Skipped';

  @override
  String get statusScheduled => 'Scheduled';

  @override
  String get statusCancelled => 'Cancelled';

  @override
  String get statusNoShow => 'No Show';

  @override
  String get attendancePending => 'Pending';

  @override
  String get attendancePresent => 'Present';

  @override
  String get attendanceAbsent => 'Absent';

  @override
  String get attendanceLate => 'Late';

  @override
  String get commissionNone => 'None';

  @override
  String get commissionFixed => 'Fixed Amount';

  @override
  String get commissionPercent => 'Percentage';

  @override
  String get genderMale => 'Male';

  @override
  String get genderFemale => 'Female';

  @override
  String get guestBadge => 'G';

  @override
  String get groupBadge => 'Grp';

  @override
  String get deprecatedBadge => 'Dep';

  @override
  String get schedulePageTitle => 'Schedule';

  @override
  String get createScheduledClass => 'New Class';

  @override
  String get viewModeDay => 'D';

  @override
  String get viewModeWeek => 'W';

  @override
  String get viewModeMonth => 'M';

  @override
  String todayClassSummary(int active, int completed, int scheduled) {
    return 'Today $active classes / $completed done / $scheduled scheduled';
  }

  @override
  String noShowCount(int count) {
    return 'No show $count';
  }

  @override
  String cancelledCount(int count) {
    return 'Cancelled $count';
  }

  @override
  String get breakLabel => 'Break';

  @override
  String get unnamedBlock => 'Untitled';

  @override
  String get editScheduledClass => 'Edit Class';

  @override
  String get courseTypeLabel => 'Course Type';

  @override
  String get dateLabel => 'Date';

  @override
  String get startTimeLabel => 'Start Time';

  @override
  String get endTimeLabel => 'End Time';

  @override
  String get participantsLabel => 'Participants';

  @override
  String get searchStudents => 'Search students';

  @override
  String get participantsFull => 'Full';

  @override
  String get temporaryPerson => 'Guest';

  @override
  String get titleOptionalLabel => 'Title (optional)';

  @override
  String get locationOptionalLabel => 'Location (optional)';

  @override
  String get notesOptionalLabel => 'Notes (optional)';

  @override
  String get pleaseSelectCourseTypeAndParticipant =>
      'Please select a course type and add participants';

  @override
  String participantOverflow(String typeName, int max) {
    return 'Number of participants exceeds the limit for \"$typeName\" (max $max)';
  }

  @override
  String get addTemporaryPerson => 'Add Guest';

  @override
  String get guestNameLabel => 'Name';

  @override
  String get guestAlreadyAdded => 'This guest has already been added';

  @override
  String get duplicateNameTitle => 'Duplicate Name';

  @override
  String duplicateNameConfirm(String name) {
    return '$name is already in the participant list as a student. Add as a guest anyway?';
  }

  @override
  String get confirmAddDuplicate => 'Add Anyway';

  @override
  String get atLeastOneParticipant => 'Please add at least one participant';

  @override
  String get markCompleted => 'Mark Completed';

  @override
  String get cancelScheduledClass => 'Cancel Class';

  @override
  String get markNoShow => 'Mark No Show';

  @override
  String get restoreToScheduled => 'Restore to Scheduled';

  @override
  String get restoreCompleted => 'Undo Completion';

  @override
  String get confirmCompleteTitle => 'Confirm Completion';

  @override
  String get confirmCompleteMessage =>
      'Mark this class as completed? The linked session will also be marked as completed.';

  @override
  String get confirmCancelTitle => 'Cancel Class';

  @override
  String get confirmCancelMessage =>
      'Are you sure you want to cancel this class? You can restore it later.';

  @override
  String get confirmNoShowTitle => 'Mark No Show';

  @override
  String get confirmNoShowMessage => 'Mark this class as student no show?';

  @override
  String get confirmRestoreTitle => 'Restore Class';

  @override
  String get confirmRestoreMessage => 'Restore this class to scheduled status?';

  @override
  String get confirmDeleteScheduledClassTitle => 'Confirm Delete';

  @override
  String get confirmDeleteScheduledClassMessage =>
      'Are you sure you want to delete this class record? This action cannot be undone.';

  @override
  String get saveFailed => 'Save failed';

  @override
  String get createFailed => 'Create failed';

  @override
  String get workingHoursWarningTitle => 'Notice';

  @override
  String workingHoursWarningMessage(String start, String end, String hours) {
    return '\"$start-$end\" is outside working hours ($hours). The overflow may not display properly in day view. Check week view instead.';
  }

  @override
  String get goBackToEdit => 'Go Back';

  @override
  String get confirmScheduleOutsideHours => 'Confirm';

  @override
  String get noStudentsToAdd => 'No students to add';

  @override
  String get scheduledClassNotFound => 'Class record not found';

  @override
  String get sessionFeeLabel => 'Session Fee';

  @override
  String participantsCountLabel(int count) {
    return 'Participants ($count)';
  }

  @override
  String get relatedSessionLabel => 'Linked Session';

  @override
  String sessionNumberLabel(int number) {
    return 'Session $number';
  }

  @override
  String coursePlanLabel(String name) {
    return 'Course Plan: $name';
  }

  @override
  String get notesTitle => 'Notes';

  @override
  String get timeLabel => 'Time';

  @override
  String get durationLabel => 'Duration';

  @override
  String get locationLabel => 'Location';

  @override
  String get minutesSuffix => 'min';

  @override
  String get scheduleSettingsTitle => 'Schedule Settings';

  @override
  String get customWorkingHoursToggle => 'Custom Working Hours';

  @override
  String get customWorkingHoursDescription =>
      'When enabled, day view only shows configured time periods';

  @override
  String get workingHoursSectionTitle => 'Working Periods';

  @override
  String get addTimeSlotTooltip => 'Add period';

  @override
  String get noTimeSlotsMessage => 'No periods, tap + to add';

  @override
  String timeSlotNumberLabel(int number) {
    return 'Period $number';
  }

  @override
  String get studentsPageTitle => 'Students';

  @override
  String totalStudentsCount(int count) {
    return '$count total';
  }

  @override
  String get addStudentTooltip => 'Add Student';

  @override
  String get searchStudentHint => 'Search by name, contact or notes';

  @override
  String get noStudentsDataMessage => 'No students yet';

  @override
  String get clickToAddStudentMessage => 'Tap + to add a student';

  @override
  String get loadingFailedMessage => 'Loading failed';

  @override
  String get noMatchingStudents => 'No matching students';

  @override
  String get tryDifferentKeywords => 'Try different keywords';

  @override
  String get viewCoursePlanTooltip => 'View Course Plan';

  @override
  String get confirmDeleteStudentTitle => 'Confirm Delete';

  @override
  String confirmDeleteStudentMessage(String name) {
    return 'Delete student \"$name\"? This will also delete all course plans, sessions, and album photos. This action cannot be undone.';
  }

  @override
  String get studentDeleted => 'Student deleted';

  @override
  String get studentUpdated => 'Student updated';

  @override
  String get studentCreated => 'Student created';

  @override
  String get editStudentTitle => 'Edit Student';

  @override
  String get addStudentTitle => 'Add Student';

  @override
  String get nameLabel => 'Name';

  @override
  String get enterStudentNameHint => 'Enter student name';

  @override
  String get studentNameRequired => 'Please enter student name';

  @override
  String get genderLabel => 'Gender';

  @override
  String get contactLabel => 'Contact';

  @override
  String get enterContactHint => 'Enter phone or email';

  @override
  String get contactRequired => 'Please enter contact info';

  @override
  String get notesLabel => 'Notes';

  @override
  String get enterNotesHint => 'Enter notes (optional)';

  @override
  String get studentDetailTitle => 'Student Detail';

  @override
  String get contactInfoLabel => 'Contact';

  @override
  String get createdAtLabel => 'Created';

  @override
  String get coursePlanSectionTitle => 'Course Plans';

  @override
  String get newButton => 'New';

  @override
  String get noCoursePlansMessage => 'No course plans';

  @override
  String get classRecordsSectionTitle => 'Class Records';

  @override
  String get noClassRecordsMessage => 'No class records';

  @override
  String get paymentRecordsSectionTitle => 'Payments';

  @override
  String get addPaymentButton => 'Add';

  @override
  String get noPaymentRecordsMessage => 'No payment records';

  @override
  String totalPaymentLabel(String amount) {
    return 'Total: $amount';
  }

  @override
  String get albumsSectionTitle => 'Albums';

  @override
  String get noAlbumsMessage => 'No albums';

  @override
  String get deleteAlbumTitle => 'Delete Album';

  @override
  String confirmDeleteAlbumMessage(String name) {
    return 'Delete album \"$name\"? All photos will be deleted. This action cannot be undone.';
  }

  @override
  String get albumCreated => 'Album created';

  @override
  String get albumDeleted => 'Album deleted';

  @override
  String deleteAlbumFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String get deleteCoursePlanTitle => 'Delete Course Plan';

  @override
  String confirmDeleteCoursePlanMessage(String name) {
    return 'Delete \"$name\"? All sessions and training records under this plan will be deleted. This action cannot be undone.';
  }

  @override
  String get coursePlanDeleted => 'Course plan deleted';

  @override
  String get sessionDetailTitle => 'Session Detail';

  @override
  String get confirmDeleteContentBlockTitle => 'Confirm Delete';

  @override
  String confirmDeleteContentBlockMessage(int number) {
    return 'Delete content block $number?';
  }

  @override
  String get sessionDeleted => 'Session deleted';

  @override
  String get deleteSessionTitle => 'Delete Session';

  @override
  String confirmDeleteSessionMessage(int number) {
    return 'Delete \"Session $number\"? All teaching records for this session will be deleted. This action cannot be undone.';
  }

  @override
  String deleteSessionFailed(String error) {
    return 'Delete failed: $error';
  }

  @override
  String get changeStatusTitle => 'Change Status';

  @override
  String sessionNumberDetail(int number) {
    return 'Session $number';
  }

  @override
  String get deleteSessionTooltip => 'Delete Session';

  @override
  String get basicInfoSection => 'Basic Info';

  @override
  String get sessionNumberLabelDetail => 'Session Number';

  @override
  String get statusLabel => 'Status';

  @override
  String get teachingContentSection => 'Teaching Content';

  @override
  String get addContentButton => 'Add';

  @override
  String get noTeachingContentMessage => 'No teaching content';

  @override
  String get statisticsPageTitle => 'Statistics';

  @override
  String get currentMonthButton => 'This Month';

  @override
  String statisticsLoadingFailed(String error) {
    return 'Loading failed: $error';
  }

  @override
  String get courseTypeDistributionTitle => 'Course Type Distribution';

  @override
  String get studentSpendingRankingTitle => 'Student Spending Ranking';

  @override
  String get teachingHoursLabel => 'Teaching Hours';

  @override
  String get studentSpendingLabel => 'Student Spending';

  @override
  String get teacherIncomeLabel => 'Teacher Income';

  @override
  String get attendanceRateLabel => 'Attendance Rate';

  @override
  String get noStatisticsDataMessage => 'No data';

  @override
  String get customRangeOption => 'Custom';

  @override
  String get statisticsRangeWeek => 'This Week';

  @override
  String get statisticsRangeMonth => 'This Month';

  @override
  String get statisticsRangeQuarter => 'This Quarter';

  @override
  String get statisticsRangeCustom => 'Custom';

  @override
  String get selectTeachingTemplateTitle => 'Select Teaching Template';

  @override
  String get switchTeachingTemplateTitle => 'Switch Teaching Template';

  @override
  String applyTemplateFailed(String error) {
    return 'Failed to apply template: $error';
  }

  @override
  String get confirmSwitchTemplateTitle => 'Confirm Switch Template';

  @override
  String confirmSwitchTemplateMessage(String name) {
    return 'Switching to \"$name\" will clear:\n· Content fields\n· Field options\n· Course goals\n· Goal default configs\n\nExisting students and course plans are unaffected, but existing content may not display correctly.';
  }

  @override
  String get switchTemplateWarning =>
      'Switching templates will clear content fields, field options, course goals, and their default configurations';

  @override
  String get welcomeMessage => 'Welcome to Student Course Manager';

  @override
  String get selectTeachingTypeMessage =>
      'Select your teaching type to auto-configure content fields and course goals.';

  @override
  String get newPaymentRecordTitle => 'New Payment';

  @override
  String get courseTypeOptionalLabel => 'Course Type (optional)';

  @override
  String get amountRequiredLabel => 'Amount *';

  @override
  String get invalidAmountMessage => 'Please enter a valid amount';

  @override
  String get paymentDescriptionLabel => 'Description';

  @override
  String get salesCommissionLabel => 'Commission';

  @override
  String get percentageLabel => 'Percentage (%)';

  @override
  String get paymentDateLabel => 'Payment Date';

  @override
  String get paymentNotesLabel => 'Notes';

  @override
  String get paymentSaved => 'Payment saved';

  @override
  String commissionDisplay(String amount) {
    return 'Commission ¥$amount';
  }

  @override
  String get editCourseTypeTitle => 'Edit Course Type';

  @override
  String get newCourseTypeTitle => 'New Course Type';

  @override
  String get courseTypeNameLabel => 'Name *';

  @override
  String get courseTypeNameValidation => 'Please enter a name';

  @override
  String get iconLabel => 'Icon';

  @override
  String get colorLabel => 'Color';

  @override
  String get defaultDurationLabel => 'Default Duration (min)';

  @override
  String get groupClassLabel => 'Group Class';

  @override
  String get groupClassDescription => 'Allow multiple participants';

  @override
  String get maxStudentsLabel => 'Max Students';

  @override
  String get defaultStudentPriceLabel => 'Default Student Price';

  @override
  String get defaultSessionFeeLabel => 'Default Session Fee';

  @override
  String get courseTypeNameExistsMessage =>
      'Name already exists or save failed';

  @override
  String get profilePageTitle => 'Profile';

  @override
  String get basicDataManagementSection => 'Data Management';

  @override
  String get courseTypeManagementTitle => 'Course Types';

  @override
  String get contentFieldManagementTitle => 'Content Fields';

  @override
  String get goalManagementTitle => 'Course Goals';

  @override
  String get goalConfigManagementTitle => 'Goal Configurations';

  @override
  String get teachingTemplateSection => 'Teaching Template';

  @override
  String get currentTemplateTitle => 'Current Template';

  @override
  String get noTemplateSelected => 'None';

  @override
  String get scheduleSettingsSection => 'Schedule Settings';

  @override
  String get workingHoursTitle => 'Working Hours';

  @override
  String get workingHoursDescription => 'Set time periods for day view';

  @override
  String get aboutSection => 'About';

  @override
  String get versionLabel => 'Version';

  @override
  String addPhotoFailed(String error) {
    return 'Failed to add photo: $error';
  }

  @override
  String get deletePhotoTitle => 'Delete Photo';

  @override
  String get confirmDeletePhotoMessage =>
      'Delete this photo? This action cannot be undone.';

  @override
  String get photoDeleted => 'Photo deleted';

  @override
  String get albumUpdated => 'Album updated';

  @override
  String get takePhotoButton => 'Take Photo';

  @override
  String get chooseFromGalleryButton => 'Choose from Gallery';

  @override
  String get albumNotesTitle => 'Album Notes';

  @override
  String get notesConfirmButton => 'OK';

  @override
  String get noPhotosMessage => 'No photos';

  @override
  String get clickToAddPhotoMessage => 'Tap the button to add photos';

  @override
  String get editAlbumDialogTitle => 'Edit Album';

  @override
  String get albumNameLabel => 'Album Name';

  @override
  String get albumNotesLabel => 'Notes';

  @override
  String get albumNotesOptionalHint => 'Optional';

  @override
  String get cannotLoadImage => 'Cannot load image';

  @override
  String get contentBlockUpdated => 'Content block updated';

  @override
  String get contentBlockAdded => 'Content block added';

  @override
  String get editContentTitle => 'Edit Content';

  @override
  String get addContentTitle => 'Add Content';

  @override
  String get deprecatedSuffix => ' (Deprecated)';

  @override
  String get moveUpTooltip => 'Move Up';

  @override
  String get moveDownTooltip => 'Move Down';

  @override
  String contentBlockPrefix(int number) {
    return 'Block $number';
  }

  @override
  String get emptyValue => '(Empty)';

  @override
  String get noParticipants => 'No participants';

  @override
  String get paymentDefaultTitle => 'Payment';

  @override
  String participantsCountShort(int count) {
    return '+$count more';
  }

  @override
  String get courseTypePrivate => 'Private (1-on-1)';

  @override
  String get courseTypeGroup => 'Group Class';

  @override
  String get courseTypeTrial => 'Trial Class';

  @override
  String get rangeWeekdayMon => 'Mon';

  @override
  String get rangeWeekdayTue => 'Tue';

  @override
  String get rangeWeekdayWed => 'Wed';

  @override
  String get rangeWeekdayThu => 'Thu';

  @override
  String get rangeWeekdayFri => 'Fri';

  @override
  String get rangeWeekdaySat => 'Sat';

  @override
  String get rangeWeekdaySun => 'Sun';

  @override
  String dateFormatFull(int year, int month, int day, String weekday) {
    return '$month/$day/$year $weekday';
  }

  @override
  String timeRange(String start, String end) {
    return '$start - $end';
  }

  @override
  String durationMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get addOptionTooltip => 'Add Option';

  @override
  String get searchOptionHint => 'Search options...';

  @override
  String get noOptionsMessage => 'No options';

  @override
  String get activateTooltip => 'Activate';

  @override
  String get deprecateTooltip => 'Deprecate';

  @override
  String get optionNameLabel => 'Option Name';

  @override
  String get optionNameExists => 'This option name already exists';

  @override
  String get editOptionTitle => 'Edit Option';

  @override
  String get newOptionTitle => 'New Option';

  @override
  String confirmDeleteOptionMessage(String name) {
    return 'Delete option \"$name\"?';
  }

  @override
  String get optionDeleted => 'Option deleted';

  @override
  String get optionInUse => 'This option is in use and cannot be deleted';

  @override
  String get optionNotFound => 'Option not found';

  @override
  String get editFieldTitle => 'Edit Field';

  @override
  String get newFieldTitle => 'New Field';

  @override
  String get fieldNameLabel => 'Field Name';

  @override
  String get fieldNameHint => 'e.g. Movement, Piece, Practice Content';

  @override
  String get fieldNameRequired => 'Please enter field name';

  @override
  String get fieldTypeLabel => 'Field Type';

  @override
  String get fieldTypeSelect => 'Dropdown Select';

  @override
  String get fieldTypeNumber => 'Number';

  @override
  String get fieldTypeText => 'Text';

  @override
  String get fieldTypeMultiline => 'Multiline Text';

  @override
  String get selectTypeHint =>
      'Dropdown select supports preset option lists; other types accept free input.';

  @override
  String get requiredLabel => 'Required';

  @override
  String get requiredSubtitle =>
      'This field must be filled when creating content blocks';

  @override
  String get fieldUpdated => 'Field updated';

  @override
  String get fieldCreated => 'Field created';

  @override
  String get fieldNameExists => 'A field with this name already exists';

  @override
  String get fieldDeleted => 'Field deleted';

  @override
  String get contentFieldPageTitle => 'Content Fields';

  @override
  String get addFieldTooltip => 'Add Field';

  @override
  String get noContentFieldsMessage => 'No content fields';

  @override
  String get manageOptionsTooltip => 'Manage Options';

  @override
  String get editCoursePlanTitle => 'Edit Course Plan';

  @override
  String get courseGoalLabel => 'Course Goal';

  @override
  String get courseGoalChangeNote =>
      'Changing the course goal will not affect existing session content';

  @override
  String get blueprintLabel => 'Blueprint (optional)';

  @override
  String get blueprintHint => 'Enter blueprint description';

  @override
  String get saveFailedRetry => 'Save failed, please retry';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get goalListPageTitle => 'Course Goals';

  @override
  String get searchGoalHint => 'Search course goals...';

  @override
  String get deprecateGoalTitle => 'Deprecate Goal';

  @override
  String confirmDeprecateGoalMessage(String name) {
    return 'Deprecate \"$name\"?\n\nIt will no longer appear in course plan selections, but can be restored from the management page.';
  }

  @override
  String get confirmDeprecate => 'Confirm Deprecate';

  @override
  String get restoreGoalTitle => 'Restore Goal';

  @override
  String confirmRestoreGoalMessage(String name) {
    return 'Restore \"$name\"?\n\nIt will reappear in course plan selections.';
  }

  @override
  String get confirmRestore => 'Confirm Restore';

  @override
  String get cannotDeleteTitle => 'Cannot Delete';

  @override
  String goalInUseMessage(int count) {
    return 'This goal is referenced by $count course plans.\n\nSuggestion: You can deprecate it first. Deprecated goals won\'t appear in selections.';
  }

  @override
  String get iKnow => 'I Understand';

  @override
  String get deprecateThisGoal => 'Deprecate This Goal';

  @override
  String confirmDeleteGoalMessage(String name) {
    return 'Delete \"$name\"?\n\nThis action cannot be undone.';
  }

  @override
  String get goalNameLabel => 'Goal Name';

  @override
  String get goalNameHint => 'Enter course goal name';

  @override
  String get editGoalTitle => 'Edit Course Goal';

  @override
  String get newGoalTitle => 'New Course Goal';

  @override
  String get deprecatedLabel => 'Deprecated';

  @override
  String get restoreTooltip => 'Restore';

  @override
  String get courseTypeListPageTitle => 'Course Types';

  @override
  String get newCourseTypeTooltip => 'New Course Type';

  @override
  String get noCourseTypesMessage => 'No course types';

  @override
  String errorMessage(String error) {
    return 'Error: $error';
  }

  @override
  String get goalConfigPageTitle => 'Goal Configurations';

  @override
  String sessionTemplatesCount(int count) {
    return '$count session templates configured';
  }

  @override
  String get notConfigured => 'Not Configured';

  @override
  String get sessionTemplateDetailTitle => 'Session Template Detail';

  @override
  String sessionTemplateNumber(int number) {
    return 'Session $number Template';
  }

  @override
  String get contentBlockDeleted => 'Content block deleted';

  @override
  String get resetConfigTooltip => 'Reset Config';

  @override
  String get addSessionTemplateTooltip => 'Add Session Template';

  @override
  String get blueprintTitle => 'Blueprint';

  @override
  String get editBlueprintTooltip => 'Edit Blueprint';

  @override
  String get blueprintNotSet => 'No blueprint set';

  @override
  String blockCount(int count) {
    return '$count training blocks';
  }

  @override
  String get noTrainingContent => 'No training content';

  @override
  String get noSessionTemplates => 'No session templates';

  @override
  String get clickToAddSessionTemplate =>
      'Tap the button to add a session template';

  @override
  String get editBlueprintTitle => 'Edit Blueprint';

  @override
  String get blueprintCleared => 'Blueprint cleared, config reset';

  @override
  String get blueprintUpdated => 'Blueprint updated';

  @override
  String get maxSessionsReached => 'Maximum session count reached (12)';

  @override
  String get addSessionTemplateTitle => 'Add Session Template';

  @override
  String get sessionNumberLabelField => 'Session Number';

  @override
  String get sessionTemplateAdded => 'Session template added';

  @override
  String get sessionTemplateExists =>
      'Failed to add, session number already exists';

  @override
  String get deleteSessionTemplateTitle => 'Delete Session Template';

  @override
  String confirmDeleteSessionTemplateMessage(int number) {
    return 'Delete \"Session $number Template\"?\n\nAll training block templates for this session will be deleted. This action cannot be undone.';
  }

  @override
  String get lastSessionDeletedReset => 'Last session deleted, config reset';

  @override
  String get resetConfigTitle => 'Reset Configuration';

  @override
  String confirmResetConfigMessage(String name) {
    return 'Reset the default configuration for \"$name\"?\n\nThe blueprint and all session templates will be deleted. This action cannot be undone.';
  }

  @override
  String get confirmReset => 'Confirm Reset';

  @override
  String get configReset => 'Configuration reset';

  @override
  String get createAlbumTitle => 'New Album';

  @override
  String get createButton => 'Create';

  @override
  String get weekdayMon => 'M';

  @override
  String get weekdayTue => 'T';

  @override
  String get weekdayWed => 'W';

  @override
  String get weekdayThu => 'T';

  @override
  String get weekdayFri => 'F';

  @override
  String get weekdaySat => 'S';

  @override
  String get weekdaySun => 'S';

  @override
  String get weekdayFullSun => 'Sun';

  @override
  String get weekdayFullMon => 'Mon';

  @override
  String get weekdayFullTue => 'Tue';

  @override
  String get weekdayFullWed => 'Wed';

  @override
  String get weekdayFullThu => 'Thu';

  @override
  String get weekdayFullFri => 'Fri';

  @override
  String get weekdayFullSat => 'Sat';

  @override
  String get coursePlanPageTitle => 'Course Plan';

  @override
  String get courseGoalSectionLabel => 'Course Goal';

  @override
  String get editCoursePlanTooltip => 'Edit Course Plan';

  @override
  String get goalNotSet => 'Not set';

  @override
  String get blueprintSectionLabel => 'Blueprint';

  @override
  String get coursePlanUpdated => 'Course plan updated';

  @override
  String get totalSessionsLabel => 'Total';

  @override
  String get completedSessionsLabel => 'Completed';

  @override
  String get pendingSessionsLabel => 'Pending';

  @override
  String get skippedSessionsLabel => 'Skipped';

  @override
  String get noSessionsMessage => 'No sessions';

  @override
  String sessionNumberDisplay(int number) {
    return 'Session $number';
  }

  @override
  String get scheduleClassTooltip => 'Schedule';

  @override
  String get markCompletedTooltip => 'Mark Done';

  @override
  String get skipTooltip => 'Skip';

  @override
  String get confirmMarkCompletedTitle => 'Mark as Completed';

  @override
  String confirmMarkCompletedMessage(int number) {
    return 'Mark session $number as completed?';
  }

  @override
  String get markedAsCompleted => 'Marked as completed';

  @override
  String get confirmMarkSkippedTitle => 'Mark as Skipped';

  @override
  String confirmMarkSkippedMessage(int number) {
    return 'Mark session $number as skipped?';
  }

  @override
  String get markedAsSkipped => 'Marked as skipped';

  @override
  String get operationFailed => 'Operation failed, please retry';

  @override
  String get templateNotFoundWarning =>
      'Template data not found, will create manually';

  @override
  String templateLimitedSessions(int count) {
    return 'Template has only $count sessions, remaining will be empty';
  }

  @override
  String templateDetectFailed(String error) {
    return 'Template detection failed: $error';
  }

  @override
  String coursePlanCreatedWithCount(int count) {
    return 'Course plan created ($count sessions)';
  }

  @override
  String get stepCreateCoursePlan => 'Create Course Plan (1/3)';

  @override
  String get stepDetectTemplate => 'Detect Template Data (2/3)';

  @override
  String get stepEditBlueprint => 'Edit Blueprint (3/3)';

  @override
  String get createCoursePlanTitle => 'Create Course Plan';

  @override
  String get courseGoalFieldLabel => 'Course Goal';

  @override
  String loadGoalsFailed(String error) {
    return 'Failed to load goals: $error';
  }

  @override
  String get selectGoalHint => 'Select a course goal';

  @override
  String get sessionCountLabel => 'Session Count';

  @override
  String get selectSessionCount => 'Select session count';

  @override
  String get sessionCountUnit => 'sessions (1-60)';

  @override
  String get defaultDurationTitle => 'Default Session Duration';

  @override
  String get selectDuration => 'Select duration';

  @override
  String get durationUnit => 'min (1-180)';

  @override
  String get orCustomLabel => 'Or custom:';

  @override
  String get detectingTemplate => 'Detecting template data...';

  @override
  String summaryGoal(String name) {
    return 'Goal: $name';
  }

  @override
  String summarySessions(int count) {
    return 'Sessions: $count';
  }

  @override
  String summaryDuration(int duration) {
    return 'Duration: $duration min';
  }

  @override
  String summaryTemplateSessions(int count) {
    return 'Template sessions: $count';
  }

  @override
  String get useTemplateData => 'Use Template Data';

  @override
  String get useTemplateOn => 'Will copy template session content';

  @override
  String get useTemplateOff => 'Will create empty sessions';

  @override
  String get nextStep => 'Next';

  @override
  String get prevStep => 'Back';

  @override
  String get applyingTemplate => 'Applying template...';
}
