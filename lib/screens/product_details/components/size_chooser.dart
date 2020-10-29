import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_iota_tech_task/models/product.dart';

class SizeChooser extends StatefulWidget {
  final Product product;

  SizeChooser({@required this.product});

  @override
  _SizeChooserState createState() => _SizeChooserState();
}

class _SizeChooserState extends State<SizeChooser> {
  String _selectedSize;

  void _changeSelectedSize(String size) {
    setState(() {
      _selectedSize = size;
    });
  }

  @override
  Widget build(BuildContext sizeChooserContext) {
    return ElevatedButton(
        child: Text('ADD TO BAG'),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (modalContext) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalState) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                              child: Text('SELECT A SIZE'),
                              padding: EdgeInsets.only(left: 20))),
                      Align(
                          child: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                          alignment: Alignment.centerRight)
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: widget.product.sizes.length,
                          itemBuilder: (context, index) {
                            final size = widget.product.sizes[index];
                            if (size == _selectedSize) {
                              return FlatButton(
                                onPressed: () {
                                  modalState(() {
                                    _changeSelectedSize(size);
                                  });
                                },
                                child: Text(size),
                                color: Colors.blue,
                                textColor: Colors.white,
                              );
                            } else {
                              return OutlineButton(
                                  onPressed: () {
                                    modalState(() {
                                      _changeSelectedSize(size);
                                    });
                                  },
                                  child: Text(size));
                            }
                          })),
                  Row(children: [
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Scaffold.of(sizeChooserContext)
                                    .showSnackBar(SnackBar(
                                  content: Text("Added to bag"),
                                  behavior: SnackBarBehavior.floating,
                                ));
                              },
                              child: Text('ADD TO BAG'),
                            )))
                  ]),
                ]);
              });
            },
          );
        });
  }
}
