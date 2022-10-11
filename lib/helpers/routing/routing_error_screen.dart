//

import 'package:flutter/material.dart';
import 'package:my_budget/styling/topology.dart';

class RoutingErrorScreen extends StatelessWidget {
  const RoutingErrorScreen({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routing Error'),
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: Topology.title,
        ),
      ),
    );
  }
}
