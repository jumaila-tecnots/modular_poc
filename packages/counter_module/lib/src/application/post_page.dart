
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:counter_module/src/application/postbloc/posts_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("PostApp using Bloc", style: themedata.textTheme.titleMedium),
        actions: [
          IconButton(
            onPressed: () {
              context.read<PostsBloc>().add(const PostsEvent.getPosts());
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
            Text("All Posts", style: themedata.textTheme.displayLarge),
            Expanded(
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.pink));
                  } else if (state.isSuccess) {

                    final filteredPosts = state.posts.where((post) => post.title.length > 10).toList();
                    return ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(child: Center(child: Text("${index + 1}"))),
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