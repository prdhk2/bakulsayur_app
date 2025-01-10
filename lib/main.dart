import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'screens/welcome.dart';
import 'screens/registration.dart';
import 'screens/login.dart';
import 'screens/profile.dart';
import 'components/floating-bottom-nav.dart';
import 'screens/cart.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bakul Sayur APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const WelcomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return createRoute(const MyHomePage());
          case '/login':
            return createRoute(const LoginScreen());
          case '/registration':
            return createRoute(const RegistrationScreen());
          case '/profile':
            return createRoute(ProfilePage());
          case '/cart':
            return createRoute(CartPage());
          default:
            return null;
        }
      },
    );
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Mulai dari bawah
      const end = Offset.zero; // Berakhir di posisi normal
      const curve = Curves.easeInOut; // Kurva animasi
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();
  int _currentPageBanner = 0;
  int _currentPageNav = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      int nextPage = (_currentPageBanner + 1) % 3;
      _goToPage(nextPage);
    });
  }

  void _goToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentPageBanner = page;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentPageNav = index;
    });

    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Whip up some healthy eats today',
                    style: TextStyle(
                      fontFamily: 'Ubuntu',
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Happy family with fresh ingredient !',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPageBanner = index;
                        });
                      },
                      children: [
                        _buildBanner('Banner 1', color: Colors.blue[100]),
                        _buildBanner('Banner 2', color: Colors.blue[200]),
                        _buildBanner('Banner 3', color: Colors.blue[300]),
                      ],
                    ),
                    Positioned(
                      left: 16,
                      top: 100,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: _currentPageBanner > 0
                            ? () => _goToPage(_currentPageBanner - 1)
                            : null,
                      ),
                    ),
                    Positioned(
                      right: 16,
                      top: 100,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward,
                            color: Colors.white),
                        onPressed: _currentPageBanner < 2
                            ? () => _goToPage(_currentPageBanner + 1)
                            : null,
                      ),
                    ),
                  ],
                )),
            // Add a card below the banner

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Card(
                elevation: 0,
                color:
                    Colors.transparent, // Menjadikan latar belakang transparan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row untuk 'Category' di kiri dan 'View All' di kanan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Aksi saat "View All" diklik print('View All clicked');
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors
                                    .blue, // Warna teks yang dapat di-klik
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Jarak antara teks dan kartu
                      // Row untuk menampilkan kartu-kartu di samping teks
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Card pertama
                          Expanded(
                            child: Card(
                              elevation: 5, // Tinggi bayangan
                              shadowColor: const Color.fromARGB(
                                  255, 239, 239, 239), // Warna bayangan
                              color: Colors
                                  .grey[50], // Ganti warna sesuai kebutuhan
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                height: 50, // Tinggi kartu
                                alignment: Alignment.center,
                                child: const Text(
                                  'Category 1',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Jarak antar kartu
                          // Card kedua
                          Expanded(
                            child: Card(
                              elevation: 5, // Tinggi bayangan
                              shadowColor: const Color.fromARGB(
                                  255, 239, 239, 239), // Warna bayangan
                              color: Colors
                                  .grey[50], // Ganti warna sesuai kebutuhan
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                height: 50, // Tinggi kartu
                                alignment: Alignment.center,
                                child: const Text(
                                  'Category 2',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8), // Jarak antar kartu
                          // Card ketiga (opsional)
                          Expanded(
                            child: Card(
                              elevation: 5, // Tinggi bayangan
                              shadowColor: const Color.fromARGB(
                                  255, 239, 239, 239), // Warna bayangan
                              color: Colors
                                  .grey[50], // Ganti warna sesuai kebutuhan
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Container(
                                height: 50, // Tinggi kartu
                                alignment: Alignment.center,
                                child: const Text(
                                  'Category 3',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1.0),
              child: Card(
                elevation: 0,
                color:
                    Colors.transparent, // Menjadikan latar belakang transparan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row untuk 'Our Product' di kiri dan 'View All' di kanan
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Our Product',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Aksi saat "View All" diklik
                              print('View All clicked');
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors
                                    .blue, // Warna teks yang dapat di-klik
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // Jarak antara teks dan kartu
                      // Grid untuk menampilkan produk
                      GridView.builder(
                        shrinkWrap: true,
                        physics:
                            const NeverScrollableScrollPhysics(), // Non-scrollable grid
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Jumlah kolom
                          crossAxisSpacing: 16.0, // Jarak antar kolom
                          mainAxisSpacing: 16.0, // Jarak antar baris
                          childAspectRatio: 0.75, // Rasio lebar dan tinggi card
                        ),
                        itemCount: 6, // Jumlah produk
                        itemBuilder: (context, index) {
                          return ProductCard(
                            imagePath:
                                'assets/images/KOL.jpg', // Path gambar lokal
                            title: 'Product ${index + 1}', // Judul produk
                            price: '\$19.99', // Harga produk
                            description:
                                'Deskripsi singkat produk ${index + 1}.', // Deskripsi produk
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FloatingBottomNav(
        currentIndex: _currentPageNav,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBanner(String text, {required Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(
                height: 8), // Space between the text and "Most Popular"
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String description;

  const ProductCard({
    required this.imagePath,
    required this.title,
    required this.price,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk dari folder lokal
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imagePath, // Menggunakan path lokal
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul produk
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                // Harga produk
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                // Deskripsi singkat produk
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          // Tombol Favorit dan Keranjang
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon:
                      FaIcon(FontAwesomeIcons.heart), // Tambahkan di dalam icon
                  onPressed: () {
                    print('Added to favorites');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    // Aksi saat tombol keranjang diklik
                    print('Added to cart');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
