import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
// import 'package:storekeeperapp/screens/add_item_screen.dart';
import 'package:storekeeperapp/screens/urgent_add_item_screen.dart';
import 'package:storekeeperapp/widget/addItem/add_item_textfield.dart';
import 'package:storekeeperapp/widget/appbarwidget/app_bar_full.dart';

import 'package:storekeeperapp/widget/card_item.dart';

class StorekeeperHomePage extends StatelessWidget {
  const StorekeeperHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //this is the item provide, where we operate the CRUD operation
    final item = context.watch<ItemProvider>().item;

    final TextEditingController _searchController = TextEditingController();

    //this functions takes us to the add product and waits for the values receieved
    Future<void> add() async {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (ctx) => UrgentAddItemScreen()),
      );
      await context.read<ItemProvider>().loadItem();
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              //custom appbar done at the appbarfull class
              AppBarFull(add: add, checkNotification: () {}),
              SizedBox(height: 25),

              //search bar
              AddItemTextfield(
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                controller: _searchController,
                hint: 'Search Product...',
              ),
              // TextField(
              //     decoration: InputDecoration(
              //       hintText: 'Search Product...',
              //       prefixIcon: Icon(
              //         Icons.search,
              //         color: Theme.of(context).colorScheme.onPrimary,
              //       ),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         borderSide: BorderSide(
              //           color: Theme.of(context).colorScheme.onPrimary,
              //         ),
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(12),
              //         borderSide: BorderSide(
              //           color: Theme.of(context).colorScheme.onPrimary,
              //         ),
              //       ),
              //       hintStyle: TextStyle(
              //         color: Theme.of(context).colorScheme.onPrimary,
              //         fontSize: 15,
              //       ),
              //       contentPadding: EdgeInsets.symmetric(vertical: 10)
              //     ),
              //   ),
              Expanded(
                flex: 5,
                child: item.isEmpty
                    ? Center(
                        child: Text(
                          'No Items yet',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: item.length,
                          itemBuilder: (ctx, index) => CardItem(
                            title: item[index].name,
                            qty: 'Qty: ${item[index].quantity}',
                            price: 'Price: \$${item[index].price}',
                            item: item[index],
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
