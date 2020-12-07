import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_task_flutter/models/product.dart';
import 'package:tech_task_flutter/screens/product_details/components/size_select.dart';
import 'package:tech_task_flutter/global_store.dart';

class SizeChooser extends StatelessWidget {
  final Product product;

  SizeChooser({@required this.product});

  @override
  Widget build(BuildContext sizeChooserContext) {
    final Config configStore = Provider.of<Config>(sizeChooserContext);
    return ElevatedButton(
        child: Text('ADD TO BAG'),
        onPressed: () {
          showModalBottomSheet(
            context: sizeChooserContext,
            builder: (context) {
              return SizeSelect(product: product, addToBasket: (){
                configStore.changeHighlightedProduct(product.name.toUpperCase());
                Navigator.pop(context);
                Scaffold.of(sizeChooserContext)
                    .showSnackBar(SnackBar(
                  content: Text("Added to bag"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).primaryColor,
                ));
              });
            },
          );
        });
  }
}

