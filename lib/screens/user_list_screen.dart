import 'package:flutter/material.dart';
import 'package:flutter_frontend/providers/user_provider.dart';
import 'package:flutter_frontend/screens/add_user_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Users List")),
      body: usersAsync.when(
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text("${user.email} (${user.age})"),
            );
          },
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddUserScreen()),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
