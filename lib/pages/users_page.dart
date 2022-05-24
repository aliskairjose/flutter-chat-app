import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/models.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  final users = [
    User(uid: '1', name: 'Kervin', email: 'kervingonzalez@gmail.com', online: false),
    User(uid: '2', name: 'Marianela', email: 'nela@hotmail.com', online: true),
    User(uid: '3', name: 'Velifer', email: 'revevi@gmail.com', online: true),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi nombre', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app_outlined, color: Colors.black87),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            // child: Icon(Icons.check_circle_outline, color: Colors.blue.shade400),
            child: Icon(Icons.offline_bolt_outlined, color: Colors.red.shade400),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue.shade400),
          waterDropColor: Colors.blue.shade400,
        ),
        child: _usersLlistView(),
      ),
    );
  }

  ListView _usersLlistView() {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: users.length,
      separatorBuilder: (_, i) => const Divider(),
      itemBuilder: (_, i) => _userListTile(users[i]),
    );
  }

  ListTile _userListTile(User user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.blue.shade100,
        child: Text(user.name.substring(0, 2).toUpperCase()),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: user.online ? Colors.green.shade300 : Colors.red.shade300,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  void _loadUsers() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _refreshController.refreshCompleted();
  }
}
