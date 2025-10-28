import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/screens/add_item_screen.dart';
import 'package:storekeeperapp/widget/homepagewidgets/appbarwidget/app_bar_full.dart';
import 'package:storekeeperapp/widget/homepagewidgets/card_analysis_item.dart';
import 'package:storekeeperapp/widget/homepagewidgets/listview_item.dart';
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
              
              //dynamic stat card , this update the total products , total quantity of products and total prices 
              Row(
                children: [
                  CardAnalysisItem(
                    icon: Icons.inventory_2_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    value: context
                        .watch<ItemProvider>()
                        .formattedTotalProduct
                        .toString(),
                    title: 'TOTAL \nPROODUCT',
                    boxColor: Theme.of(context).colorScheme.secondary,
                    totalColor: Theme.of(context).colorScheme.tertiary,
                  ),
                  SizedBox(width: 12),
                  CardAnalysisItem(
                    icon: Icons.shopping_bag_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    value: context
                        .watch<ItemProvider>()
                        .formattedTotalQuantity
                        .toString(),
                    title: 'TOTAL \nQUANTITY',
                    boxColor: Theme.of(context).colorScheme.onSecondary,
                    totalColor: Theme.of(context).colorScheme.onTertiary,
                  ),
                  SizedBox(width: 12),
                  CardAnalysisItem(
                    icon: Icons.monetization_on_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    value: context.watch<ItemProvider>().formattedTotalPrice,
                    title: 'TOTAL \nPRICE ',
                    boxColor: Theme.of(context).colorScheme.onSecondary,
                    totalColor: Theme.of(context).colorScheme.onTertiary,
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: Text(
                  'Recent Product',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.w600 ,fontSize: 20
                  ),
                ),
              ),
              ListviewItem()
            ],
          ),
        ),
      ),
    );
  }
}
