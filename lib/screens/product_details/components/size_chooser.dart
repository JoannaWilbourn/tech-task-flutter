import 'package:flutter/material.dart';
import 'package:tech_task_flutter/screens/product_details/components/size_selector.dart';
import 'package:tech_task_flutter/models/product.dart';

class SizeChooser extends StatelessWidget {
  final Product product;

  SizeChooser({@required this.product});

  @override
  Widget build(BuildContext sizeChooserContext) {
    return ElevatedButton(
        child: Text('ADD TO BAG'),
        onPressed: () {
          showModalBottomSheet(
            context: sizeChooserContext,
            builder: (context) {
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter modalState) {
                return SizeSelector(
                    product: product,
                    callback: () {
                      Navigator.pop(context);
                      Scaffold.of(sizeChooserContext).showSnackBar(SnackBar(
                        content: Text("Added to bag"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Theme.of(context).primaryColor,
                      ));
                    });
              });
            },
          );
        });
  }
}
