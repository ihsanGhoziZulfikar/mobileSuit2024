// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/bloc/user_bloc.dart';
// import 'package:flutter_application_1/bloc/user_event.dart';
// import 'package:flutter_application_1/bloc/user_state.dart';
// import 'package:flutter_application_1/components/my_appbar.dart';
// import 'package:flutter_application_1/pages/second_screen.dart';
// import 'package:flutter_application_1/provider/selected_user_provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// // class ThirdScreen extends StatelessWidget {
// //   const ThirdScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: const MyAppbar(title: "Third Screen"),
// //       body: BlocProvider(
// //         create: (context) => UserBloc()..add(FetchUsers()),
// //         child: BlocBuilder<UserBloc, UserState>(
// //           builder: (context, state) {
// //             if (state is UserLoading &&
// //                 (context.read<UserBloc>().currentPage == 1)) {
// //               return const Center(child: CircularProgressIndicator());
// //             } else if (state is UserLoaded) {
// //               return RefreshIndicator(
// //                 onRefresh: () async {
// //                   context.read<UserBloc>().users.clear();
// //                   context.read<UserBloc>().add(FetchUsers(page: 1));
// //                 },
// //                 child: state.users.isEmpty
// //                     ? const Center(child: Text('No users found'))
// //                     : NotificationListener<ScrollNotification>(
// //                         onNotification: (ScrollNotification scrollInfo) {
// //                           if (scrollInfo.metrics.pixels ==
// //                               scrollInfo.metrics.maxScrollExtent) {
// //                             context.read<UserBloc>().add(FetchUsers(
// //                                 page:
// //                                     context.read<UserBloc>().currentPage + 1));
// //                           }
// //                           return true;
// //                         },
// //                         child: Padding(
// //                           padding: const EdgeInsets.all(20.0),
// //                           child: ListView.builder(
// //                             itemCount: state.users.length,
// //                             itemBuilder: (context, index) {
// //                               final user = state.users[index];
// //                               return Column(
// //                                 children: [
// //                                   Padding(
// //                                     padding: const EdgeInsets.symmetric(
// //                                         vertical: 10.0),
// //                                     child: ListTile(
// //                                       title: Text(
// //                                         '${user.firstName} ${user.lastName}',
// //                                         style: const TextStyle(
// //                                           fontWeight: FontWeight.w500,
// //                                           fontSize: 16.0,
// //                                         ),
// //                                       ),
// //                                       subtitle: Text(
// //                                         user.email,
// //                                         style: TextStyle(
// //                                           fontWeight: FontWeight.w500,
// //                                           fontSize: 10.0,
// //                                           color: Theme.of(context)
// //                                               .colorScheme
// //                                               .secondary,
// //                                         ),
// //                                       ),
// //                                       leading: FittedBox(
// //                                         fit: BoxFit.cover,
// //                                         child: CircleAvatar(
// //                                           backgroundImage:
// //                                               NetworkImage(user.avatar),
// //                                           radius: 49,
// //                                         ),
// //                                       ),
// //                                       onTap: () {
// //                                         context
// //                                             .read<SelectedUserProvider>()
// //                                             .selectUser(user);
// //                                         Navigator.push(
// //                                           context,
// //                                           MaterialPageRoute(
// //                                             builder: (context) =>
// //                                                 const SecondScreen(),
// //                                           ),
// //                                         );
// //                                       },
// //                                     ),
// //                                   ),
// //                                   const Divider(
// //                                     thickness: 0.1,
// //                                   ),
// //                                 ],
// //                               );
// //                             },
// //                           ),
// //                         ),
// //                       ),
// //               );
// //             } else if (state is UserError) {
// //               return Center(child: Text(state.message));
// //             } else {
// //               return const Placeholder();
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }

// class ThirdScreen extends StatelessWidget {
//   const ThirdScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppbar(title: "Third Screen"),
//       body: BlocBuilder<UserBloc, UserState>(
//         builder: (context, state) {
//           if (state is UserInitial) {
//             context.read<UserBloc>().add(FetchUsers(perPage: 10));
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is UserLoaded) {
//             if (state.users.isEmpty) {
//               return const Center(child: Text('No Users Found'));
//             }
//             return RefreshIndicator(
//               onRefresh: () async {
//                 context.read<UserBloc>().add(FetchUsers(perPage: 10));
//               },
//               child: ListView.builder(
//                 itemCount: state.hasReachedMax
//                     ? state.users.length
//                     : state.users.length + 1,
//                 itemBuilder: (context, index) {
//                   if (index >= state.users.length) {
//                     context.read<UserBloc>().add(FetchUsers(perPage: 10));
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   final user = state.users[index];
//                   return ListTile(
//                     title: Text('${user.firstName} ${user.lastName}'),
//                     subtitle: Text(user.email),
//                     leading: Image.network(user.avatar),
//                     onTap: () {
//                       context.read<SelectedUserProvider>().selectUser(user);
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SecondScreen(),
//                         ),
//                       );
//                       // Set the selected user
//                     },
//                   );
//                 },
//               ),
//             );
//           } else if (state is UserError) {
//             return Center(child: Text(state.message));
//           } else {
//             return const Center(child: Text('Unknown State'));
//           }
//         },
//       ),
//     );
//   }
// }
