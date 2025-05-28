import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';
import '../rectangularButton.dart';

class ProfileDetailsSection extends StatefulWidget {
  const ProfileDetailsSection({
    super.key,
    required this.user,
  });

  final Map<String, dynamic> user;

  @override
  State<ProfileDetailsSection> createState() => _ProfileDetailsSectionState();
}

class _ProfileDetailsSectionState extends State<ProfileDetailsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _profileSlideAnimation;
  late Animation<Offset> _searchSlideAnimation;
  bool search = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _profileSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(-1, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _searchSlideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      search = !search;
      if (search) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProv = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final Color grey = Color(0xffA8A8A8);
    final TextStyle f13Font =
    TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: grey);

    return Row(
      children: [
        SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: Tween<double>(begin: 1, end: 0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.easeInOut,
            ),
          ),
          child: SlideTransition(
            position: _profileSlideAnimation,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 44,
                  width: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xffD9D9D9),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                        widget.user['profileUrl'] ?? '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sophia Brown',
                      style: theme.textTheme.headlineMedium?.copyWith(fontSize: 20),
                    ),
                    Text(
                      (widget.user['isGroup'] ?? false)
                          ? '4 people'
                          : 'Last seen 2 hours ago',
                      style: f13Font,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SlideTransition(
            position: _searchSlideAnimation,
            child: Container(
              margin:  EdgeInsets.only(right: 16,left:search?0:60),
              height: 45,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SearchWidget(
                        text: '',
                        onChanged: (value) {},
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SquareButton(
          action: _toggleSearch,
          child: Icon(search ? Icons.clear_outlined : Icons.search),
        ),
      ],
    );
  }
}