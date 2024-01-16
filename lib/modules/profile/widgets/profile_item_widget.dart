import 'package:divar/helpers/widgets/sizedbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileItemWidget extends StatelessWidget {
  const ProfileItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;

  final String title;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: 17),
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 3),
                blurRadius: 10,
                color: const Color(0xff000000).withOpacity(0.1),
              )
            ],
            color: Colors.white,
          ),
          child: Row(
            children: <Widget>[
              const W(14),
              Icon(icon),
              const W(13),
              Text(
                title,
                style: context.textTheme.titleMedium,
              ),
              const Spacer(),
              const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.black,
              ),
              const W(16),
            ],
          ),
        ),
      ),
    );
  }
}
