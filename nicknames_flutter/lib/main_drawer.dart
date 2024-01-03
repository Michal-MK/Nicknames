import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nicknames_flutter/cubit/board_cubit.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BoardCubit boardCubit = context.read<BoardCubit>();
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "'Nicknames'",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          ListTile(
            title: const Text("New game"),
            onTap: () {
              Navigator.pop(context);
              boardCubit.loadBoard();
            },
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
