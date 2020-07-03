import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_state.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:bloc/bloc.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  TrackerBrain brain = new TrackerBrain([]);
  SortBy sortMethod = SortBy.DescPercentYes;

  @override
  TrackerState get initialState => StateTrackerLoading();

  TrackerBloc() {
    TrackerBrain.fetch().then((TrackerBrain brain) async {
      this.brain = brain;
      add(EventTrackerInitialized());
    });
  }

  @override
  Stream<TrackerState> mapEventToState(
    TrackerEvent event,
  ) async* {
    if (event is EventTrackerInitialized) {
//      yield StateTracker(trackerBrain: brain);
    }
    if (event is EventAddTracker) {
      brain.add(event.toString());
    }
    if (event is EventRemoveTracker) {
      brain.remove(event.tracker);
    }
    if (event is EventSaveTracker) {
      brain.save();
    }
    if (event is EventSortTracker) {
      sortMethod = event.sortMethod;
    }

    yield StateTracker(
      trackerBrain: brain,
      sorted: brain.sort(sortMethod),
    );
  }
}
