import 'package:flutter/material.dart';

/// An avatar for the user with their first initial letter
///
/// [initial] must be a single letter
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.initial,
    Key? key,
  })  : assert(initial.length == 1),
        super(key: key);

  final String initial;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: Text(
          initial.toUpperCase(),
          style: const TextStyle(
            fontSize: 40.0,
            color: Colors.white,
          ),
        ),
      );
}
