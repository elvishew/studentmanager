import 'package:flutter_test/flutter_test.dart';
import 'package:student_manager/providers/settings_provider.dart';
import 'package:student_manager/utils/working_hours_utils.dart';

void main() {
  // ── isClassInWorkingHours ──────────────────────────────────────────

  group('isClassInWorkingHours', () {
    test('课程在单个时间段内 → true', () {
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      expect(isClassInWorkingHours(10, 11, segments), isTrue);
    });

    test('课程跨越两个时间段 → false', () {
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      expect(isClassInWorkingHours(11, 15, segments), isFalse);
    });

    test('课程开始时间在段外 → false', () {
      final segments = [TimeSegment(start: 9, end: 12)];
      expect(isClassInWorkingHours(8, 10, segments), isFalse);
    });

    test('课程结束时间超过段尾 → false', () {
      final segments = [TimeSegment(start: 9, end: 12)];
      expect(isClassInWorkingHours(10, 13, segments), isFalse);
    });

    test('段边界精确匹配 → true', () {
      final segments = [TimeSegment(start: 14, end: 22)];
      expect(isClassInWorkingHours(14, 22, segments), isTrue);
    });

    test('空段列表 → true（未设置工作时间，不限制）', () {
      expect(isClassInWorkingHours(7, 8, []), isTrue);
    });
  });

  // ── computeDefaultStartHour ────────────────────────────────────────

  group('computeDefaultStartHour', () {
    test('正常时间：10:00, 段 [9-12, 14-22] → (11, false)', () {
      final now = DateTime(2026, 4, 17, 10, 0);
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 11);
      expect(advance, isFalse);
    });

    test('午休时间：12:30, 段 [9-12, 14-22] → (14, false)', () {
      final now = DateTime(2026, 4, 17, 12, 30);
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 14);
      expect(advance, isFalse);
    });

    test('下班后：22:30, 段 [9-12, 14-22] → (9, true)', () {
      final now = DateTime(2026, 4, 17, 22, 30);
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 9);
      expect(advance, isTrue);
    });

    test('深夜：23:00, 段 [9-12, 14-22] → (9, true)', () {
      final now = DateTime(2026, 4, 17, 23, 0);
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 9);
      expect(advance, isTrue);
    });

    test('凌晨：2:00, 段 [9-12, 14-22] → (9, false)', () {
      final now = DateTime(2026, 4, 17, 2, 0);
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      // now.hour+1=3 不在任何段内, 但 start=9 的段在 now.hour=2 之后
      expect(hour, 9);
      expect(advance, isFalse);
    });

    test('凌晨但第一段之前有段：2:00, 段 [3-6, 9-12] → (3, false)', () {
      final now = DateTime(2026, 4, 17, 2, 0);
      final segments = [TimeSegment(start: 3, end: 6), TimeSegment(start: 9, end: 12)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 3);
      expect(advance, isFalse);
    });

    test('未设置工作时间：23:00, 空段 → (24, false)', () {
      final now = DateTime(2026, 4, 17, 23, 0);
      final (hour, advance) = computeDefaultStartHour(now, []);
      expect(hour, 24);
      expect(advance, isFalse);
    });

    test('唯一一段已过：15:00, 段 [9-12] → (9, true)', () {
      final now = DateTime(2026, 4, 17, 15, 0);
      final segments = [TimeSegment(start: 9, end: 12)];
      final (hour, advance) = computeDefaultStartHour(now, segments);
      expect(hour, 9);
      expect(advance, isTrue);
    });
  });

  // ── formatSegments ─────────────────────────────────────────────────

  group('formatSegments', () {
    test('多段：[9-12, 14-22] → "09:00-12:00, 14:00-22:00"', () {
      final segments = [TimeSegment(start: 9, end: 12), TimeSegment(start: 14, end: 22)];
      expect(formatSegments(segments), '09:00-12:00, 14:00-22:00');
    });

    test('单段：[9-17] → "09:00-17:00"', () {
      final segments = [TimeSegment(start: 9, end: 17)];
      expect(formatSegments(segments), '09:00-17:00');
    });

    test('空段 → ""', () {
      expect(formatSegments([]), '');
    });
  });
}
