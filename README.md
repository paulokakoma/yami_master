# Yami - E-commerce de Alimentos

Um aplicativo Flutter para venda de produtos alimentares, com interface moderna e otimizada.

## Funcionalidades

- Autenticação de usuários (Login e Cadastro)
- Lista de produtos em grid
- Carrinho de compras como modal
- Detalhes do produto com seleção de quantidade
- Contato direto via WhatsApp, SMS e chamada
- Perfil do usuário e configurações

## Requisitos

- Flutter SDK (versão 3.2.3 ou superior)
- Dart SDK (versão 3.2.3 ou superior)
- Android Studio / VS Code com extensões do Flutter
- Git

## Instalação

1. Clone o repositório:
```bash
git clone https://github.com/seu-usuario/yami_app.git
```

2. Entre no diretório do projeto:
```bash
cd yami_app
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o aplicativo:
```bash
flutter run
```

## Estrutura do Projeto

O projeto segue a arquitetura Clean Architecture:

```
lib/
├── data/
│   └── repositories/
│       └── product_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── product.dart
│   └── repositories/
│       └── product_repository.dart
└── presentation/
    └── pages/
        ├── auth/
        │   └── auth_page.dart
        ├── home/
        │   ├── home_page.dart
        │   └── widgets/
        │       ├── product_card.dart
        │       └── cart_modal.dart
        ├── main/
        │   └── main_page.dart
        ├── product/
        │   └── product_details_page.dart
        └── profile/
            └── profile_page.dart
```

## Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
# yami_master
