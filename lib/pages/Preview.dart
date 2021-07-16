import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/models/Product.dart';
import 'package:foodmonkey/pages/Detail.dart';
import 'package:foodmonkey/utils/Constants.dart';
import 'dart:math' as math;

class Preview extends StatefulWidget {
  final Product? product;
  const Preview({Key? key, this.product}) : super(key: key);

  @override
  _PreviewState createState() => _PreviewState(product);
}

class _PreviewState extends State<Preview> {
  Product? product;
  _PreviewState(this.product);
  @override
  Widget build(BuildContext context) {
    var msize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Preview"),
          actions: [Constants.getCartAction(context, Constants.primary)],
        ),
        body: Stack(
          children: [
            CustomPaint(
              painter: ArchPainter(msize),
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Text(product?.name ?? "",
                    style: Constants.getTitleTextStyle(35.0)),
              ),
              SizedBox(height: 20),
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
              SizedBox(height: 40),
              _buildRichText("Price", "\t\t\t\t\t3500Ks"),
              SizedBox(height: 40),
              _buildRichText("Size", "\t\t\t\tLarge Size"),
              SizedBox(height: 40),
              _buildRichText("Promo", "\t\t\t\tCoca Cola"),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      color: Constants.normal,
                      onPressed: () {
                        setState(() {
                          Constants.addToCart(product);
                        });
                      },
                      child: Row(children: [
                        Icon(Icons.shopping_cart,
                            color: Constants.primary, size: 40),
                        SizedBox(width: 20),
                        Text("Buy Now",
                            style: TextStyle(
                                color: Constants.primary, fontSize: 20))
                      ])),
                  FlatButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      color: Constants.normal,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Detail(product: product)));
                      },
                      child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 7),
                          child: Text("Detail",
                              style: TextStyle(
                                  color: Constants.primary, fontSize: 20)),
                        )
                      ])),
                ],
              ),
            ])
          ],
        ));
  }

  Widget _buildRichText(text1, text2) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "$text1\n",
            style: TextStyle(
                color: Constants.primary, fontSize: 40, fontFamily: "English")),
        TextSpan(
            text: "$text2",
            style: TextStyle(
                color: Constants.normal, fontSize: 18, fontFamily: "English"))
      ])),
    );
  }
}

class ArchPainter extends CustomPainter {
  var msize;
  ArchPainter(this.msize);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = new Paint();
    paint.color = Constants.secondary;

    final rect = Rect.fromLTRB(-550, 100, msize.width + 5, msize.height + 500);

    final startAngle = -degreeToRadian(100);
    final sweepAngle = degreeToRadian(300);
    final useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint);
  }

  degreeToRadian(value) {
    return value * (math.pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
