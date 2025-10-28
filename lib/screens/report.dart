import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storekeeperapp/provider/item_provider.dart';
import 'package:storekeeperapp/widget/inventorywidgets/empty_text.dart';
import 'package:storekeeperapp/widget/inventorywidgets/inventory_summary_card.dart';
import 'package:storekeeperapp/widget/inventorywidgets/section_header.dart';
import 'package:storekeeperapp/widget/inventorywidgets/stock_tile.dart';

class Report extends StatelessWidget {
  const Report({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = context.watch<ItemProvider>();
    final items = itemProvider.item;

    

    final lowStockItems = itemProvider.lowStockItems;
    final highStockItems = itemProvider.highStockItems;

    return Scaffold(
      appBar: AppBar(title: const Text("Inventory Report"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InventorySummaryCard(
                  icon: Icons.inventory_2_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  value: context
                      .watch<ItemProvider>()
                      .formattedTotalProduct
                      .toString(),
                  title: 'TOTAL \nPROODUCT',

                  totalColor: Theme.of(context).colorScheme.tertiary,
                  boxColor: Theme.of(context).colorScheme.secondary,
                ),
                InventorySummaryCard(
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
                InventorySummaryCard(
                  icon: Icons.monetization_on_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    value: context.watch<ItemProvider>().formattedTotalPrice,
                    title: 'TOTAL \nPRICE ',
                    boxColor: Theme.of(context).colorScheme.onSecondary,
                    totalColor: Theme.of(context).colorScheme.onTertiary,
                ),
              ],
            ),
            const SizedBox(height: 25),

            SectionHeader(title:  "⚠️ Low Stock (<10)"),
            if (lowStockItems.isEmpty)
              EmptyText(text: "No low stock items 🎉")
            else
              ...lowStockItems.map(
                (item) => StockTile(
                  item: item,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),

            const SizedBox(height: 25),

            SectionHeader(title:  "📦 Overstock (>100)"),
            if (highStockItems.isEmpty)
              EmptyText(text:  "No overstocked items 😎")
            else
              ...highStockItems.map(
                (item) => StockTile( item: item, color:  Colors.green),
              ),

            const SizedBox(height: 25),

            Text(
              "Inventory Overview",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            LinearProgressIndicator(
              value: items.isNotEmpty ? lowStockItems.length / items.length : 0,
              backgroundColor: Colors.grey[300],
              color: Theme.of(context).colorScheme.onError,
              minHeight: 8,
            ),
            const SizedBox(height: 6),
            Text(
              "Low stock items: ${lowStockItems.length} / ${items.length}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}