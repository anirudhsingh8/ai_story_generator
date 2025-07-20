import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../bloc/story/story_bloc.dart';
import '../bloc/story/story_event.dart';
import '../bloc/story/story_state.dart';
import '../models/story_response.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';

class StoryResultPage extends StatelessWidget {
  const StoryResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Story'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocBuilder<StoryBloc, StoryState>(
        builder: (context, state) {
          if (state is StoryGenerating) {
            return _buildLoadingView();
          } else if (state is StoryGenerated) {
            return _buildStoryView(context, state.story);
          } else if (state is StoryError) {
            return _buildErrorView(context, state.message);
          }

          return const Center(
            child: Text('Something went wrong. Please try again.'),
          );
        },
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitWave(
            color: AppTheme.teal,
            size: 50.0,
          ),
          const SizedBox(height: 24),
          const Text(
            'Creating Your Story',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGrey,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please wait while our AI crafts a unique story for you...',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.lightGrey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.redAccent,
              size: 64,
            ),
            const SizedBox(height: 24),
            const Text(
              'Oops! Something went wrong',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppTheme.lightGrey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: AppTheme.lightGrey,
              ),
            ),
            const SizedBox(height: 32),
            AppButton(
              text: 'Try Again',
              onPressed: () {
                context.read<StoryBloc>().add(ResetStoryForm());
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              isFullWidth: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryView(BuildContext context, StoryResponse story) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: AppTheme.teal,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Story Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    story.summary,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppTheme.darkNavy,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Story',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightGrey,
            ),
          ),
          const SizedBox(height: 16),
          ...story.contents.map((content) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.text,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: AppTheme.lightGrey,
                    ),
                  ),
                  if (content.imagePrompt != null) ...[
                    const SizedBox(height: 8),
                    Card(
                      color: AppTheme.darkGrey,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.image,
                                    color: AppTheme.teal, size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Image Prompt',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.teal,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              content.imagePrompt!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: AppTheme.lightGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 32),
          AppButton(
            text: 'Create Another Story',
            onPressed: () {
              context.read<StoryBloc>().add(ResetStoryForm());
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }
}
