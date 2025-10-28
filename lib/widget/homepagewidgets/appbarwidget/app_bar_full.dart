import 'package:flutter/material.dart';
import 'package:storekeeperapp/widget/homepagewidgets/appbarwidget/app_bar_button.dart';
import 'package:storekeeperapp/widget/homepagewidgets/appbarwidget/app_bar_text.dart';

class AppBarFull extends StatelessWidget {
  const AppBarFull({super.key, required this.add, required this.checkNotification});

  final void Function() add;
  final void Function() checkNotification;

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarText(
                        title: 'Welcome, Gladstone',
                        textStyle: Theme.of(context).textTheme.welcomeTheme,
                      ),
                      AppBarText(
                        title: 'Store Keeper',
                        textStyle: Theme.of(context).textTheme.subTitle,
                      ),
                    ],
                  ),
                  Spacer(),
                  AppBarButton(
                    icon: Icons.notifications_outlined,
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: checkNotification,
                  ),

                  SizedBox(width: 10),
                  AppBarButton(
                    icon: Icons.add,
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: add,
                    iconColor: Theme.of(context).colorScheme.primary,
                  ),
                ],
              );
  }
}
