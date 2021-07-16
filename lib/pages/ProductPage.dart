import 'package:flutter/material.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/models/Tag.dart';
import 'package:foodmonkey/pages/Preview.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class ProductPage extends StatefulWidget {
  final String? loadName, type;
  const ProductPage({Key? key, this.loadName, this.type}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState(loadName, type);
}

class _ProductPageState extends State<ProductPage> {
  int currentIndex = 0;
  String? loadName, type;
  int pageNo = 0;
  List<Product> products = [];
  bool isLoading = false;

  _ProductPageState(this.loadName, this.type);

  loadProduct() async {
    setState(() {
      isLoading = true;
    });
    List<Product> pd = await Api.getPaginatedProducts(pageNo);
    setState(() {
      products.addAll(pd);
      pageNo++;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadProduct();
  }

  @override
  Widget build(BuildContext context) {
    print(type);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Product Page"),
        // ),
        body: Column(
      children: [
        _buildCustomNavBar(),
        Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (!isLoading &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    loadProduct();
                  }
                  return false;
                },
                child: _buildProductGrid())),
        Container(
            child:
                Center(child: isLoading ? CircularProgressIndicator() : null))
      ],
    ));
  }

  GridView _buildProductGrid() {
    return GridView.builder(
        itemCount: products.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => _buildProductCard(products[index]));
  }

  Column _buildProductCard(Product product) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Image.network(Constants.getImageLink(product.images?[0])),
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Preview(product: product)));
            },
            child: Text(product.name ?? "")),
        Text("${product.price}")
      ],
    );
  }

  Widget _buildCustomNavBar() {
    return Container(
        height: 51,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration:
            BoxDecoration(color: Theme.of(context).accentColor.withOpacity(1)),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Constants.tags.length,
            itemBuilder: (context, index) =>
                _buildNavTitle(Constants.tags[index], index)));
  }

  GestureDetector _buildNavTitle(Tag tag, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(tag.name ?? "",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    ?.copyWith(color: Colors.white)),
            Container(
                height: 2,
                width: 30,
                color:
                    currentIndex == index ? Colors.yellow : Colors.transparent)
          ],
        ),
      ),
    );
  }
}
