import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc/auth_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://yt3.ggpht.com/ytc/AMLnZu_R_hG8ECmXhQKgKOvNboKgS6x6YHgLa09z90prDJMc7YSiuQAMeFsbqHakExzr=s88-c-k-c0x00ffffff-no-rj-mo"),
          ),
        ),
        title: const Text("AUTH WITH REST"),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LoggedOut());
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: const Center(
        child: Text("Main Screen"),
      ),
    );
  }
}
