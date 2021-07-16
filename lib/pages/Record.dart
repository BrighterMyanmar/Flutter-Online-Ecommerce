import 'package:flutter/material.dart';
import 'package:foodmonkey/models/History.dart';
import 'package:foodmonkey/utils/Api.dart';
import 'package:foodmonkey/utils/Constants.dart';

class Record extends StatefulWidget {
  const Record({Key? key}) : super(key: key);

  @override
  _RecordState createState() => _RecordState();
}

class _RecordState extends State<Record> {
  List<History> hs = [];
  loadHistory() async {
    List<History> hss = await Api.getMyOrders();
    setState(() {
      hs = hss;
      print(hs.length);
    });
  }

  @override
  void initState() {
    super.initState();
    loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("History")),
        body: ListView.builder(
            itemCount: hs.length,
            itemBuilder: (context, index) => _buildExpansionTile(hs[index])));
  }

  Container _buildExpansionTile(var odr) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      color: Constants.normal,
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(odr.created.split("T")[0],
                style: TextStyle(
                    color: Constants.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            RaisedButton(
                onPressed: () {},
                color: Constants.normal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text(odr.total.toString(),
                    style: TextStyle(color: Constants.primary)))
          ],
        ),
        children: [
          ...List.generate(
              odr.items.length, (index) => _buildHistoryCard(odr.items[index]))
        ],
      ),
    );
  }

  Container _buildHistoryCard(var item) {
    return Container(
      child: Card(
        color: Constants.accent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.network(Constants.getImageLink(item.images[0]),
                width: 80, height: 80),
            Column(
              children: [
                Text(item.name,
                    style: TextStyle(
                        color: Constants.primary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
                Text("${item.count} * ${item.price}",
                    style: TextStyle(
                        color: Constants.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            RaisedButton(
                onPressed: () {},
                color: Constants.normal,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Text("${item.count * item.price}",
                    style: TextStyle(color: Constants.primary)))
          ],
        ),
      ),
    );
  }
}
