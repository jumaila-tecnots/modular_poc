import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Users',
          style: themedata.textTheme.titleMedium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<UserProfileBloc>()
                  .add(const UserProfileEvent.getUserProfiles());
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
            Text("All Users", style: themedata.textTheme.displayLarge),
            Expanded(
              child: BlocBuilder<UserProfilesBloc, UserProfilesState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(color: Colors.pink));
                  } else if (state.isSuccess) {
                    final filteredPosts = state.posts
                        .where((post) => post.title.length > 10)
                        .toList();
                    return ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                                child: Center(child: Text("${index + 1}"))),
                            title: Text(filteredPosts[index].title),
                            subtitle: Text(filteredPosts[index].body),
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
