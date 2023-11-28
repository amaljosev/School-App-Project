import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolapp/models/attendance.dart';
import 'package:schoolapp/repositories/firebase/database_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendenceFunctions {
  bool responce = false;
  Future<bool> submitAttendance(
    List<DocumentSnapshot> students,
    List<bool?> checkMarks,
    String teacherId,
  ) async {
    CollectionReference<Map<String, dynamic>> studentsCollection =
        FirebaseFirestore.instance
            .collection('teachers')
            .doc(teacherId)
            .collection('students');
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(teacherId)
        .collection('attendance')
        .get();
    final DocumentSnapshot classDoc = querySnapshot.docs.first;
    int totalWorkingDays = classDoc.get('toatal_working_days_completed');
    final String classAttendanceId = classDoc.id;

    try {
      int presentCounter = 0;
      int absentCounter = 0;
      for (int i = 0; i < students.length; i++) {
        DocumentSnapshot student = students[i];
        bool? isPresent = checkMarks[i];
        int totalPresentDays = student['total_present_days'] ?? 0;
        int totalAbsentDays = student['total_missed_days'] ?? 0;

        if (isPresent == true) {
          totalPresentDays += 1;
          presentCounter += 1;
        } else {
          totalAbsentDays += 1;
          absentCounter += 1;
        }

        await studentsCollection.doc(student.id).update({
          'total_present_days': totalPresentDays,
          'total_missed_days': totalAbsentDays,
        });
      }
      final totalAttendance = AttendanceModel(
          totalWorkingDaysCompleted: totalWorkingDays += 1,
          todayPresents: presentCounter,
          todayAbsents: absentCounter,
          date: DateTime.now());
      responce = await updateClassAttendanceStatus(
          teacherId, totalAttendance, classAttendanceId);
      return responce;
    } catch (e) {
      log('udation error $e');
      return false;
    }
  }

  Future<bool> updateClassAttendanceStatus(String teacherId,
      AttendanceModel attendanceData, String attendanceId) async {
    try {
      Map<String, dynamic> studentFeeMap = {
        'toatal_working_days_completed':
            attendanceData.totalWorkingDaysCompleted,
        'total_absents': attendanceData.todayAbsents,
        'total_presents': attendanceData.todayPresents,
      };
      await FirebaseFirestore.instance
          .collection('teachers')
          .doc(teacherId)
          .collection('attendance')
          .doc(attendanceId)
          .update(studentFeeMap);
      await addDailyAttendance(attendanceData, teacherId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addDailyAttendance(
      AttendanceModel attendanceData, String teacherId) async {
    try {
      Map<String, dynamic> attendanceMap = {
        'total_absents': attendanceData.todayAbsents,
        'total_presents': attendanceData.todayPresents,
        'date': attendanceData.date,
      };
      final prefsDate = await SharedPreferences.getInstance();
      final currentDate = DateTime.now();
      final formattedDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      prefsDate.setString('last_updated_date', formattedDate.toString());

      final bool resopnse = await DbFunctions().addSubCollection(
          map: attendanceMap,
          collectionName: 'teachers',
          teacherId: teacherId,
          subCollectionName: 'attendance_history');
      return resopnse;
    } catch (e) {
      return false;
    }
  }
}
