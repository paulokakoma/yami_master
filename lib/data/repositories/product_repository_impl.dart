import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    return [
      Product(
        id: '1',
        name: 'Feijão Carioca',
        price: 1500,
        description: 'Feijão carioca de alta qualidade, selecionado e limpo.',
        imageUrl: 'assets/products/feijao1.jpg',
      ),
      Product(
        id: '2',
        name: 'Feijão Preto',
        price: 1800,
        description: 'Feijão preto especial, ideal para feijoada.',
        imageUrl: 'assets/products/feijao2.jpg',
      ),
      Product(
        id: '3',
        name: 'Feijão Branco',
        price: 1200,
        description: 'Feijão branco premium, perfeito para caldos.',
        imageUrl: 'assets/products/feijao3.png',
      ),
      Product(
        id: '4',
        name: 'Feijão Vermelho',
        price: 2400,
        description:
            'Feijão vermelho selecionado, ótimo para pratos especiais.',
        imageUrl: 'assets/products/feijao4.jpeg',
      ),
      Product(
        id: '5',
        name: 'Feijão Mulatinho',
        price: 1600,
        description:
            'Feijão mulatinho de primeira qualidade, ideal para o dia a dia.',
        imageUrl: 'assets/products/feijao1.jpg',
      ),
      Product(
        id: '6',
        name: 'Feijão Jalo',
        price: 1900,
        description: 'Feijão jalo especial, perfeito para pratos tradicionais.',
        imageUrl: 'assets/products/feijao2.jpg',
      ),
      Product(
        id: '7',
        name: 'Feijão Rosinha',
        price: 1700,
        description: 'Feijão rosinha selecionado, ótimo para feijoada.',
        imageUrl: 'assets/products/feijao3.png',
      ),
      Product(
        id: '8',
        name: 'Feijão Cordeiro',
        price: 2100,
        description: 'Feijão cordeiro premium, ideal para pratos especiais.',
        imageUrl: 'assets/products/feijao4.jpeg',
      ),
      Product(
        id: '9',
        name: 'Feijão Rajado',
        price: 1400,
        description: 'Feijão rajado de alta qualidade, perfeito para caldos.',
        imageUrl: 'assets/products/feijao1.jpg',
      ),
      Product(
        id: '10',
        name: 'Feijão Azuki',
        price: 2800,
        description: 'Feijão azuki especial, ideal para pratos asiáticos.',
        imageUrl: 'assets/products/feijao2.jpg',
      ),
    ];
  }
}
