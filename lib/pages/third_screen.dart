import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc/user_bloc.dart';
import 'package:flutter_application_1/bloc/user_event.dart';
import 'package:flutter_application_1/bloc/user_state.dart';
import 'package:flutter_application_1/components/my_appbar.dart';
import 'package:flutter_application_1/pages/second_screen.dart';
import 'package:flutter_application_1/provider/selected_user_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late UserBloc _userBloc;
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 10;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _userBloc = UserBloc()..add(FetchUsers(page: 1, perPage: _perPage));
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final state = _userBloc.state;
      if (state is UserLoaded &&
          !_isFetchingMore &&
          state.currentPage < state.totalPages) {
        setState(() {
          _isFetchingMore = true;
        });
        _userBloc
            .add(FetchUsers(page: state.currentPage + 1, perPage: _perPage));
      }
    }
  }

  Future<void> _onRefresh() async {
    _userBloc.add(FetchUsers(page: 1, perPage: _perPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppbar(title: "Third Screen"),
      body: BlocProvider(
        create: (context) => _userBloc,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading && state.currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoading) {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final user = state.users[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Text(
                              user.email,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            leading: FittedBox(
                              fit: BoxFit.cover,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar),
                                radius: 49,
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<SelectedUserProvider>()
                                  .selectUser(user);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SecondScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          thickness: 0.1,
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (state is UserLoaded) {
              if (state.users.isEmpty) {
                return Center(child: Text('No users available.'));
              }
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: state.users.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.users.length) {
                      return state.currentPage < state.totalPages
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink();
                    }
                    final user = state.users[index];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                            title: Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                            ),
                            subtitle: Text(
                              user.email,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10.0,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            leading: FittedBox(
                              fit: BoxFit.cover,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar),
                                radius: 49,
                              ),
                            ),
                            onTap: () {
                              context
                                  .read<SelectedUserProvider>()
                                  .selectUser(user);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SecondScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                        const Divider(
                          thickness: 0.1,
                        ),
                      ],
                    );
                  },
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            } else {
              return const Placeholder();
            }
          },
        ),
      ),
    );
  }
}
