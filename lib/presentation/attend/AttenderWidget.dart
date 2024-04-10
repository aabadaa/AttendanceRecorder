import 'package:flutter/material.dart';

import '../../domain/models/User.dart';
import '../../utils.dart';

class AttenderWidget extends StatefulWidget {
  const AttenderWidget({super.key, required this.user, required this.onClick});

  final AttenderState user;
  final void Function() onClick;

  @override
  State<AttenderWidget> createState() => _AttenderWidgetState();
}

class _AttenderWidgetState extends State<AttenderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text(widget.user.name),
              const Spacer(),
              if (widget.user.attendDate != null)
                Text(getStringFromTime(widget.user.attendDate!)),
              Checkbox(
                value: widget.user.attendDate != null,
                onChanged: (value) => widget.onClick(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
