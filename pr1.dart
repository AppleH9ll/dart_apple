import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Практическая работа №1',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color.fromARGB(255, 58, 79, 199)),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Выбор макета')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _menuTile(context, '1. Простой макет: Вход', const SimpleLoginScreen()),
          _menuTile(context, '2. Простой макет: Профиль', const SimpleProfileScreen()),
          _menuTile(context, '3. Сложный макет: Карточка товара', const ComplexProductScreen()),
          _menuTile(context, '4. Сложный макет: Лента с поиском', const ComplexFeedScreen()),
        ],
      ),
    );
  }
  Widget _menuTile(BuildContext ctx, String title, Widget page) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.push(ctx, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}

// ==================== ПРОСТОЙ МАКЕТ 1: ВХОД ====================
class SimpleLoginScreen extends StatelessWidget {
  const SimpleLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.indigo),
            const SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Пароль',
                prefixIcon: const Icon(Icons.password),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {},
              style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              child: const Text('Войти'),
            ),
            const SizedBox(height: 12),
            TextButton(onPressed: () {}, child: const Text('Забыли пароль?')),
          ],
        ),
      ),
    );
  }
}

// ==================== ПРОСТОЙ МАКЕТ 2: ПРОФИЛЬ ====================
class SimpleProfileScreen extends StatelessWidget {
  const SimpleProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
          ),
          const SizedBox(height: 12),
          const Center(child: Text('Иванов И.И.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          const Center(child: Text('Студент группы П-577-666', style: TextStyle(color: Colors.grey))),
          const SizedBox(height: 24),
          _infoCard(Icons.email, 'Email', 'student@example.com'),
          _infoCard(Icons.phone, 'Телефон', '+7 (999) 123-45-67'),
          _infoCard(Icons.location_on, 'Город', 'Москва'),
        ],
      ),
    );
  }
  Widget _infoCard(IconData icon, String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.indigo),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}

// ==================== СЛОЖНЫЙ МАКЕТ 3: КАРТОЧКА ТОВАРА ====================
class ComplexProductScreen extends StatefulWidget {
  const ComplexProductScreen({super.key});
  @override
  State<ComplexProductScreen> createState() => _ComplexProductScreenState();
}

class _ComplexProductScreenState extends State<ComplexProductScreen> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Карточка товара'),
        actions: [IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {})],
      ),
      body: ListView(
        children: [
          Container(
            height: 240,
            color: Colors.indigo.shade50,
            child: const Center(child: Icon(Icons.image, size: 100, color: Colors.indigo)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Смартфон X', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Row(children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Icon(Icons.star_half, color: Colors.amber, size: 20),
                  SizedBox(width: 8),
                  Text('4.5 (128 отзывов)'),
                ]),
                const SizedBox(height: 12),
                const Text('79 990 ₽', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const SizedBox(height: 16),
                const Divider(),
                const Text('Описание', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                const Text('Отличный смартфон с большим экраном, мощным процессором и камерой 228 Мп.'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Количество: ', style: TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => setState(() => _quantity = _quantity > 1 ? _quantity - 1 : 1),
                    ),
                    Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: () => setState(() => _quantity++),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.shopping_cart),
          label: const Text('Добавить в корзину'),
          style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
        ),
      ),
    );
  }
}

// ==================== СЛОЖНЫЙ МАКЕТ 4: ЛЕНТА С ПОИСКОМ ====================
class ComplexFeedScreen extends StatelessWidget {
  const ComplexFeedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Лента'),
              background: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.indigoAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Поиск...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('Новость ${index + 1}'),
                  subtitle: const Text('Краткое описание новости...'),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              childCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}