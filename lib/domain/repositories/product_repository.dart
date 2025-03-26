import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<List<Product>> getProductsByCategory(String category);
  Future<void> addProductToCart(String productId, int quantity);
  Future<void> removeProductFromCart(String productId);
  Future<List<Product>> getCartItems();
  Future<double> getCartTotal();
}
