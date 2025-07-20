import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/pages/story_result_page.dart';
import 'package:frontend/theme/colors.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../bloc/story/story_bloc.dart';
import '../bloc/story/story_event.dart';
import '../bloc/story/story_state.dart';
import '../models/story_request.dart';
import '../widgets/responsive_builder.dart';

Future<void> showPreviewDialog(BuildContext context) async {
  showShadDialog(
    context: context,
    builder: (context) => ShadDialog(
      backgroundColor: AppColors.background,
      title: const Text('Review Your Story Settings'),
      description: const Text(
        "Please confirm these details before we generate your story.",
      ),
      actions: [
        ShadButton(
          onPressed: () {
            context.read<StoryBloc>().add(EditStoryForm());
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
        ShadButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<StoryBloc>().add(GenerateStory());
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const StoryResultPage()));
          },
          child: const Text('Generate Story'),
        )
      ],
      child: Container(
        width: 375,
        color: AppColors.background,
        constraints: const BoxConstraints(maxHeight: 500),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: const StoryPreviewPage(),
      ),
    ),
  );
}

class StoryPreviewPage extends StatelessWidget {
  const StoryPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<StoryBloc, StoryState>(
        builder: (context, state) {
          return ResponsiveBuilder(
            horizontalPadding: 0,
            child: state is StoryFormValidated
                ? _buildPreviewContent(context, state.request)
                : const Center(
                    child: Text(
                        'Something went wrong. Please go back and try again.'),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildPreviewContent(BuildContext context, StoryRequest request) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoCard(
              title: 'Genre',
              content: request.genre,
              icon: Icons.category,
            ),
            const SizedBox(height: 16),
            if (request.nameOfCharacters != null &&
                request.nameOfCharacters!.isNotEmpty)
              _buildCharacterNamesCard(request.nameOfCharacters!)
            else if (request.numberOfCharacters != null)
              _buildInfoCard(
                title: 'Number of Characters',
                content: request.numberOfCharacters.toString(),
                icon: Icons.people,
              )
            else
              _buildInfoCard(
                title: 'Characters',
                content: 'Default characters will be used',
                icon: Icons.people,
              ),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: 'Paragraphs',
              content: request.paragraphs.toString(),
              icon: Icons.text_fields,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      {required String title,
      required String content,
      required IconData icon}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharacterNamesCard(List<String> names) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.people, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Characters',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...names
                      .map((name) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
