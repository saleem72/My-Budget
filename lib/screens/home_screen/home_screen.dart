// ignore_for_file: public_member_api_docs, sort_constructors_first
//

import 'package:flutter/material.dart';
import 'package:my_budget/helpers/localization/language_constants.dart';
import 'package:my_budget/helpers/routing/nav_links.dart';
import 'package:my_budget/screens/home_screen/models/home_more_menu_item.dart';
import 'package:my_budget/screens/home_screen/models/home_screen_button.dart';

import 'package:my_budget/styling/styling.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _actionFor(BuildContext context, {required HomeScreenButton button}) {
    switch (button) {
      case HomeScreenButton.bill:
        break;
      case HomeScreenButton.diary:
        Navigator.of(context).pushNamed(NavLinks.journal);
        break;
      case HomeScreenButton.accountStatment:
        Navigator.of(context).pushNamed(NavLinks.accountStatment);
        break;
      case HomeScreenButton.budget:
        break;
    }
  }

  void _actionForMenuItem(BuildContext context,
      {required HomeMoreMenuItem item}) {
    switch (item) {
      case HomeMoreMenuItem.subjects:
        Navigator.of(context).pushNamed(NavLinks.subjects);
        break;
      case HomeMoreMenuItem.accounts:
        Navigator.of(context).pushNamed(NavLinks.accounts);
        break;
      case HomeMoreMenuItem.settings:
        Navigator.of(context).pushNamed(NavLinks.settings);
        break;
      case HomeMoreMenuItem.about:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusbarHeight = MediaQuery.of(context).viewPadding.top;

    final double totalHeight = (size.height - kToolbarHeight - statusbarHeight);
    final cardHeight = ((totalHeight * 0.60)) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.home,
          style: Topology.title,
        ),
        centerTitle: true,
        leading: _searchButton(),
        actions: [
          _moreMenu(context),
        ],
      ),
      body: Column(
        children: [
          _summarySection(totalHeight),
          _mainActions(totalHeight, itemWidth, cardHeight),
        ],
      ),
    );
  }

  PopupMenuButton<HomeMoreMenuItem> _moreMenu(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      offset: const Offset(0, kToolbarHeight),
      onSelected: (item) => _actionForMenuItem(context, item: item),
      itemBuilder: (context) => HomeMoreMenuItem.values
          .map((e) => PopupMenuItem(
              value: e,
              child: PopupMenuItemCard(
                title: e.title(context),
                icon: e.icon,
              )))
          .toList(),
    );
  }

  IconButton _searchButton() {
    return IconButton(
      onPressed: () {},
      icon: const Icon(
        Icons.search,
        size: 20,
      ),
    );
  }

  Widget _summarySection(double totalHeight) {
    return SizedBox(
      height: totalHeight * 0.4,
      child: Row(
        children: [
          _balance(),
          _expenses(),
        ],
      ),
    );
  }

  Widget _expenses() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8, right: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assests.category,
                      width: 16,
                      height: 16,
                      color: Pallet.appBar,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Translator.translation(context).categories_tag,
                      style: Topology.darkSmallBody,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _balance() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 16, right: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: Pallet.appBar,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      Assests.money,
                      width: 16,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      Translator.translation(context).balance_tag,
                      style: Topology.lightSmallBody,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _mainActions(double totalHeight, double itemWidth, double cardHeight) {
    return SizedBox(
      height: totalHeight * 0.60,
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
                  onPressed: (item) => _actionFor(context, button: item),
                  button: button,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PopupMenuItemCard extends StatelessWidget {
  const PopupMenuItemCard({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        Text(title),
      ],
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
                    child: Image.asset(
                      button.icon,
                      width: 18,
                      height: 18,
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                button.label(context),
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
