import 'package:The_Friendly_Habit_Journal/TrackerBrain.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_event.dart';
import 'package:The_Friendly_Habit_Journal/bloc/tracker/tracker_state.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';
import 'package:bloc/bloc.dart';

class TrackerBloc extends Bloc<TrackerEvent, TrackerState> {
  TrackerBrain brain = new TrackerBrain([]);
  SortBy sortMethod = SortBy.DescPercentYes;
  String searchText = "";

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
      brain.updateDates();
    }
    if (event is EventTrackerAdd) {
      brain.add(event.toString());
      brain.updateDates();
    }
    if (event is EventTrackerRemove) {
      brain.remove(event.tracker);
      brain.updateDates();
    }
    if (event is EventTrackerSort) {
      sortMethod = event.sortMethod;
    }
    if (event is EventTrackerSearch) {
      searchText = event.searchText;
    }

    if (event is EventTrackerSave) {
      brain.save();
    } else {
      yield StateTracker(
        trackerBrain: brain,
        cards: _search(brain.sort(sortMethod)),
        numRemainingToday: brain.getReviewGame(DATE.Today).getNumCards(),
        numRemainingYesterday:
            brain.getReviewGame(DATE.Yesterday).getNumCards(),
      );
    }
  }

  List<Tracker> _search(List<Tracker> trackers) {
    return List.from(
        trackers.where((t) => t.title.toLowerCase().contains(searchText)));
  }
}
