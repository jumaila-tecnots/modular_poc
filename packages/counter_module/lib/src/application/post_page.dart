import 'package:counter_module/src/application/postbloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
//import 'package:counter_module/core/utils/theme_service.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('ThemeServiceProvider available in PostPage:');
    final themedata = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PostApp using Bloc",
          style: themedata.textTheme.titleMedium,
        ),
        actions: [
          // Switch(
          //   activeColor: Colors.green,
          //   trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
          //   value: Provider.of<ThemeServiceProvider>(context).isDarkModeOn,
          //   inactiveTrackColor: Colors.blueGrey,
          //   inactiveThumbColor: Colors.black87,
          //   onChanged: (_) {
          //     Provider.of<ThemeServiceProvider>(context, listen: false).toggleTheme();
          //   },
          // ),
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
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.pink,
                      ),
                    );
                  } else if (state.isSuccess) {
                    return ListView.builder(
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Center(
                                child: Text("${index + 1}"),
                              ),
                            ),
                            title: Text(state.posts[index].title),
                            subtitle: Text(state.posts[index].body),
                          ),
                        );
                      },
                    );
                  } else if (state.isError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return const Center(
                    child: Text("No posts available"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}