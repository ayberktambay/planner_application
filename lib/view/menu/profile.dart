import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:planner/view/auth/login.dart';
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? _creationTime;
  String? _userDisplayName;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.metadata.creationTime != null) {
        _creationTime = user.metadata.creationTime!.toLocal().toString();
        _userDisplayName = user.displayName.toString();
      setState(() {});
    } else {
      setState(() {
        _creationTime = 'Bilgi alınamadı.';
      });
    }
  }
   Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Tekrar hoş geldiniz, $_userDisplayName",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Profil Bilgileri",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Hesap Oluşturulma Zamanı: ${_creationTime ?? "Yükleniyor..."}',
                style: const TextStyle(fontSize: 14),
              ),
            ),
            ElevatedButton(

            onPressed: _logout,
            child: Row(
              children: [
                Icon(Icons.logout),
                SizedBox(width: 8),
                Text("Logout",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16))
              ],
            ))
          ],
        ),
      ),
    );
  }
}