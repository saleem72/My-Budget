//

import 'package:flutter/material.dart';
import 'package:my_budget/models/dialog_option.dart';

import '../helpers/utilities.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({
    Key? key,
    required this.child,
    required this.onClose,
    required this.operation,
  }) : super(key: key);
  final Widget child;
  final Function onClose;
  final DialogOperation operation;
  @override
  State<DialogScreen> createState() => _DialogScreenState();
}

class _DialogScreenState extends State<DialogScreen>
    with TickerProviderStateMixin {
  late AnimationController _animation;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _initAmination();
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DialogScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // setState(() {});
    if (widget.operation == DialogOperation.save ||
        widget.operation == DialogOperation.cancel) {
      _close(context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // setState(() {});
    if (widget.operation == DialogOperation.save ||
        widget.operation == DialogOperation.cancel) {
      _close(context);
    }
  }

  void _initAmination() {
    // final double totalHeight = MediaQuery.of(context).size.height;
    _animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onClose();
        }
      });

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animation,
      curve: const Interval(
        0,
        0.6,
        curve: Curves.easeIn,
      ),
    ));

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -500),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animation,
        curve: const Interval(
          0.4,
          1,
          curve: Curves.bounceInOut,
        ),
      ),
    );

    _animation.forward();
  }

  _close(BuildContext context) {
    Utilities.closeKeyboard(context);
    _animation.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBuilder(
        animation: _opacityAnimation,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Opacity(
                opacity: _opacityAnimation.value,
                child: _buildBackground(),
              ),
              Transform.translate(
                offset: _offsetAnimation.value,
                child: _buildContent(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: const Offset(4, 4),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return GestureDetector(
      onTap: () => _close(context),
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: widget.operation == DialogOperation.cancel
            ? Colors.black.withOpacity(0.4)
            : Colors.black.withOpacity(0.2),
      ),
    );
  }
}
