import '../entity/checklist_status_count_entity.dart';
import '../entity/loginentity.dart';

abstract class CheckListStausRepository {
  Future<ChecklistStatusEntity> getChecklistStatusCount(
      int count, String toDate, String token);
}
