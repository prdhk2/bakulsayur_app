import 'package:flutter/material.dart';
import '../components/floating-bottom-nav.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentPageNav = 3;

  void _onItemTapped(int index) {
    setState(() {
      _currentPageNav = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/favorite');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/cart');
        break;
      case 3:
        break; // Tetap di halaman Profile
    }
  }

  Widget iconCircle(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.blue[800]),
    );
  }

  Widget buildProfileMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: iconCircle(icon),
          title: Text(title),
          onTap: onTap,
        ),
        const Divider(
          height: 20,
          thickness: 0.5,
          color: Color.fromARGB(255, 198, 198, 198),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo,',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Big Boss !!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Thank you for supporting us!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'As a local business, we thank you for supporting us and hope you enjoy.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                buildProfileMenuItem(
                  icon: Icons.person,
                  title: 'Edit Profile',
                  onTap: () => Navigator.pushNamed(context, '/edit-profile'),
                ),
                buildProfileMenuItem(
                  icon: Icons.lock,
                  title: 'Password Settings',
                  onTap: () =>
                      Navigator.pushNamed(context, '/password-settings'),
                ),
                buildProfileMenuItem(
                  icon: Icons.email,
                  title: 'Contact Us',
                  onTap: () => Navigator.pushNamed(context, '/contact'),
                ),
                buildProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Support Center',
                  onTap: () => Navigator.pushNamed(context, '/support'),
                ),
                buildProfileMenuItem(
                  icon: Icons.share,
                  title: 'Share MealPlanner App',
                  onTap: () {
                    // Implementasi berbagi aplikasi
                  },
                ),
                buildProfileMenuItem(
                  icon: Icons.star,
                  title: 'Review In the App Store',
                  onTap: () {
                    // Implementasi untuk review aplikasi
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentPageNav,
        onTap: _onItemTapped,
      ),
    );
  }
}
