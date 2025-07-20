// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../bloc/story/story_bloc.dart';
import '../bloc/story/story_event.dart';
import '../bloc/story/story_state.dart';
import '../constants/genre_options.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';
import '../widgets/character_name_input.dart';

class StoryFormPage extends StatefulWidget {
  const StoryFormPage({super.key});

  @override
  State<StoryFormPage> createState() => _StoryFormPageState();
}

class _StoryFormPageState extends State<StoryFormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
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
      appBar: AppBar(
        title: const Text('Create Your Story'),
        centerTitle: true,
      ),
      body: BlocConsumer<StoryBloc, StoryState>(
        listener: (context, state) {
          if (state is StoryFormValidated) {
            Navigator.of(context).pushNamed('/preview');
          } else if (state is StoryError) {
            _showErrorSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: FormBuilder(
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
            color: AppTheme.lightGrey,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Fill in the details below to generate a unique story tailored to your preferences.',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.lightGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildGenreSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Genre',
          style: AppTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 12),
        FormBuilderDropdown(
          name: 'genre',
          decoration: const InputDecoration(
            hintText: 'Select a genre',
          ),
          validator: FormBuilderValidators.required(),
          items: GenreOptions.predefinedGenres.map((genre) {
            return DropdownMenuItem(
              value: genre,
              child: Text(genre),
            );
          }).toList(),
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
        if (_isOtherGenre) ...[
          const SizedBox(height: 16),
          FormBuilderTextField(
            name: 'customGenre',
            controller: _genreController,
            decoration: const InputDecoration(
              hintText: 'Enter custom genre',
              labelText: 'Custom Genre',
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.minLength(3),
            ]),
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                context.read<StoryBloc>().add(UpdateGenre(value));
              }
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
        Text(
          'Characters',
          style: AppTheme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        const Card(
          margin: EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: AppTheme.teal),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'You can specify either the number of characters or provide character names. If both are provided, names will be prioritized.',
                    style: TextStyle(color: AppTheme.lightGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
        FormBuilderTextField(
          name: 'numberOfCharacters',
          decoration: const InputDecoration(
            labelText: 'Number of Characters (Optional)',
            hintText: 'Enter a number',
          ),
          keyboardType: TextInputType.number,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.numeric(),
            FormBuilderValidators.min(1),
          ]),
          onChanged: (value) {
            if (value != null && value.isNotEmpty) {
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
        Text(
          'Number of Paragraphs',
          style: AppTheme.textTheme.bodyLarge,
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
                color: AppTheme.teal,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${int.tryParse(value)}',
                style: const TextStyle(
                    color: AppTheme.darkNavy, fontWeight: FontWeight.bold),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade300,
      ),
    );
  }
}
