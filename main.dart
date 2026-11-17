import 'package:flutter/material.dart';

void main() {
  runApp(const FoodMenuApp());
}

// MAIN APP
class FoodMenuApp extends StatefulWidget {
  const FoodMenuApp({super.key});

  @override
  State<FoodMenuApp> createState() => _FoodMenuAppState();
}

class _FoodMenuAppState extends State<FoodMenuApp> {
  bool isDark = false;

  // Light Theme
  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardThemeData(elevation: 4),
  );

  // Dark Theme
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepOrange,
      foregroundColor: Colors.white,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Menu App',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: FoodMenuScreen(
        isDark: isDark,
        onThemeChange: () {
          setState(() {
            isDark = !isDark;
          });
        },
      ),
    );
  }
}

// FOOD MODEL
class Food {
  final String name;
  final String image;
  final double price;
  final double rating;

  const Food({
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
  });
}

// FOOD DATA
final List<Food> foodList = [
  Food(
    name: 'Burger',
    image: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400',
    price: 250,
    rating: 4.8,
  ),
  Food(
    name: 'Pizza',
    image: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
    price: 450,
    rating: 4.9,
  ),
  Food(
    name: 'Pasta',
    image: 'https://images.unsplash.com/photo-1473093295043-cdd812d0e601?w=400',
    price: 350,
    rating: 4.5,
  ),
  Food(
    name: 'Sandwich',
    image: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=400',
    price: 180,
    rating: 4.3,
  ),
  Food(
    name: 'French Fries',
    image: 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=400',
    price: 150,
    rating: 4.6,
  ),
  Food(
    name: 'Chicken',
    image: 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=400',
    price: 500,
    rating: 4.7,
  ),
];

// FOOD MENU SCREEN
class FoodMenuScreen extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeChange;

  const FoodMenuScreen({
    super.key,
    required this.isDark,
    required this.onThemeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: onThemeChange,
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: 'Change Theme',
          ),
        ],
      ),

      body: LayoutBuilder(
        builder: (context, constraints) {
          // MOBILE SCREEN
          if (constraints.maxWidth < 600) {
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return FoodCard(food: foodList[index]);
              },
            );
          }

          // TABLET / DESKTOP SCREEN
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: foodList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: constraints.maxWidth < 900 ? 2 : 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
            ),
            itemBuilder: (context, index) {
              return FoodCard(food: foodList[index]);
            },
          );
        },
      ),
    );
  }
}

// REUSABLE FOOD CARD
class FoodCard extends StatelessWidget {
  final Food food;

  const FoodCard({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(10),

        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // FOOD IMAGE WITH STACK
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        food.image,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stack) {
                          return Container(
                            width: 110,
                            height: 110,
                            color: Colors.grey,
                            child: const Icon(Icons.fastfood, size: 40),
                          );
                        },
                      ),
                    ),

                    const Positioned(
                      top: 5,
                      right: 5,
                      child: Icon(Icons.favorite, color: Colors.red),
                    ),
                  ],
                ),

                const SizedBox(width: 15),

                // FOOD DETAILS
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        food.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Price: ৳${food.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            food.rating.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
