import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class StateReviewLoading extends ReviewState {
  final ReviewGame game;

  StateReviewLoading({this.game});

  @override
  List<Object> get props => [];
}

class StateReviewing extends ReviewState {
  final ReviewGame game;

  StateReviewing({this.game});

  @override
  List<Object> get props => [];
}

class StateReviewFinished extends ReviewState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
