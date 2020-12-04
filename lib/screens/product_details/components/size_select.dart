import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tech_task_flutter/models/product.dart';
import 'package:tech_task_flutter/product_store.dart';

class SizeSelect extends StatelessWidget {
  SizeSelect({
    Key key,
    @required this.product,
    @required this.addToBasket,
  }) : super(key: key);

  final Product product;
  final Size sizeStore = Size();
  final VoidCallback addToBasket;

  @override
  Widget build(BuildContext sizeSelectContext) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          Expanded(
              child: Container(
                  child: Text('SELECT A SIZE'),
                  padding: EdgeInsets.only(left: 20))),
          Align(
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  semanticLabel: "Close size chooser",
                ),
                onPressed: () => Navigator.pop(sizeSelectContext),
              ),
              alignment: Alignment.centerRight)
        ],
      ),
      Container(
        padding: EdgeInsets.all(10),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 60,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemCount: product.sizes.length,
            itemBuilder: (context, index) {
              return Observer(builder: (_) {
                final size = product.sizes[index];
                return size == sizeStore.selectedSize
                    ? FlatButton(
                  onPressed: () {
                    sizeStore.changeSelectedSize(size);
                  },
                  child: Text(size,
                      style: TextStyle(fontSize: 16)),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
                    : OutlineButton(
                    onPressed: () {
                      sizeStore.changeSelectedSize(size);
                    },
                    child: Text(size,
                        style: TextStyle(fontSize: 16)));
              });
            }),
      ),
      Row(children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    addToBasket();
                  },
                  child: Text('ADD TO BAG'),
                )))
      ]),
    ]);
  }
}
