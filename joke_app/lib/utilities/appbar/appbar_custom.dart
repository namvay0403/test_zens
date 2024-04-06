import 'package:flutter/material.dart';

PreferredSize customAppBar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              radius: 35,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Handcrafted by',
                      style: TextStyle(color: Colors.grey.withOpacity(0.9)),
                    ),
                    const Text('Jim HLS'),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                  radius: 35,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
