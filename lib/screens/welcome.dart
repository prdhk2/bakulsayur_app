import 'package:flutter/material.dart';
import 'login.dart'; // Impor LoginScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Image.asset(
              'assets/images/welcome.png', // Pastikan gambar berada di folder assets
              width: 200,
              height: 200,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.grey,
                ); // Tampilkan ikon jika gambar tidak ditemukan
              },
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Bakul',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(
                  text: 'Sayur',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: 10), // Jarak antara "BakulSayur" dan teks di bawahnya
          const Text(
            'Dengan aplikasi ini, belanja sayur kini lebih praktis',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center, // Teks diatur ke tengah
          ),
          const Spacer(),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16), // Memberikan padding horizontal
        child: SizedBox(
          width: 250, // Lebar tombol mengisi layar
          child: ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman login
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                  vertical: 16), // Mengurangi ketinggian tombol
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(30), // Membuat tombol lebih rounded
              ),
              backgroundColor: Colors.blue, // Warna latar belakang tombol
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10), // Jarak antara teks dan ikon
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
