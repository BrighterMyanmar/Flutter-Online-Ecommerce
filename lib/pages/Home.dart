import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:foodmonkey/models/Category.dart';
import 'package:foodmonkey/pages/ProductPage.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            InkWell(
                onTap: () {
                  if (Constants.user == null) {
                    Navigator.pushNamed(context, "/login");
                  } else {
                    Navigator.pushNamed(context, "/chat");
                  }
                },
                child: Icon(Icons.chat)),
            InkWell(
                onTap: () => Navigator.pushNamed(context, "/record"),
                child: Icon(Icons.history))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTitleBar("Tags"),
            Container(
                height: 150,
                child: Swiper(
                  index: 0,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      loadName: Constants.tags[index].name,
                                      type: "Tag",
                                    )));
                      },
                      child: Image.network(
                        Constants.getImageLink(Constants.tags[index].image),
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  autoplay: true,
                  itemCount: Constants.tags.length,
                  scrollDirection: Axis.horizontal,
                  pagination:
                      SwiperPagination(alignment: Alignment.centerRight),
                  control: SwiperControl(),
                )),
            _buildTitleBar("Categories"),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 1, right: 1),
                  itemCount: Constants.cats.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) =>
                      _buildCategoryCard(Constants.cats[index])),
            )
          ],
        ));
  }

  Widget _buildCategoryCard(Category cat) {
    return InkWell(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductPage(
                        loadName: cat.name,
                        type: "Category",
                      )));
        });
      },
      child: Card(
          child: Column(
        children: [
          Text(cat.name ?? "",
              style: TextStyle(
                color: Constants.normal,
                fontSize: 16,
              )),
          SizedBox(height: 10),
          Container(
            height: 90,
            child: Image.network(Constants.getImageLink(cat.image)),
          )
        ],
      )),
    );
  }

  Widget _buildTitleBar(String text) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Constants.secondary,
          borderRadius: BorderRadius.only(topRight: Radius.circular(80))),
      child: Text(text,
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Constants.normal)),
    );
  }
}
