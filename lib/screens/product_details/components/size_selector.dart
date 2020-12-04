import 'package:flutter/material.dart';
import 'package:tech_task_flutter/models/product.dart';

class SizeSelector extends StatefulWidget {
  final Product product;
  final VoidCallback callback;

  SizeSelector({@required this.product, @required this.callback});

  @override
  _SizeSelectorState createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String _selectedSize;

  void _changeSelectedSize(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () => Navigator.pop(context),
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
              itemCount: widget.product.sizes.length,
              itemBuilder: (context, index) {
                final size = widget.product.sizes[index];
                if (size == _selectedSize) {
                  return FlatButton(
                    onPressed: () {
                      _changeSelectedSize(size);
                    },
                    child: Text(size, style: TextStyle(fontSize: 16)),
                    color: Colors.blue,
                    textColor: Colors.white,
                  );
                } else {
                  return OutlineButton(
                      onPressed: () {
                        _changeSelectedSize(size);
                      },
                      child: Text(size, style: TextStyle(fontSize: 16)));
                }
              })),
      Row(children: [
        Expanded(
            child: Container(
                padding: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    widget.callback();
                  },
                  child: Text('ADD TO BAG'),
                )))
      ]),
    ]);
  }
}
