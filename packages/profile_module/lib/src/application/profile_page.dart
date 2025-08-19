import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:profile_module/src/application/profilebloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title:
            Text("PostApp using Bloc", style: themedata.textTheme.titleMedium),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ProfileBloc>().add(const ProfileEvent.getProfile());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("All Profiles", style: themedata.textTheme.displayLarge),
            Expanded(
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.pink));
                  } else if (state.isSuccess) {
                    final filteredPosts = state.posts;
                    return ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                child: Center(child: Text("${index + 1}"))),
                            title: Text(filteredPosts[index].name),
                            subtitle: Text(filteredPosts[index].email),
                          ),
                        );
                      },
                    );
                  } else if (state.isError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("No posts available"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
