import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bloc/story/story_bloc.dart';
import 'pages/story_form_page.dart';
import 'pages/story_preview_page.dart';
import 'pages/story_result_page.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StoryBloc>(
          create: (context) => StoryBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'AI Story Generator',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const StoryFormPage(),
          '/preview': (context) => const StoryPreviewPage(),
          '/result': (context) => const StoryResultPage(),
        },
      ),
    );
  }
}
