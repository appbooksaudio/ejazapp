import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../rectangularButton.dart';

class ProfileDetailsSection extends StatelessWidget {
  const ProfileDetailsSection({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);

    final Color grey = Color(0xffA8A8A8);

    final TextStyle f13Font =
        TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffD9D9D9),
              image: DecorationImage(
                  image: CachedNetworkImageProvider(user['profileUrl']??''))),
        ),
        SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sophia Brown',
              style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
            ),
            Text(
              'Last seen 2 hours ago',
              style: f13Font,
            ),
          ],
        ),
        const Spacer(),
        RectangularButton(
          child: Icon(Icons.search),
        )
      ],
    );
  }
}
