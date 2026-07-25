import 'package:flutter/material.dart';



/*
=====================================================
==============(MAIN APP ENTRY)=======================
=====================================================
*/
class AthryxApp extends StatelessWidget {
  const AthryxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATHRYX App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B0B),
        cardColor: const Color(0xFF161616),
        primaryColor: const Color(0xFFFF3B00),
      ),
      home: const MainScreen(),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String category;
  final String sub;
  final double price;
  final String rating;
  final IconData icon;
  final String img;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.sub,
    required this.price,
    required this.rating,
    required this.icon,
    required this.img,
  });
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _currentCarouselIndex = 0;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final Map<int, int> _cart = {};
  final Set<int> _favorites = {};

  final Color primaryOrange = const Color(0xFFFF3B00);
  final Color cardBg = const Color(0xFF161616);
  final Color textSub = const Color(0xFF808080);
  final Color borderColor = const Color(0x14FFFFFF);

  final List<Product> _products = [
    Product(id: 1, name: "Pro Dumbbell Set", category: "Equipment", sub: "Gym Equipment", price: 45, rating: "120", icon: Icons.fitness_center, img: "https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?w=400"),
    Product(id: 2, name: "Kettlebell 16kg", category: "Equipment", sub: "Weight Training", price: 60, rating: "85", icon: Icons.fitness_center, img: "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=400"),
    Product(id: 3, name: "Resistance Bands", category: "Equipment", sub: "Fitness Gear", price: 20, rating: "210", icon: Icons.fitness_center, img: "https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=400"),
    Product(id: 4, name: "Under Armour Duffel", category: "Equipment", sub: "Gym Bag", price: 50, rating: "96", icon: Icons.shopping_bag, img: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=400"),
    Product(id: 5, name: "Yoga Mat Pro", category: "Equipment", sub: "Floor Exercise", price: 30, rating: "140", icon: Icons.fitness_center, img: "https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=400"),
    Product(id: 6, name: "Nike Air Max", category: "Shoes", sub: "Running Shoes", price: 120, rating: "128", icon: Icons.directions_run, img: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400"),
    Product(id: 7, name: "Adidas Ultraboost", category: "Shoes", sub: "Sport Sneakers", price: 140, rating: "310", icon: Icons.directions_run, img: "https://images.unsplash.com/photo-1584735175315-9d5df23860e6?w=400"),
    Product(id: 8, name: "Puma Runner", category: "Shoes", sub: "Lightweight Shoes", price: 90, rating: "75", icon: Icons.directions_run, img: "https://images.unsplash.com/photo-1608231387042-66d1773070a5?w=400"),
    Product(id: 11, name: "Adidas Sport T-Shirt", category: "Clothing", sub: "Training Shirt", price: 28, rating: "76", icon: Icons.checkroom, img: "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?w=400"),
    Product(id: 12, name: "Nike Pro Shorts", category: "Clothing", sub: "Athletic Shorts", price: 35, rating: "115", icon: Icons.checkroom, img: "https://images.unsplash.com/photo-1591195853828-11db59a44f6b?w=400"),
    Product(id: 16, name: "Whey Gold Protein", category: "Supplements", sub: "Post Workout", price: 65, rating: "420", icon: Icons.local_pharmacy, img: "https://images.unsplash.com/photo-1579722821273-0f6c7d44362f?w=400"),
    Product(id: 17, name: "Creatine Monohydrate", category: "Supplements", sub: "Muscle Strength", price: 30, rating: "230", icon: Icons.local_pharmacy, img: "https://images.unsplash.com/photo-1593095948071-474c5cc2989d?w=400"),
  ];

  final List<Map<String, String>> _banners = [
    {
      "title1": "PUSH YOUR",
      "title2": "LIMITS",
      "desc": "Gear up. Train hard..\nConquer more.",
      "btn": "SHOP NOW",
      "img": "https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800"
    },
    {
      "title1": "NEW ATHLETIC",
      "title2": "COLLECTION",
      "desc": "Get up to 30% OFF\nOn new fitness shoes.",
      "btn": "DISCOVER",
      "img": "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800"
    },
    {
      "title1": "PREMIUM",
      "title2": "SUPPLEMENTS",
      "desc": "Boost your power\nand endurance today.",
      "btn": "BUY NOW",
      "img": "https://images.unsplash.com/photo-1579722821273-0f6c7d44362f?w=800"
    },
  ];

  int get totalCartCount => _cart.values.fold(0, (sum, count) => sum + count);

  void _addToCart(int id) {
    setState(() => _cart[id] = (_cart[id] ?? 0) + 1);
  }

  void _changeQty(int id, int delta) {
    setState(() {
      if (_cart.containsKey(id)) {
        _cart[id] = _cart[id]! + delta;
        if (_cart[id]! <= 0) _cart.remove(id);
      }
    });
  }

  void _toggleFav(int id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: [
            _buildHomeView(),
            _buildCartView(),
            _buildFavView(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildLogo({double fontSize = 22}) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'A', style: TextStyle(color: primaryOrange)),
          const TextSpan(text: 'THRYX'),
        ],
      ),
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        letterSpacing: 2,
        color: Colors.white,
      ),
    );
  }

