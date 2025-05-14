import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class InfoRoomSkeleton extends StatelessWidget {
  const InfoRoomSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Card(
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    width: 150,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 20,
                    width: 100,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 20,
                    width: 120,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    height: 20,
                    width: 130,
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
