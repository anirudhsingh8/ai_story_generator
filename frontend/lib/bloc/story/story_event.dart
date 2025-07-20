import 'package:equatable/equatable.dart';

// Events triggered by user actions
abstract class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object?> get props => [];
}

// Event for updating genre
class UpdateGenre extends StoryEvent {
  final String genre;

  const UpdateGenre(this.genre);

  @override
  List<Object> get props => [genre];
}

// Event for updating number of characters
class UpdateNumberOfCharacters extends StoryEvent {
  final int? numberOfCharacters;

  const UpdateNumberOfCharacters(this.numberOfCharacters);

  @override
  List<Object?> get props => [numberOfCharacters];
}

// Event for updating character names
class UpdateCharacterNames extends StoryEvent {
  final List<String> characterNames;

  const UpdateCharacterNames(this.characterNames);

  @override
  List<Object> get props => [characterNames];
}

// Event for updating number of paragraphs
class UpdateParagraphs extends StoryEvent {
  final int paragraphs;

  const UpdateParagraphs(this.paragraphs);

  @override
  List<Object> get props => [paragraphs];
}

// Event to validate the form before preview
class ValidateStoryForm extends StoryEvent {}

// Event to generate the story after preview confirmation
class GenerateStory extends StoryEvent {}

// Event to go back to edit the form from the preview
class EditStoryForm extends StoryEvent {}

// Event to reset the state
class ResetStoryForm extends StoryEvent {}
