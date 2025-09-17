import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import '../../../../widgets/app_text.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage>
    with AutomaticKeepAliveClientMixin {
  final List<_Category> categories = const [
    _Category(name: 'Electronics', color: Color(0xFF81D4FA)),
    _Category(name: 'Clothing', color: Color(0xFFFFB74D)),
    _Category(name: 'Home & Kitchen', color: Color(0xFFFFE57F)),
    _Category(name: 'Beauty', color: Color(0xFFF48FB1)),
    _Category(name: 'Books', color: Color(0xFFCE93D8)),
    _Category(name: 'Sports', color: Color(0xFFAED581)),
    _Category(name: 'Toys & Games', color: Color(0xFFB39DDB)),
    _Category(name: 'Health & Personal Care', color: Color(0xFF90CAF9)),
    _Category(name: 'Automotive', color: Color(0xFF80CBC4)),
    _Category(name: 'Pet Supplies', color: Color(0xFFFFCC80)),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Categories',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.kTextColor,
        ),
        centerTitle: true,
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _CategoryTile(
            category: category,
            onTap: () {
              // TODO: navigate to category page
            },
          );
        },
      ),
    );
  }
}

class _Category {
  final String name;
  final Color color;

  const _Category({
    required this.name,
    required this.color,
  });
}

class _CategoryTile extends StatefulWidget {
  final _Category category;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.category,
    required this.onTap,
  });

  @override
  State<_CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<_CategoryTile> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails details) => setState(() => _scale = 0.95);
  void _onTapUp(TapUpDetails details) => setState(() => _scale = 1.0);
  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        transform: Matrix4.identity()..scale(_scale),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              widget.category.color.withValues(alpha: 0.7),
              widget.category.color.withValues(alpha: 0.95),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: AppText(
            text: widget.category.name,
            fontWeight: FontWeight.bold,
            color: context.kTextColor,
          ),
        ),
      ),
    );
  }
}
