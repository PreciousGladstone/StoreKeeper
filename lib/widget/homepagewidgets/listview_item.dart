import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/widget/homepagewidgets/card_dismissible.dart';

class ListviewItem extends StatelessWidget {
  const ListviewItem({super.key});

  @override
  Widget build(BuildContext context) {
    final item = context.watch<ItemProvider>().item;

    //list view builder that displays on the home screen
    return Expanded(
      flex: 5,
      child: item.isEmpty
          ? Center(
              child: Text(
                'No Items yet',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                itemCount: item.length,
                itemBuilder: (ctx, index) => CardDismissible(
                  title: item[index].name,
                  qty: '${item[index].quantity}',
                  price: 'Price: \$${item[index].price}',
                  item: item[index],
                ),
              ),
            ),
    );
  }
}
