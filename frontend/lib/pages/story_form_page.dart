// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:frontend/pages/story_preview_page.dart';
import 'package:frontend/theme/colors.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../bloc/story/story_bloc.dart';
import '../bloc/story/story_event.dart';
import '../bloc/story/story_state.dart';
import '../constants/genre_options.dart';
import '../widgets/app_button.dart';
import '../widgets/character_name_input.dart';
import '../widgets/responsive_builder.dart';

class StoryFormPage extends StatefulWidget {
  const StoryFormPage({super.key});

  @override
  State<StoryFormPage> createState() => _StoryFormPageState();
}

class _StoryFormPageState extends State<StoryFormPage> {
  final _formKey = GlobalKey<ShadFormState>();
  final _genreController = TextEditingController();
  final _paragraphsController = TextEditingController(text: '2');
  String _selectedGenre = '';
  int? _numberOfCharacters;
  List<String> _characterNames = [];
  bool _isOtherGenre = false;

  @override
  void initState() {
    super.initState();
    _paragraphsController.text = '2';
  }

  @override
  void dispose() {
    _genreController.dispose();
    _paragraphsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<StoryBloc, StoryState>(
        listener: (context, state) async {
          if (state is StoryFormValidated) {
            await showPreviewDialog(context);
          } else if (state is StoryError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return ResponsiveBuilder(
            child: SingleChildScrollView(
              child: ShadForm(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildIntroSection(),
                    const SizedBox(height: 32),
                    _buildGenreSection(),
                    const SizedBox(height: 24),
                    _buildCharactersSection(),
                    const SizedBox(height: 24),
                    _buildParagraphsSection(),
                    const SizedBox(height: 32),
                    AppButton(
                      text: 'Preview Story',
                      onPressed: _submitForm,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIntroSection() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Craft Your AI Story',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Fill in the details below to generate a unique story tailored to your preferences.',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Select Genre'),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 180),
          child: ShadSelectFormField<String>(
            placeholder: const Text('Select a genre'),
            options: [
              ...GenreOptions.predefinedGenres
                  .map((e) => ShadOption(value: e, child: Text(e))),
            ],
            selectedOptionBuilder: (context, value) => Text(value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a genre';
              }
              return null;
            },
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedGenre = value;
                  _isOtherGenre = value == 'Other';
                  if (!_isOtherGenre) {
                    context.read<StoryBloc>().add(UpdateGenre(value));
                  }
                });
              }
            },
          ),
        ),
        if (_isOtherGenre) ...[
          const SizedBox(height: 16),
          ShadInputFormField(
            placeholder: const Text('Enter custom genre'),
            controller: _genreController,
            validator: (_) {
              if (_genreController.text.isEmpty) {
                return 'Please enter a genre';
              }
              return null;
            },
            onChanged: (value) {
              context.read<StoryBloc>().add(UpdateGenre(value));
            },
          ),
        ],
      ],
    );
  }

  Widget _buildCharactersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Characters',
        ),
        const SizedBox(height: 8),
        const ShadAlert(
          icon: Icon(Icons.info_outline),
          description: Text(
              'You can specify either the number of characters or provide character names. If both are provided, names will be prioritized.'),
        ),
        ShadInputFormField(
          placeholder: const Text('Number of Characters (Optional)'),
          keyboardType: TextInputType.number,
          validator: (val) {
            if (val.isNotEmpty) {
              final number = int.tryParse(val);
              if (number == null || number <= 0) {
                return 'Please enter a valid number';
              }
            }
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) {
              final number = int.tryParse(value);
              setState(() {
                _numberOfCharacters = number;
              });
              context.read<StoryBloc>().add(UpdateNumberOfCharacters(number));
            } else {
              context
                  .read<StoryBloc>()
                  .add(const UpdateNumberOfCharacters(null));
            }
          },
        ),
        const SizedBox(height: 16),
        CharacterNameInput(
          names: _characterNames,
          onChanged: (names) {
            setState(() {
              _characterNames = names;
            });
            context.read<StoryBloc>().add(UpdateCharacterNames(names));
          },
        ),
      ],
    );
  }

  Widget _buildParagraphsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Number of Paragraphs',
        ),
        const SizedBox(height: 8),
        FormBuilderSlider(
          name: 'paragraphs',
          min: 1,
          max: 10,
          initialValue: 2.0,
          divisions: 9,
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          valueWidget: (value) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${int.tryParse(value)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
          onChanged: (value) {
            if (value != null) {
              int paragraphs = value.toInt();
              _paragraphsController.text = paragraphs.toString();
              context.read<StoryBloc>().add(UpdateParagraphs(paragraphs));
            }
          },
        ),
      ],
    );
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.saveAndValidate() ?? false;

    if (isValid) {
      // If custom genre is selected, use the text from controller
      if (_isOtherGenre && _genreController.text.isNotEmpty) {
        context.read<StoryBloc>().add(UpdateGenre(_genreController.text));
      }

      // Validate the form with BLoC
      context.read<StoryBloc>().add(ValidateStoryForm());
    }
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        description: Text(message),
      ),
    );
  }
}
