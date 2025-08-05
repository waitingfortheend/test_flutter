import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_diversition/generated/locales.g.dart';
import 'package:test_diversition/models/user_model.dart';
import 'package:test_diversition/screens/users/user_form_screen.dart';
import 'package:test_diversition/services/user_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Future<List<User>> _usersFuture;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _usersFuture = _userService.getUsers();
  }

  Future<void> _refreshUsers() async {
    setState(() {
      _usersFuture = _userService.getUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.users.tr),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _refreshUsers),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No users found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImage ?? ''),
                    ),
                    title: Text(
                      '${LocaleKeys.user_name.tr} : ${user.firstName} ${user.lastName}',
                    ),
                    subtitle: Text(user.email ?? 'No email'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await Get.to(
                              () => const UserFormScreen(),
                              arguments: user,
                            );
                            _refreshUsers();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirmDelete = await showDialog<bool>(
                              context: context,
                              builder:
                                  (ctx) => AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: Text(
                                      'Are you sure you want to delete ${user.firstName}?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(ctx).pop(false),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(ctx).pop(true),
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  ),
                            );

                            if (confirmDelete == true && user.userId != null) {
                              try {
                                await _userService.deleteUser(user.userId!);
                                _refreshUsers();
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('User deleted successfully!'),
                                  ),
                                );
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to delete user: $e'),
                                  ),
                                );
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
