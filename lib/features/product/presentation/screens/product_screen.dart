import 'dart:async';
import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import 'product_cart_screen.dart';
import 'product_favorites_screen.dart';
import 'product_Profile_screen.dart';

// Models
class Product {
  final int id;
  final String name;
  final String category;
  final String sub;
  final double price;
  final String rating;
  final String img;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.sub,
    required this.price,
    required this.rating,
    required this.img,
    this.isFavorite = false,
  });
}

class CartItem {
  final int id;
  final String title;
  final String sub;
  final String meta;
  final double price;
  int qty;
  final String img;

  CartItem({
    required this.id,
    required this.title,
    required this.sub,
    required this.meta,
    required this.price,
    required this.qty,
    required this.img,
  });
}

class ProductScreen extends StatefulWidget {
  final String userName; // اسم المستخدم الذي قام بتسجيل الدخول

  const ProductScreen({super.key, this.userName = "Mohamed"});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedNavIndex = 0;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  late PageController _bannerController;
  int _currentBannerIndex = 0;
  Timer? _bannerTimer;

  final List<Map<String, String>> _banners = [
    {
      'title1': 'PUSH YOUR',
      'title2': 'LIMITS',
      'sub': 'Gear up. Train hard..\nConquer more.',
      'btn': 'SHOP NOW',
      'img': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=500',
    },
    {
      'title1': 'POWER &',
      'title2': 'STRENGTH',
      'sub': 'Unleash your true potential\nwith pro gear.',
      'btn': 'EXPLORE',
      'img': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=500',
    },
    {
      'title1': 'NEXT LEVEL',
      'title2': 'PERFORMANCE',
      'sub': 'Achieve your fitness goals\nstarting today.',
      'btn': 'DISCOVER',
      'img': 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?w=500',
    },
  ];

  final List<Product> _products = [
    Product(
      id: 1,
      name: "Nike Air Max",
      category: "Equipment",
      sub: "Running Shoes",
      price: 120.0,
      rating: "128",
      img: "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5823.png",
    ),
    Product(
      id: 2,
      name: "Under Armour",
      category: "Bags",
      sub: "Undeniable Duffel",
      price: 45.0,
      rating: "96",
      img: "https://pngimg.com/uploads/bag/bag_PNG101413.png",
    ),
    Product(
      id: 3,
      name: "Adidas Train",
      category: "Clothing",
      sub: "Training T-Shirt",
      price: 28.0,
      rating: "79",
      img: "https://pngimg.com/uploads/tshirt/tshirt_PNG5438.png",
    ),
    Product(
      id: 4,
      name: "Whey Protein",
      category: "Supplements",
      sub: "Gym Supplement",
      price: 55.0,
      rating: "210",
      img: "https://pngimg.com/uploads/jar/jar_PNG10271.png",
    ),
    Product(
      id: 5,
      name: "Pro Dumbbell",
      category: "Equipment",
      sub: "Gym Equipment",
      price: 35.0,
      rating: "45",
      img: "https://pngimg.com/uploads/dumbbell/dumbbell_PNG16029.png",
    ),
    Product(
      id: 6,
      name: "Sport Parfum",
      category: "Supplements",
      sub: "Long lasting scent",
      price: 65.0,
      rating: "32",
      img: "https://pngimg.com/uploads/perfume/perfume_PNG10264.png",
    ),
  ];

