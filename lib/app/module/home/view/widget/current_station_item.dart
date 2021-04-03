/*
 * @author kevin
 * @date 2021/4/3 14:05
 * @Description: flutter
*/
import 'package:flutter/material.dart';

class CurrentStationItem extends StatelessWidget {
  final String title;
  final String station;
  final VoidCallback onTapItem;
  final IconData iconData;

  const CurrentStationItem(
      {Key key, this.title, this.station, this.onTapItem, this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem?.call();
      },
      child: Container(
        alignment: Alignment.center,
        width: 80,
        decoration: BoxDecoration(
            // color: Colors.white,
            // borderRadius: BorderRadius.circular(6),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: Colors.white,
            ),
            // Text(
            //   '$title',
            //   style: TextStyle(fontSize: 12),
            // ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$station',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '$title',
              style: TextStyle(fontSize: 12,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
