import 'dart:math';
import 'package:flutter/material.dart';

class RandomShapeAnimation extends StatefulWidget {
  final double size;

  const RandomShapeAnimation({super.key, this.size = 120.0});

  @override
  State<RandomShapeAnimation> createState() => _RandomShapeAnimationState();
}

class _RandomShapeAnimationState extends State<RandomShapeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  // late Animation<Color?> _colorAnimation; // ลบ Color Animation ออก
  late Animation<double> _rotationAnimation;
  late Animation<Offset> _positionAnimation;

  final Random _random = Random();
  ShapeType _currentShape = ShapeType.circle;
  Color _currentColor = Colors.orange;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _sizeAnimation = Tween<double>(
      begin: widget.size * 0.8,
      end: widget.size * 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // ไม่ใช้ _colorAnimation แล้ว
    // _colorAnimation = ColorTween(begin: Colors.orange, end: Colors.deepOrangeAccent).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    // );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _positionAnimation = Tween<Offset>(
      begin: const Offset(-0.5, -0.5),
      end: const Offset(0.5, 0.5),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad),
    );

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed ||
          _controller.status == AnimationStatus.dismissed) {
        _generateRandomShape();
      }
    });

    _generateRandomShape();
  }

  void _generateRandomShape() {
    setState(() {
      _currentShape =
          ShapeType.values[_random.nextInt(ShapeType.values.length)];
      _currentColor = Color.fromRGBO(
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
        1.0,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: _positionAnimation.value * widget.size,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _ShapePainter(
                shape: _currentShape,
                color: _currentColor,
                size: _sizeAnimation.value,
              ),
            ),
          ),
        );
      },
    );
  }
}

enum ShapeType { circle, square, triangle }

class _ShapePainter extends CustomPainter {
  final ShapeType shape;
  final Color color;
  final double size;

  _ShapePainter({required this.shape, required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final center = Offset(canvasSize.width / 2, canvasSize.height / 2);
    final radius = size / 2;

    switch (shape) {
      case ShapeType.circle:
        canvas.drawCircle(center, radius, paint);
        break;
      case ShapeType.square:
        final rect = Rect.fromCenter(center: center, width: size, height: size);
        canvas.drawRect(rect, paint);
        break;
      case ShapeType.triangle:
        final path = Path();
        path.moveTo(center.dx, center.dy - radius);
        path.lineTo(center.dx + radius, center.dy + radius / 2);
        path.lineTo(center.dx - radius, center.dy + radius / 2);
        path.close();
        canvas.drawPath(path, paint);
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ShapePainter oldDelegate) {
    return oldDelegate.shape != shape ||
        oldDelegate.color != color || // ตรวจสอบการเปลี่ยนสีด้วย
        oldDelegate.size != size;
  }
}
