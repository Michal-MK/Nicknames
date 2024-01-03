import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicknames_flutter/board.dart';
import 'package:nicknames_flutter/cubit/board_cubit.dart';
import 'package:nicknames_flutter/main_drawer.dart';
import 'package:window_manager/window_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  windowManager.setAlwaysOnTop(true);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return MaterialApp(
      home: BlocProvider(
        create: (context) => BoardCubit()..loadBoard(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              key: scaffoldKey,
              drawer: const MainDrawer(),
              body: Stack(
                children: [
                  Positioned.fill(
                    child: BlocBuilder<BoardCubit, BoardState>(
                      builder: (context, state) {
                        if (state is BoardLoaded) {
                          return Board(words: state.words);
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                  Positioned(
                    top: 2,
                    left: 2,
                    child: IconButton(
                      icon: const Icon(Icons.menu),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.amber.withOpacity(0.5),
                        ),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      iconSize: 48,
                      onPressed: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
