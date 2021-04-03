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

  const CurrentStationItem({Key key, this.title, this.station, this.onTapItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapItem?.call();
      },
      child: Container(
        width: 100,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title',
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              '$station',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
