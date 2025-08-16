import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/src/presentation/bloc/users_cubit.dart';

import 'bloc/users_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  late UsersCubit _usersCubit;

  @override
  void initState() {
    _usersCubit = context.read<UsersCubit>();
    _usersCubit.fetchUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersCubit, UsersState>(
        builder: (context, state) {
          switch (state) {
            case InitialState():
              return const Center(child: CircularProgressIndicator());
            case LoadingState():
              return const Center(child: CircularProgressIndicator());
            case SuccessState():
              return _buildBody(state);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildBody(SuccessState state) {
    return ListView.builder(
      itemBuilder: (ctx, idx) {
        final user = state.users[idx];
        return ListTile(
          title: Text(user.name),
          subtitle: Text(user.email),
        );
      },
    );
  }
}
