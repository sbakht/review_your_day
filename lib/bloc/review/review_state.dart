import 'package:The_Friendly_Habit_Journal/data/ReviewGame.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class InitialReviewState extends ReviewState {
  final ReviewGame game;

  InitialReviewState({this.game});

  @override
  List<Object> get props => [];
}

class ReviewingState extends ReviewState {
  final ReviewGame game;

  ReviewingState({this.game});

  @override
  List<Object> get props => [];
}
