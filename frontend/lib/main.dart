import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'bloc/story/story_bloc.dart';
import 'pages/story_form_page.dart';

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
      child: const ShadApp.material(
        title: 'AI Story Generator',
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: StoryFormPage(),
      ),
    );
  }
}
