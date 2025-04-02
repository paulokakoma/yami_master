import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'dart:io';
import '../../../data/repositories/product_repository_impl.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/repositories/product_repository.dart';
import '../product/widgets/product_card.dart';
import '../favorites/favorites_page.dart';
import '../cart/cart_page.dart';
import '../product/product_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final ProductRepository _repository = ProductRepositoryImpl();
  List<Product> _products = [];
  bool _isLoading = true;
  bool _isSearchExpanded = false;
  final _searchController = TextEditingController();
  late AnimationController _searchAnimationController;
  late Animation<double> _searchAnimation;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 1;
  final List<Product> _favoriteProducts = [];
  final List<CartItem> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _searchAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _searchAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchAnimationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto de perfil atualizada com sucesso'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao selecionar imagem: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Erro ao selecionar imagem: $e');
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _profileImage = File(image.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Foto de perfil atualizada com sucesso'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao tirar foto: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      print('Erro ao tirar foto: $e');
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.camera),
              title: const Text('Tirar foto'),
              onTap: () {
                Navigator.pop(context);
                _takePhoto();
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.photo),
              title: const Text('Escolher da galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickImage();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadProducts() async {
    try {
      final products = await _repository.getProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erro ao carregar produtos')),
        );
      }
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearchExpanded = !_isSearchExpanded;
      if (_isSearchExpanded) {
        _searchAnimationController.forward();
      } else {
        _searchAnimationController.reverse();
        _searchController.clear();
      }
    });
  }

  void _showProfileOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: _showImageOptions,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                    image: _profileImage != null
                        ? DecorationImage(
                            image: FileImage(_profileImage!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _profileImage == null
                      ? const Icon(
                          CupertinoIcons.person_crop_circle_badge_plus,
                          size: 50,
                          color: Colors.green,
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Toque para alterar foto',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 20),
              _buildProfileOption(
                icon: CupertinoIcons.person,
                title: 'Meu Perfil',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _buildProfileOption(
                icon: CupertinoIcons.house,
                title: 'Início',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _buildProfileOption(
                icon: CupertinoIcons.bag,
                title: 'Meus Pedidos',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _buildProfileOption(
                icon: CupertinoIcons.heart,
                title: 'Favoritos',
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              _buildProfileOption(
                icon: CupertinoIcons.settings,
                title: 'Configurações',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              _buildProfileOption(
                icon: CupertinoIcons.square_arrow_right,
                title: 'Sair',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _addToFavorites(Product product) {
    setState(() {
      if (_favoriteProducts.contains(product)) {
        _favoriteProducts.remove(product);
      } else {
        _favoriteProducts.add(product);
      }
    });
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      final existingItemIndex = _cartItems.indexWhere(
        (item) => item.product.id == product.id,
      );

      if (existingItemIndex == -1) {
        _cartItems.add(CartItem(product: product, quantity: quantity));
      } else {
        _cartItems[existingItemIndex].quantity += quantity;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.person),
          color: Colors.green,
          onPressed: _showProfileOptions,
        ),
        title: const Text(
          'Produtos',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            color: Colors.green,
            onPressed: _toggleSearch,
          ),
          IconButton(
            icon: const Icon(CupertinoIcons.bell),
            color: Colors.green,
            onPressed: () {
              // Implementar notificações
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                if (_isSearchExpanded)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar produtos...',
                        prefixIcon: const Icon(CupertinoIcons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(CupertinoIcons.clear),
                          onPressed: () {
                            _searchController.clear();
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                      onChanged: (value) {
                        // Implementar lógica de pesquisa
                      },
                    ),
                  ),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : IndexedStack(
                          index: _currentIndex,
                          children: [
                            FavoritesPage(
                              favoriteProducts: _favoriteProducts,
                              onAddToFavorites: _addToFavorites,
                              onAddToCart: _addToCart,
                            ),
                            _buildProductGrid(),
                            CartPage(cartItems: _cartItems),
                          ],
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.green,
        buttonBackgroundColor: Colors.green,
        height: 60,
        animationDuration: const Duration(milliseconds: 500),
        animationCurve: Curves.easeInOutCubic,
        index: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          Icon(CupertinoIcons.heart, color: Colors.white),
          Icon(CupertinoIcons.home, color: Colors.white),
          Icon(CupertinoIcons.cart, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _products.length,
      itemBuilder: (context, index) {
        final product = _products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsPage(
                  product: product,
                  onAddToFavorites: () => _addToFavorites(product),
                  onAddToCart: (quantity) => _addToCart(product, quantity),
                  isFavorite: _favoriteProducts.contains(product),
                ),
              ),
            );
          },
          child: ProductCard(
            product: product,
          ),
        );
      },
    );
  }
}
