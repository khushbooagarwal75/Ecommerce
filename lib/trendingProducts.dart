import 'package:ecommerce_app/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Trendingproducts extends ConsumerWidget {
  const Trendingproducts({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final productsAsyncValue = ref.watch(productsProvider);
    return SafeArea(
        child: Scaffold(

          appBar: AppBar(
            title: Text("Cartify"),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
            actions: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/images/cartify.png"),
              )
            ],
          ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white70,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          suffixIcon: Icon(
                            Icons.mic_none,
                            color: Colors.grey,
                          ),
                          hintText: "Search any Product..",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.black12)))),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "52900+  Items",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 10,
                  ),

     Expanded(    child: productsAsyncValue.when(
              data: (products) => GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10.0, // Spacing between columns
                  mainAxisSpacing: 10.0, // Spacing between rows
                  childAspectRatio: 0.7, // Adjust to control card height relative to width
                ),
                itemCount: products.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                            child: Image.network(
                              product.getImageUrl(getBaseUrl()),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.product_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                product.product_desc,
                                style: TextStyle(color: Colors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Rs ${product.product_price.toStringAsFixed(2)}',
                                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Text(
                  'Something went wrong. Please try again later.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          ],
                  ),

              ),
        ),
            );
  }
}
