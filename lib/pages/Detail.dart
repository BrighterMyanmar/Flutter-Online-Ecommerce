import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Detail extends StatefulWidget {
  final Product? product;
  const Detail({Key? key, this.product}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(product);
}

class _DetailState extends State<Detail> {
  final Product? product;
  _DetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
          actions: [
            Constants.getCartAction(context, Constants.primary),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              Container(
                  height: 150,
                  child: Swiper(
                    index: 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Image.network(
                        Constants.getImageLink(product?.images?[index]),
                        fit: BoxFit.contain,
                      );
                    },
                    autoplay: true,
                    itemCount: product?.images?.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    pagination:
                        SwiperPagination(alignment: Alignment.centerRight),
                    control: SwiperControl(),
                  )),
              SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(product?.name ?? "",
                    style: Constants.getTitleTextStyle(35)),
                Constants.getCartAction(context, Constants.accent),
              ]),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRichText(
                      "Price", "\t\t\t\t${product?.price.toString()} Ks"),
                  _buildRichText("Size", "\t\t\t\t${product?.size}"),
                  _buildRichText("Promo", "\t\t\t\tCoca Cola"),
                ],
              ),
              Text(Constants.sampleText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Constants.normal, fontSize: 16)),
              Table(
                border: TableBorder.all(color: Constants.normal),
                children: [
                  TableRow(children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Features",
                            style: TextStyle(
                                color: Constants.secondary, fontSize: 18)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Text("Value",
                            style: TextStyle(
                                color: Constants.secondary, fontSize: 18)),
                      ),
                    ),
                  ]),
                  _buildTableRow("Size", "Medium"),
                  _buildTableRow("Guidl", "123"),
                  _buildTableRow("Test", "Red"),
                  _buildTableRow("Blest", "Guset"),
                ],
              ),
              SizedBox(height: 10),
              Text(Constants.sampleText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Constants.normal, fontSize: 16)),
              Text("Warranty",
                  style: TextStyle(color: Constants.normal, fontSize: 25)),
              SizedBox(height: 10),
              Image.network(
                  "http://192.168.8.103:3000/uploads/Daily_Delivery_1625048001786.png"),
              SizedBox(height: 20),
              Text("Delivery",
                  style: TextStyle(color: Constants.normal, fontSize: 25)),
              SizedBox(height: 10),
              Image.network(
                  "http://192.168.8.103:3000/uploads/Daily_Delivery_1625048001786.png")
            ]),
          ),
        ));
  }

  TableRow _buildTableRow(text1, text2) {
    return TableRow(children: [
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(text1,
              style: TextStyle(color: Constants.normal, fontSize: 16)),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(text2,
              style: TextStyle(color: Constants.normal, fontSize: 16)),
        ),
      ),
    ]);
  }

  Widget _buildRichText(text1, text2) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "$text1\n",
          style: TextStyle(
              color: Constants.normal, fontSize: 35, fontFamily: "English")),
      TextSpan(
          text: "$text2",
          style: TextStyle(
              color: Constants.accent, fontSize: 18, fontFamily: "English"))
    ]));
  }
}