/*
=====================================================
==============(START DRAWER / PROFILE)===============
=====================================================
*/
  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF111111),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogo(),
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.close, size: 20, color: Color(0xFF888888)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF222222), height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              children: [
                _drawerTile(Icons.home, "Home", 0),
                _drawerTile(Icons.grid_view, "Categories", 0, onClick: () {
                  setState(() => _selectedCategory = 'All');
                }),
                _drawerTile(Icons.shopping_cart, "My Cart", 1),
                _drawerTile(Icons.favorite, "Favorites", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerTile(IconData icon, String title, int viewIndex, {VoidCallback? onClick}) {
    bool isActive = _currentIndex == viewIndex;
    return ListTile(
      leading: Icon(icon, color: isActive ? primaryOrange : Colors.white, size: 20),
      title: Text(title, style: TextStyle(color: isActive ? primaryOrange : Colors.white, fontSize: 13)),
      tileColor: isActive ? const Color(0xFF1F1F1F) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        setState(() => _currentIndex = viewIndex);
        if (onClick != null) onClick();
        Navigator.pop(context);
      },
    );
  }
/*
=====================================================
===============(END DRAWER / PROFILE)================
=====================================================
*/

/*
=====================================================
===================(START HOME)======================
=====================================================
*/
  Widget _buildHomeView() {
    List<Product> filteredProducts = _products.where((p) {
      bool matchesCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
      bool matchesSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) || p.sub.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.notes, size: 24),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
                _buildLogo(),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.notifications_none, size: 24),
                      onPressed: () => setState(() => _currentIndex = 1),
                    ),
                    if (totalCartCount > 0)
                      Positioned(
                        right: 4,
                        top: 4,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: primaryOrange,
                          child: Text('$totalCartCount', style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
          
          // Greeting Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good Evening 👋', style: TextStyle(color: textSub, fontSize: 12)),
                    const SizedBox(height: 2),
                    const Text('Mohamed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Icon(Icons.person_outline, size: 20),
                )
              ],
            ),
          ),

          // Search Box & Filter Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      onChanged: (val) => setState(() => _searchQuery = val),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey, size: 18),
                        hintText: 'Search for products...',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.tune, color: Colors.white, size: 18),
                )
              ],
            ),
          ),

          _buildBannerCarousel(),
          _buildCategoryHeader("Categories", () => setState(() => _selectedCategory = 'All')),
          _buildCategoriesGrid(),
          _buildCategoryHeader(_selectedCategory == 'All' ? 'Best Sellers' : _selectedCategory, () {}),
          _buildProductsGrid(filteredProducts),
        ],
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: (index) => setState(() => _currentCarouselIndex = index),
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final b = _banners[index];
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  image: DecorationImage(
                    image: NetworkImage(b["img"]!),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.4),
                        Colors.transparent,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "${b['title1']}\n"),
                            TextSpan(text: b['title2'], style: TextStyle(color: primaryOrange)),
                          ],
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(b["desc"]!, style: const TextStyle(color: Colors.white70, fontSize: 10, height: 1.3)),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: primaryOrange, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          b["btn"]!,
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _banners.length,
                (idx) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentCarouselIndex == idx ? 14 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _currentCarouselIndex == idx ? primaryOrange : Colors.white38,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title, VoidCallback onViewAll) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          GestureDetector(
            onTap: onViewAll,
            child: Text('View all', style: TextStyle(color: primaryOrange, fontSize: 11, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesGrid() {
    final categories = [
      {"name": "Equipment", "icon": Icons.fitness_center},
      {"name": "Shoes", "icon": Icons.directions_run},
      {"name": "Clothing", "icon": Icons.checkroom},
      {"name": "Supplements", "icon": Icons.local_pharmacy},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((cat) {
          bool isSelected = _selectedCategory == cat["name"];
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedCategory = cat["name"] as String),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF222222) : cardBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: isSelected ? primaryOrange : borderColor),
                ),
                child: Column(
                  children: [
                    Icon(cat["icon"] as IconData, color: primaryOrange, size: 18),
                    const SizedBox(height: 6),
                    Text(cat["name"] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProductsGrid(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.70,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final prod = products[index];
        final isFav = _favorites.contains(prod.id);

        return GestureDetector(
          onTap: () => _addToCart(prod.id),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 95,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          prod.img,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(prod.icon, size: 32, color: Colors.white24),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: GestureDetector(
                        onTap: () => _toggleFav(prod.id),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isFav ? primaryOrange : Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 6),
                Text(prod.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                Text(prod.sub, style: TextStyle(fontSize: 10, color: textSub)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ...List.generate(5, (_) => Icon(Icons.star, size: 8, color: primaryOrange)),
                    const SizedBox(width: 2),
                    Text('(${prod.rating})', style: TextStyle(fontSize: 8, color: textSub)),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${prod.price.toInt()}.00', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => _addToCart(prod.id),
                      child: Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(color: primaryOrange, borderRadius: BorderRadius.circular(6)),
                        child: const Icon(Icons.add, size: 14, color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
/*
=====================================================
====================(END HOME)=======================
=====================================================
*/

/*
=====================================================
====================(START CART)=====================
=====================================================
*/
  Widget _buildCartView() {
    List<int> cartKeys = _cart.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('My Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: cartKeys.isEmpty
              ? Center(child: Text('Cart is empty', style: TextStyle(color: textSub, fontSize: 12)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: cartKeys.length,
                  itemBuilder: (context, index) {
                    int id = cartKeys[index];
                    Product prod = _products.firstWhere((p) => p.id == id);
                    int qty = _cart[id]!;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                prod.img,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(prod.icon, color: primaryOrange, size: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prod.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text('\$${prod.price.toInt()}.00 each', style: TextStyle(fontSize: 10, color: textSub)),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _changeQty(id, -1),
                                      child: Container(
                                        width: 22, height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: const Color(0xFF252525), borderRadius: BorderRadius.circular(4)),
                                        child: const Text('-', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text('$qty', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),
                                    GestureDetector(
                                      onTap: () => _changeQty(id, 1),
                                      child: Container(
                                        width: 22, height: 22,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: const Color(0xFF252525), borderRadius: BorderRadius.circular(4)),
                                        child: const Text('+', style: TextStyle(fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Text('\$${(prod.price * qty).toInt()}.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: primaryOrange)),
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
/*
=====================================================
=====================(END CART)======================
=====================================================
*/

/*
=====================================================
==================(START FAVORITES)==================
=====================================================
*/
  Widget _buildFavView() {
    List<Product> favProducts = _products.where((p) => _favorites.contains(p.id)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('My Favorites', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: favProducts.isEmpty
              ? Center(child: Text('No favorites added', style: TextStyle(color: textSub, fontSize: 12)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: favProducts.length,
                  itemBuilder: (context, index) {
                    Product prod = favProducts[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: borderColor)),
                      child: Row(
                        children: [
                          Container(
                            width: 60, height: 60,
                            decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(8)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                prod.img, fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Icon(prod.icon, color: primaryOrange, size: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(prod.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                Text(prod.sub, style: TextStyle(fontSize: 10, color: textSub)),
                                const SizedBox(height: 4),
                                Text('\$${prod.price.toInt()}.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: primaryOrange)),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite, color: primaryOrange),
                            onPressed: () => _toggleFav(prod.id),
                          )
                        ],
                      ),
                    );
                  },
                ),
        )
      ],
    );
  }
/*
=====================================================
===================(END FAVORITES)===================
=====================================================
*/

/*
=====================================================
===============(START NAVIGATION)====================
=====================================================
*/
  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF050505),
        border: Border(top: BorderSide(color: borderColor)),
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 3) {
            Scaffold.of(context).openDrawer();
          } else {
            setState(() => _currentIndex = index);
          }
        },
        selectedItemColor: primaryOrange,
        unselectedItemColor: textSub,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home, size: 20), label: 'Home'),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.shopping_cart, size: 20),
                if (totalCartCount > 0)
                  Positioned(
                    top: -4, right: -6,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: primaryOrange,
                      child: Text('$totalCartCount', style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(Icons.favorite, size: 20),
                if (_favorites.isNotEmpty)
                  Positioned(
                    top: -4, right: -6,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor: primaryOrange,
                      child: Text('${_favorites.length}', style: const TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
              ],
            ),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 20), label: 'Profile'),
        ],
      ),
    );
  }
/*
=====================================================
================(END NAVIGATION)=====================
=====================================================
*/
}
