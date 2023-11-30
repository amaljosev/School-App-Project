import 'package:schoolapp/repositories/firebase/database_functions.dart';

class TaskTeacherDbFunctions {
  Future<bool> addHomeWork(
      String teacherId, String task, String subject) async {
    try {
      Map<String, dynamic> homeWorkMap = {
        'task': task,
        'subject': subject,
        'date': DateTime.now()
      };

      final bool resopnse = await DbFunctions().addSubCollection(
          map: homeWorkMap,
          collectionName: 'teachers',
          teacherId: teacherId,
          subCollectionName: 'home_works');
      return resopnse;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addAssignments(
      String teacherId, String task, String subject, DateTime deadline) async {
    try {
      Map<String, dynamic> homeWorkMap = {
        'task': task,
        'subject': subject,
        'deadline': deadline,
        'date': DateTime.now()
      };

      final bool resopnse = await DbFunctions().addSubCollection(
          map: homeWorkMap,
          collectionName: 'teachers',
          teacherId: teacherId,
          subCollectionName: 'assignments');
      return resopnse;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addEvents(
      String teacherId, String title, String topic) async { 
    try {
      Map<String, dynamic> eventsMap = {
        'title': title,
        'topic': topic,
        'date': DateTime.now()
      };

      final bool resopnse = await DbFunctions().addSubCollection(
          map: eventsMap,
          collectionName: 'teachers',
          teacherId: teacherId,
          subCollectionName: 'events');
      return resopnse;
    } catch (e) {
      return false;
    }
  }
}
