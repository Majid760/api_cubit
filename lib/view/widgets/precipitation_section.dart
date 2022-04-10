import 'package:api_cubit/view/widgets/section_header_widget.dart';
import 'package:flutter/material.dart';

class PrecipitationSection extends StatelessWidget {
  const PrecipitationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 140,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SectionHeaderWidget(
              headerTitle: "Precipitation",
              iconData: Icons.view_week_sharp,
            ),
            const Divider(
              thickness: 2,
              color: Colors.white,
            ),
            Expanded(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('60%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Icon(Icons.add_location_alt_sharp,
                          size: 24, color: Colors.white),
                      Text(
                        'Evening',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 0,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('60%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Icon(Icons.add_location_alt_sharp,
                          size: 24, color: Colors.white),
                      Text(
                        'Afternoon',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 0,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('60%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Icon(Icons.add_location_alt_sharp,
                          size: 24, color: Colors.white),
                      Text(
                        'Overnight',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    width: 20,
                    thickness: 1,
                    indent: 10,
                    endIndent: 0,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('75%',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Icon(Icons.add_location_alt_sharp,
                          size: 24, color: Colors.white),
                      Text(
                        'Morning',
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ])),
          ],
        ),
      ),
    );
  }
}
