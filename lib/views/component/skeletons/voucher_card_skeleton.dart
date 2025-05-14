import 'package:android_hms/views/component/voucher_card.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart'; // Import file của bạn

class VoucherCardSkeleton extends StatelessWidget {
  const VoucherCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: true,
        child: VoucherCard(
            discount: "50%",
            code: "123456",
            expiryDate: DateTime.now().add(Duration(days: 5))));
  }
}
