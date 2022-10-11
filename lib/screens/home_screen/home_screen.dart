// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_budget/screens/home_screen/models/home_screen_button.dart';

import 'package:my_budget/styling/styling.dart';

import '../../database/buget_database_cubit/budget_database_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _actionFor(HomeScreenButton button) {
    print(button.label);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double totalHeight = (size.height - kToolbarHeight - 24);
    final cardHeight = ((totalHeight * 0.65)) / 2;
    final double itemWidth = size.width / 2;
    final database = context.read<BudgetDatabaseCubit>().database;
    return Scaffold(
      // backgroundColor: Pallet.background,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: Topology.title,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: totalHeight * 0.65,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / cardHeight),
              children: <Widget>[
                for (final button in HomeScreenButton.values)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Pallet.card,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: RoundedButton(
                        onPressed: (item) {},
                        button: button,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: totalHeight * 0.35,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 16, right: 8),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Pallet.appBar,
                      child: Container(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin:
                        const EdgeInsets.only(bottom: 16, left: 8, right: 16),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white,
                      child: Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SizedBox _mainActions() {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final button in HomeScreenButton.values)
              RoundedButton(
                onPressed: (p0) => _actionFor(p0),
                button: button,
              ),
          ],
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    this.outlineThikness = 4,
    required this.button,
    required this.onPressed,
  }) : super(key: key);

  final double outlineThikness;
  final HomeScreenButton button;
  final Function(HomeScreenButton) onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed.call(button),
      child: Container(
        margin: const EdgeInsets.all(4),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 75,
                  height: 75,
                  child: CircleStrip(
                    outlineThikness: 6,
                    fillColor: button.color,
                  ),
                ),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: Center(
                    child: Icon(button.icon),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
              child: Text(
                button.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleStrip extends StatelessWidget {
  const CircleStrip({
    Key? key,
    required this.outlineThikness,
    required this.fillColor,
  }) : super(key: key);

  final double outlineThikness;
  final Color fillColor;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CircleStripPath(
          outlineThikness: outlineThikness, fillColor: fillColor),
    );
  }
}

class CircleStripPath extends CustomPainter {
  final double outlineThikness;
  final Paint outlinePaint;
  CircleStripPath({
    required this.outlineThikness,
    required Color fillColor,
  }) : outlinePaint = Paint()..color = fillColor;
  @override
  void paint(Canvas canvas, Size size) {
    final dotCenter = size.center(Offset.zero);
    final dotRadiud = (size.width - 16) / 2;
    Path outlinePath = Path()
      ..addOval(Rect.fromCircle(center: dotCenter, radius: dotRadiud))
      ..addOval(Rect.fromCircle(
          center: dotCenter, radius: dotRadiud - outlineThikness))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(outlinePath, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
