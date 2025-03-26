import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Feijão Carioca',
      description: 'Feijão carioca selecionado, 1kg',
      price: 8.90,
      imageUrl: 'assets/products/feijao1.jpg',
      category: 'Legumes',
      sellerPhone: '5511999999999',
    ),
    Product(
      id: '2',
      name: 'Feijão Preto',
      description: 'Feijão preto de alta qualidade, 1kg',
      price: 9.90,
      imageUrl: 'assets/products/feijao2.jpg',
      category: 'Legumes',
      sellerPhone: '5511999999999',
    ),
    Product(
      id: '3',
      name: 'Feijão Vermelho',
      description: 'Feijão vermelho selecionado, 1kg',
      price: 10.90,
      imageUrl: 'assets/products/feijao3.png',
      category: 'Legumes',
      sellerPhone: '5511999999999',
    ),
    Product(
      id: '4',
      name: 'Feijão Branco',
      description: 'Feijão branco de alta qualidade, 1kg',
      price: 11.90,
      imageUrl: 'assets/products/feijao4.jpeg',
      category: 'Legumes',
      sellerPhone: '5511999999999',
    ),
    // Adicione mais produtos conforme necessário
  ];

  final Map<String, int> _cart = {};

  @override
  Future<List<Product>> getProducts() async {
    return _products;
  }

  @override
  Future<Product> getProductById(String id) async {
    final product = _products.firstWhere((p) => p.id == id);
    return product;
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return _products.where((p) => p.category == category).toList();
  }

  @override
  Future<void> addProductToCart(String productId, int quantity) async {
    _cart[productId] = (_cart[productId] ?? 0) + quantity;
  }

  @override
  Future<void> removeProductFromCart(String productId) async {
    _cart.remove(productId);
  }

  @override
  Future<List<Product>> getCartItems() async {
    return _cart.entries.map((entry) {
      final product = _products.firstWhere((p) => p.id == entry.key);
      return product.copyWith(quantity: entry.value);
    }).toList();
  }

  @override
  Future<double> getCartTotal() async {
    double total = 0;
    for (var entry in _cart.entries) {
      final product = _products.firstWhere((p) => p.id == entry.key);
      total += product.price * entry.value;
    }
    return total;
  }
}
