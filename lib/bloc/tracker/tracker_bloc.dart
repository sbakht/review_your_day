import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:bloc/bloc.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerBrain> {
  TrackerBrain brain = new TrackerBrain([]);
  @override
  TrackerBrain get initialState => brain;

  TrackerBloc() {
    TrackerBrain.fetch().then((TrackerBrain brain) async {
      this.brain = brain;
      add(TrackerInitialized());
    });
  }

  @override
  Stream<TrackerBrain> mapEventToState(
    TrackerEvent event,
  ) async* {
    if (event is TrackerInitialized) {
      yield brain;
    }
    if (event is TrackerAdded) {
      brain.add(event.toString());
    }
    if (event is TrackerRemove) {
      brain.remove(event.tracker);
    }
    if (event is TrackerSave) {
      brain.save();
    }
  }
}