  final List<CartItem> _cart = [
    CartItem(
      id: 1,
      title: "Nike Air Max",
      sub: "Running Shoes",
      meta: "Size: 9",
      price: 120.0,
      qty: 1,
      img: "https://pngimg.com/uploads/running_shoes/running_shoes_PNG5823.png",
    ),
    CartItem(
      id: 2,
      title: "Under Armour",
      sub: "Undeniable Duffel",
      meta: "Color: Black",
      price: 45.0,
      qty: 1,
      img: "https://pngimg.com/uploads/bag/bag_PNG101413.png",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _bannerController = PageController();
    _bannerTimer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBannerIndex < _banners.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }
      if (_bannerController.hasClients) {
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _bannerController.dispose();
    super.dispose();
  }

  int get _totalCartCount {
    int total = 0;
    for (var item in _cart) {
      total += item.qty;
    }
    return total;
  }

  void _addToCart(Product product) {
    setState(() {
      int index = _cart.indexWhere((item) => item.id == product.id);
      if (index != -1) {
        _cart[index].qty++;
      } else {
        _cart.add(
          CartItem(
            id: product.id,
            title: product.name,
            sub: product.sub,
            meta: 'Default Size',
            price: product.price,
            qty: 1,
            img: product.img,
          ),
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFFFF3B00),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildHomeContent(),
      ProductCartScreen(
        cart: _cart,
        onCartUpdated: () => setState(() {}),
      ),
      ProductFavoritesScreen(
        favoriteProducts: _products.where((p) => p.isFavorite).toList(),
        onToggleFavorite: (product) {
          setState(() {
            product.isFavorite = !product.isFavorite;
          });
        },
        onAddToCart: _addToCart,
      ),
      ProductProfileScreen(userName: widget.userName),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: SafeArea(child: pages[_selectedNavIndex]),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHomeContent() {
    List<Product> filteredProducts = _products.where((p) {
      bool matchesCategory =
          _selectedCategory == 'All' || p.category == _selectedCategory;
      bool matchesSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.sub.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.notes, size: 28),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(text: 'A'),
                      TextSpan(
                        text: 'THRYX',
                        style: TextStyle(color: Color(0xFFFF3B00)),
                      ),
                    ],
                  ),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none, size: 26),
                      onPressed: () => setState(() => _selectedNavIndex = 1),
                    ),
                    Positioned(
                      right: 4,
                      top: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFFF3B00),
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                        child: Text(
                          '$_totalCartCount',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          // Dynamic Greeting Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good Evening 👋', style: TextStyle(color: Color(0xFF8E8E93), fontSize: 13)),
                    const SizedBox(height: 2),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.white, Color(0xFFFF3B00)],
                        stops: [0.6, 1.0],
                      ).createShader(bounds),
                      child: Text(
                        widget.userName.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: const Icon(Icons.security, color: Colors.white, size: 20),
                )
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.05)),
                    ),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Search for products...',
                        hintStyle: TextStyle(color: Color(0xFF8E8E93), fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Color(0xFF8E8E93)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.05)),
                  ),
                  child: const Icon(Icons.tune, color: Colors.white, size: 20),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),

          // Banners
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: PageView.builder(
                      controller: _bannerController,
                      onPageChanged: (idx) => setState(() => _currentBannerIndex = idx),
                      itemCount: _banners.length,
                      itemBuilder: (context, index) {
                        final banner = _banners[index];
                        return Stack(
                          children: [
                            Positioned.fill(child: Image.network(banner['img']!, fit: BoxFit.cover)),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black.withOpacity(0.85), Colors.black.withOpacity(0.3)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: Colors.white),
                                      children: [
                                        TextSpan(text: '${banner['title1']}\n'),
                                        TextSpan(text: banner['title2'], style: const TextStyle(color: Color(0xFFFF3B00))),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(banner['sub']!, style: const TextStyle(color: Color(0xFFDDDDDD), fontSize: 11)),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () => setState(() => _selectedNavIndex = 1),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFF3B00),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                                      minimumSize: Size.zero,
                                    ),
                                    child: Text(banner['btn']!, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_banners.length, (idx) {
                    bool isActive = idx == _currentBannerIndex;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: isActive ? 16 : 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: isActive ? const Color(0xFFFF3B00) : const Color(0xFF333333),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),

          // Categories Cards
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                GestureDetector(
                  onTap: () => setState(() => _selectedCategory = 'All'),
                  child: const Text('View all', style: TextStyle(color: Color(0xFFFF3B00), fontSize: 12, fontWeight: FontWeight.w500)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryCard('Equipment', Icons.fitness_center),
                _buildCategoryCard('Bags', Icons.shopping_bag),
                _buildCategoryCard('Clothing', Icons.checkroom),
                _buildCategoryCard('Supplements', Icons.medication),
              ],
            ),
          ),

          // Products Section Title
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 12),
            child: Text(
              _selectedCategory == 'All' ? 'Best Sellers' : _selectedCategory,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),

          // Products Grid View
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: filteredProducts.isEmpty
                ? const Center(child: Padding(padding: EdgeInsets.all(20.0), child: Text('No items found.', style: TextStyle(color: Colors.grey))))
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.72,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final prod = filteredProducts[index];
                      return _buildProductCard(prod);
                    },
                  ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String name, IconData icon) {
    bool isSelected = _selectedCategory == name;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = name),
      child: Container(
        width: (MediaQuery.of(context).size.width - 76) / 4,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? const Color(0xFFFF3B00) : Colors.white.withOpacity(0.12)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFFF3B00), size: 22),
            const SizedBox(height: 8),
            Text(name, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Product prod) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    prod.isFavorite = !prod.isFavorite;
                  });
                },
                child: Icon(
                  prod.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: prod.isFavorite ? const Color(0xFFFF3B00) : Colors.grey,
                  size: 18,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: prod,
                    onAddToCart: () => _addToCart(prod),
                  ),
                ),
              );
            },
            child: Center(
              child: Image.network(prod.img, height: 85, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(prod.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white), maxLines: 1),
          Text(prod.sub, style: const TextStyle(fontSize: 10, color: Color(0xFF8E8E93)), maxLines: 1),
          const SizedBox(height: 4),
          Row(
            children: [
              ...List.generate(5, (index) => const Icon(Icons.star, color: Color(0xFFFF3B00), size: 10)),
              const SizedBox(width: 2),
              Text('(${prod.rating})', style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 8)),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${prod.price.toStringAsFixed(0)}.00', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
              GestureDetector(
                onTap: () => _addToCart(prod),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(color: const Color(0xFFFF3B00), borderRadius: BorderRadius.circular(6)),
                  child: const Icon(Icons.shopping_bag, color: Colors.white, size: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF121212),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF0D0D0D),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: const Center(
                    child: Text('A', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: Color(0xFFFF3B00))),
                  ),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.userName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 3),
                    const Text('Premium Member', style: TextStyle(fontSize: 12, color: Color(0xFFFF3B00), fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          _buildDrawerTile(Icons.home, 'Home', selected: _selectedNavIndex == 0, onTap: () {
            Navigator.pop(context);
            setState(() => _selectedNavIndex = 0);
          }),
          _buildDrawerTile(Icons.shopping_bag, 'Orders', onTap: () {
            Navigator.pop(context);
            setState(() => _selectedNavIndex = 1);
          }),
          _buildDrawerTile(Icons.favorite_border, 'Wishlist', onTap: () {
            Navigator.pop(context);
            setState(() => _selectedNavIndex = 2);
          }),
          _buildDrawerTile(Icons.person_outline, 'Profile', onTap: () {
            Navigator.pop(context);
            setState(() => _selectedNavIndex = 3);
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(IconData icon, String title, {bool selected = false, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: selected ? const Color(0xFFFF3B00) : Colors.white, size: 20),
      title: Text(title, style: TextStyle(color: selected ? const Color(0xFFFF3B00) : Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
      selected: selected,
      selectedTileColor: const Color(0xFF1E1E1E),
      onTap: onTap,
    );
  }

  // Bottom Nav الخالي من التصنيفات (Categories)
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFFF3B00),
      unselectedItemColor: const Color(0xFF8E8E93),
      currentIndex: _selectedNavIndex,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      onTap: (index) => setState(() => _selectedNavIndex = index),
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.shopping_cart),
              if (_totalCartCount > 0)
                Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(color: Color(0xFFFF3B00), shape: BoxShape.circle),
                    constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                    child: Text('$_totalCartCount', style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  ),
                )
            ],
          ),
          label: 'Cart',
        ),
        const BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
        const BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}
