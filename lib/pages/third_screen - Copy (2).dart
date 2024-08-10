// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/bloc/user_bloc.dart';
// import 'package:flutter_application_1/bloc/user_event.dart';
// import 'package:flutter_application_1/bloc/user_state.dart';
// import 'package:flutter_application_1/components/my_appbar.dart';
// import 'package:flutter_application_1/pages/second_screen.dart';
// import 'package:flutter_application_1/provider/selected_user_provider.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ThirdScreen extends StatelessWidget {
//   const ThirdScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const MyAppbar(title: "Third Screen"),
//       body: BlocProvider(
//         create: (context) => UserBloc()..add(FetchUsers()),
//         child: BlocBuilder<UserBloc, UserState>(
//           builder: (context, state) {
//             if (state is UserLoading) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (state is UserLoaded) {
//               return Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: ListView.builder(
//                   itemCount: state.users.length,
//                   itemBuilder: (context, index) {
//                     final user = state.users[index];
//                     return Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 10.0),
//                           child: ListTile(
//                             title: Text(
//                               '${user.firstName} ${user.lastName}',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 16.0,
//                               ),
//                             ),
//                             subtitle: Text(
//                               user.email,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 10.0,
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                             ),
//                             leading: FittedBox(
//                               fit: BoxFit.cover,
//                               child: CircleAvatar(
//                                 backgroundImage: NetworkImage(user.avatar),
//                                 radius: 49,
//                               ),
//                             ),
//                             onTap: () {
//                               context
//                                   .read<SelectedUserProvider>()
//                                   .selectUser(user);
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const SecondScreen(),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const Divider(
//                           thickness: 0.1,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             } else if (state is UserError) {
//               return Center(child: Text(state.message));
//             } else {
//               return const Placeholder();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
