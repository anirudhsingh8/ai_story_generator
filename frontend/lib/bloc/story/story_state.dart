import 'package:equatable/equatable.dart';
import 'package:frontend/models/story_request.dart';
import 'package:frontend/models/story_response.dart';

// Base class for all states
abstract class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object?> get props => [];
}

// Initial form state
class StoryFormInitial extends StoryState {}

// Form validation state
class StoryFormValidated extends StoryState {
  final StoryRequest request;

  const StoryFormValidated(this.request);

  @override
  List<Object?> get props => [request];
}

// Loading state while API call is happening
class StoryGenerating extends StoryState {}

// Success state with generated story
class StoryGenerated extends StoryState {
  final StoryResponse story;

  const StoryGenerated(this.story);

  @override
  List<Object> get props => [story];
}

// Error state
class StoryError extends StoryState {
  final String message;

  const StoryError(this.message);

  @override
  List<Object> get props => [message];
}
