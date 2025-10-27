import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/screens/urgent_add_item_screen.dart';
import 'package:storekeeperapp/widget/appbarwidget/app_bar_full.dart';
import 'package:storekeeperapp/widget/homepagewidgets/card_analysis_item.dart';
import 'package:storekeeperapp/widget/homepagewidgets/card_item.dart';
import 'package:storekeeperapp/widget/homepagewidgets/searchtextfield.dart';


class StorekeeperHomePage extends StatefulWidget {
  const StorekeeperHomePage({super.key});
  

  @override
  State<StorekeeperHomePage> createState() => _StorekeeperHomePageState();
}

class _StorekeeperHomePageState extends State<StorekeeperHomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {

    super.initState();
    //load all items from database when screen start
    Provider.of<ItemProvider>(context, listen: false).loadItem();

    //listen for typing in the search bar 
    _searchController.addListener((){
      setState(() {});
      Provider.of<ItemProvider>(context, listen: false).searchItems(_searchController.text);
    });
    
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //this is the item provider, gets the add items from the Db, 
    final item = context.watch<ItemProvider>().item;


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
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              //custom appbar done at the appbarfull class
              AppBarFull(add: add, checkNotification: () {}),
              SizedBox(height: 25),

              //search bar
              SearchTextfield(
                //removes the search icon onces there is a text in the search bar 
                prefixIcon: _searchController.text.isEmpty? Icon(
                  Icons.search, 
                  color: Theme.of(context).colorScheme.onTertiary,
                ): null,

                //this adds the clear button onces you start typing 
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: (){
                          _searchController.clear();
                          Provider.of<ItemProvider>(context, listen: false).searchItems('');    
                                      
                        },
                        icon: Icon(
                          Icons.clear_outlined,
                          color: Theme.of(context).colorScheme.onTertiary,
                        ),
                      )
                    : null,
                controller: _searchController,
                hint: 'Search Product...',
              ),
              SizedBox(height: 17,),
              
              Row(
                children: [
                  CardAnalysisItem(
                    icon: Icons.inventory_2_rounded,
                    color: Colors.white,
                    value: context.watch<ItemProvider>().formattedTotalProduct.toString(),
                    title: 'TOTAL \nPROODUCT', boxColor: Theme.of(context).colorScheme.secondary, totalColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(width: 12),
                  CardAnalysisItem(
                    icon: Icons.shopping_bag_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    value: context.watch<ItemProvider>().formattedTotalQuantity.toString(),
                    title: 'TOTAL \nQUANTITY', boxColor: Theme.of(context).colorScheme.onSecondary, totalColor: Theme.of(context).colorScheme.onTertiary,
                  ),
                  SizedBox(width: 12),
                  CardAnalysisItem(
                    icon: Icons.monetization_on_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    value: context.watch<ItemProvider>().formattedTotalPrice,
                    title: 'TOTAL \nPRICE ', boxColor:Theme.of(context).colorScheme.onSecondary, totalColor: Theme.of(context).colorScheme.onTertiary,
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(children: [Text('data'),Spacer(), Text('data') ],),
              
              Expanded(
                flex: 5,
                child: item.isEmpty
                    ? Center(
                        child: Text(
                          'No Items yet',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
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
                            qty: '${item[index].quantity}',
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
