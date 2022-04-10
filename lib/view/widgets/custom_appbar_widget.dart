import 'package:api_cubit/utility/search_utility.dart';
import 'package:api_cubit/view/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? cityTitle;
  final VoidCallback? trailingPress;
  final VoidCallback? leadingPress;
  final DateTime? dateTime;
  final String? countryTime;
  const AppBarWidget(
      {Key? key,
      @required this.cityTitle,
      this.leadingPress,
      this.trailingPress,
      this.dateTime,
      this.countryTime})
      : super(key: key);
  @override
  Size get preferredSize => const Size.fromHeight(110);
  @override
  Widget build(BuildContext context) {
    // alignment: AlignmentDirectional.bottomCenter,
    return AppBar(
      elevation: 0,
      shadowColor: Colors.white,
      backgroundColor: Colors.transparent,
      centerTitle: true,
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: 15.0),
      //   child: InkWell(
      //     onTap: () {
      //       debugPrint('ledading');
      //     },
      //     child: const Icon(
      //       Icons.menu_outlined,
      //       size: 32,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      title: Column(children: [
        Text(
          cityTitle!,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.normal, color: Colors.white),
        ),
        Text(DateFormat('hh:mm a').format(dateTime!) + ' PK',
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.white)),
      ]),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            child: const Icon(
              Icons.add,
              size: 32,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SearchPage(),
                ),
              );
              // showSearch(
              //   context: context,
              //   delegate: CustomSearchDelegate(),
              // );
            },
          ),
        )
      ],
    );
  }
}
