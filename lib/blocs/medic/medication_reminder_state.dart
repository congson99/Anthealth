import 'package:anthealth_mobile/blocs/app_states.dart';
import 'package:anthealth_mobile/models/medic/medication_reminder_models.dart';

class MedicationReminderState extends CubitState {
  MedicationReminderState(this.time, this.reminder);

  final DateTime time;
  final List<ReminderMask> reminder;

  @override
  List<Object?> get props => [time, reminder];
}
