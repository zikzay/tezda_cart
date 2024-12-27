import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_cart/app/router/app_router.dart';
import '../../favorites/presentation/favorites_provider.dart';
import 'product_providers.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    ref.read(favoritesProvider.notifier).getFromStorage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(productListProvider.notifier).fetchProducts(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final productListState = ref.watch(productListProvider);
    ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Text(
          'Products',
        ),
        backgroundColor: Colors.black,
        foregroundColor: const Color.fromARGB(255, 193, 145, 0),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
      ),
      body: productListState.products.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              controller: _scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (MediaQuery.of(context).size.width / 160).toInt(), // Responsive columns
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 3 / 4, // Adjust as needed
              ),
              itemCount: productListState.products.length + (productListState.isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= productListState.products.length) {
                  return Center(child: CircularProgressIndicator());
                }

                final product = productListState.products[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 2,
                  margin: EdgeInsets.all(0), //.only(left: index % 2 == 0 ? 16 : 0, right: index % 2 == 1 ? 16 : 0),
                  shadowColor: Colors.black38,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouter.productDetail, arguments: product);
                    },
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                                child: CachedNetworkImage(
                              imageUrl: product.thumbnail ?? product.images?[0] ?? '',
                              placeholder: (context, url) => Image.asset('assets/images/default-product.jpg'),
                              errorWidget: (context, url, error) => Image.asset('assets/images/default-product.jpg'),
                              fit: BoxFit.cover,
                            )),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
                              child: Text(
                                product.title ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                children: [
                                  Text(
                                    '\$${((product.price ?? 0) - ((product.price ?? 0) * (product.discountPercentage ?? 0) / 100)).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(255, 193, 145, 0),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '\$${(product.price)?.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: Icon(
                              ref.watch(favoritesProvider).contains(product.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                            ),
                            onPressed: () {
                              ref.read(favoritesProvider.notifier).toggleFavorite(product);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
