import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:frontend/pages/story_form_page.dart';
import 'package:frontend/theme/colors.dart';
import 'package:frontend/widgets/book_image.dart';
import 'package:frontend/widgets/responsive_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/story/story_bloc.dart';
import '../bloc/story/story_event.dart';
import '../bloc/story/story_state.dart';
import '../models/story_response.dart';
import '../widgets/app_button.dart';

class StoryResultPage extends StatelessWidget {
  const StoryResultPage({super.key});

  void goBack(BuildContext context) {
    context.read<StoryBloc>().add(ResetStoryForm());
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const StoryFormPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appbarBg,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Your Story',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Create New Story',
            onPressed: () {
              goBack(context);
            },
          ),
        ],
      ),
      body: ResponsiveBuilder(
        maxWidth: 800,
        horizontalPadding: 16,
        child: BlocBuilder<StoryBloc, StoryState>(
          builder: (context, state) {
            return state is StoryGenerating
                ? _buildLoadingView()
                : state is StoryGenerated
                    ? _buildStoryView(context, state.story)
                    : state is StoryError
                        ? _buildErrorView(context, state.message)
                        : _buildErrorView(
                            context,
                            "Go back and generate a story first",
                          );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SpinKitWave(
            size: 50.0,
            color: Color(0xFF8E44AD), // Royal purple
          ),
          const SizedBox(height: 24),
          Text(
            'Creating Your Story',
            style: GoogleFonts.playfairDisplay(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2C3E50), // Deep navy blue
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Please wait while our AI crafts a unique story for you...',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF34495E), // Softer navy blue
              height: 1.5,
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
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2C3E50).withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Color(0xFFE74C3C), // European red
                size: 64,
              ),
              const SizedBox(height: 24),
              Text(
                'Oops! Something went wrong',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  height: 1.5,
                  color: const Color(0xFF34495E),
                ),
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Go Back',
                onPressed: () {
                  context.read<StoryBloc>().add(ResetStoryForm());
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const StoryFormPage()));
                },
                isFullWidth: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStoryView(BuildContext context, StoryResponse story) {
    // Calculate the first letter of the first paragraph for drop cap
    String firstLetter = '';
    String remainingText = '';
    if (story.contents.isNotEmpty) {
      String firstParagraph = story.contents.first.text;
      if (firstParagraph.isNotEmpty) {
        firstLetter = firstParagraph[0];
        remainingText = firstParagraph.substring(1);
      }
    }

    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(scrollbars: false),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Story title decoration with ornate divider
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.auto_stories,
                    color: Color(0xFF8E44AD),
                    size: 32,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 1,
                    width: 120,
                    color: const Color(0xFFBDC3C7),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Summary section styled as a classic book note
            Container(
              margin: const EdgeInsets.only(bottom: 40),
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFDF9),
                border: Border.all(color: const Color(0xFFECE0D1), width: 1),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 3),
                    blurRadius: 8,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Story Summary',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    story.summary,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      height: 1.7,
                      color: const Color(0xFF34495E),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),

            // Main story title with decorative element
            Center(
              child: Column(
                children: [
                  Text(
                    'Your Story',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 1,
                    width: 60,
                    color: const Color(0xFF8E44AD),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Story content with first letter styled as drop cap
            if (story.contents.isNotEmpty) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First paragraph with drop cap
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: firstLetter,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 56,
                            height: 0.8,
                            color: const Color(0xFF8E44AD),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: remainingText,
                          style: GoogleFonts.lora(
                            fontSize: 18,
                            height: 1.8,
                            color: const Color(0xFF2C3E50),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Display image for first paragraph if available
                  if (story.contents.first.imagePath != null &&
                      story.contents.first.imagePath!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                      child: Center(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 600,
                          ),
                          child: BookImage(
                            imagePath: story.contents.first.imageUrl,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 24),

              // Remaining paragraphs with images
              ...story.contents.skip(1).map((content) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Display image if available
                      if (content.imagePath != null &&
                          content.imagePath!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Center(
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 600,
                              ),
                              child: BookImage(
                                imagePath: content.imageUrl,
                              ),
                            ),
                          ),
                        ),
                      // Paragraph text
                      Text(
                        content.text,
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          height: 1.8,
                          color: const Color(0xFF2C3E50),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],

            // Footer decoration
            const SizedBox(height: 40),
            Center(
              child: Container(
                height: 1,
                width: 120,
                color: const Color(0xFFBDC3C7),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Icon(
                Icons.auto_stories,
                color: const Color(0xFF8E44AD).withOpacity(0.7),
                size: 24,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
