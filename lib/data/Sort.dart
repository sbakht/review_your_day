import 'package:The_Friendly_Habit_Journal/data/Percentage.dart';
import 'package:The_Friendly_Habit_Journal/data/Tracker.dart';
import 'package:The_Friendly_Habit_Journal/data/Trackers.dart';
import 'package:The_Friendly_Habit_Journal/enums.dart';

class Sort {
  Trackers trackers;

  Sort(this.trackers);

  List<Tracker> sort(SortBy sortMethod) {
    //TODO: move to its own sorter class
    List<Tracker> result = trackers.getNotArchived();
    result.sort((Tracker a, Tracker b) {
      Percentage pa = new Percentage(a);
      Percentage pb = new Percentage(b);
      if (sortMethod == SortBy.DescPercentYes) {
        return pb
            .getPercentYesExclusive()
            .compareTo(pa.getPercentYesExclusive());
      } else if (sortMethod == SortBy.DescPercentNo) {
        return pb.getPercentNoExclusive().compareTo(pa.getPercentNoExclusive());
      } else if (sortMethod == SortBy.DescCountYes) {
        return b.getNumYes().compareTo(a.getNumYes());
      } else if (sortMethod == SortBy.DescCountNo) {
        return b.getNumNo().compareTo(a.getNumNo());
      }
      return pb.getPercentYesExclusive().compareTo(pa.getPercentNoExclusive());
    });
    return result;
  }
}
