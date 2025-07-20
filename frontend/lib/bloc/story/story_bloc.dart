import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/story_request.dart';
import '../../services/story_service.dart';
import 'story_event.dart';
import 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryService _storyService = StoryService();

  // Form data
  String _genre = '';
  int? _numberOfCharacters;
  List<String>? _nameOfCharacters;
  int _paragraphs = 2;
  bool _generateImages = false;

  StoryBloc() : super(StoryFormInitial()) {
    on<UpdateGenre>(_onUpdateGenre);
    on<UpdateNumberOfCharacters>(_onUpdateNumberOfCharacters);
    on<UpdateCharacterNames>(_onUpdateCharacterNames);
    on<UpdateParagraphs>(_onUpdateParagraphs);
    on<ValidateStoryForm>(_onValidateStoryForm);
    on<GenerateStory>(_onGenerateStory);
    on<EditStoryForm>(_onEditStoryForm);
    on<ResetStoryForm>(_onResetStoryForm);
  }

  void _onUpdateGenre(UpdateGenre event, Emitter<StoryState> emit) {
    _genre = event.genre;
  }

  void _onUpdateNumberOfCharacters(
      UpdateNumberOfCharacters event, Emitter<StoryState> emit) {
    _numberOfCharacters = event.numberOfCharacters;
  }

  void _onUpdateCharacterNames(
      UpdateCharacterNames event, Emitter<StoryState> emit) {
    _nameOfCharacters = event.characterNames;
  }

  void _onUpdateParagraphs(UpdateParagraphs event, Emitter<StoryState> emit) {
    _paragraphs = event.paragraphs;
  }

  void _onValidateStoryForm(ValidateStoryForm event, Emitter<StoryState> emit) {
    if (_isFormValid()) {
      final request = StoryRequest(
        genre: _genre,
        numberOfCharacters:
            _nameOfCharacters != null ? null : _numberOfCharacters,
        nameOfCharacters: _nameOfCharacters,
        paragraphs: _paragraphs,
        generateImages: _generateImages,
      );
      emit(StoryFormValidated(request));
    } else {
      emit(const StoryError('Please fill in all required fields'));
    }
  }

  void _onGenerateStory(GenerateStory event, Emitter<StoryState> emit) async {
    if (state is StoryFormValidated) {
      final request = (state as StoryFormValidated).request;
      emit(StoryGenerating());

      try {
        final storyResponse = await _storyService.generateStory(request);
        emit(StoryGenerated(storyResponse));
      } catch (e) {
        emit(StoryError(e.toString()));
      }
    }
  }

  void _onEditStoryForm(EditStoryForm event, Emitter<StoryState> emit) {
    emit(StoryFormInitial());
  }

  void _onResetStoryForm(ResetStoryForm event, Emitter<StoryState> emit) {
    _genre = '';
    _numberOfCharacters = null;
    _nameOfCharacters = null;
    _paragraphs = 2;
    _generateImages = false;
    emit(StoryFormInitial());
  }

  bool _isFormValid() {
    // Genre is the only required field
    return _genre.isNotEmpty && _genre.length >= 3;
  }
}
