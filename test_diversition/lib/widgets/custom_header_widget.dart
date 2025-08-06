import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:test_diversition/models/user_model.dart';
import 'package:test_diversition/widgets/random_shape_widget.dart';

class CustomerHeader extends StatelessWidget {
  final User? users;

  const CustomerHeader({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: OverflowBox(
            maxWidth: double.infinity,
            maxHeight: double.infinity,
            child: RandomShapeAnimation(size: Get.width * 0.3),
          ),
        ),

        Container(
          height: 120 + MediaQuery.of(context).padding.top,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(users?.profileImage ?? ""),
                onBackgroundImageError: (exception, stackTrace) {},
                child:
                    users?.profileImage == ""
                        ? const Icon(Icons.person, size: 40, color: Colors.blue)
                        : null,
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${users?.firstName}  ${users?.lastName}",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    users?.email ?? "",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
