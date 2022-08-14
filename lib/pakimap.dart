import 'dart:math' as math;
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';

class PakiMap extends StatefulWidget {
  @override
  _PakiMapState createState() => _PakiMapState();
}

class _PakiMapState extends State<PakiMap> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double circles = 5.0;
  bool showDots = false, showPath = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _controller.value = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pakistan Map'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, snapshot) {
                    return Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 20,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: CustomPaint(
                          painter: MapPainter(
                            progress: _controller.value,
                            showDots: showDots,
                            showPath: showPath,
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: Text('Show Dots'),
                ),
                Switch(
                  value: showDots,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      showDots = value;
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 0.0),
                  child: Text('Show Path'),
                ),
                Switch(
                  activeColor: Colors.green,
                  value: showPath,
                  onChanged: (value) {
                    setState(() {
                      showPath = value;
                    });
                  },
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Text('Progress'),
            ),
            Slider(
              activeColor: Colors.green,
              inactiveColor: Colors.grey,

              value: _controller.value,
              min: 0.0,
              max: 1.0,
              onChanged: (value) {
                setState(() {
                  _controller.value = value;
                });
              },
            ),
            Center(
              child: RaisedButton(
                color: Colors.green,
                child: Text('Animate'),
                onPressed: () {
                  _controller.reset();
                  _controller.forward();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MapPainter extends CustomPainter {
  MapPainter({required this.progress, required this.showDots, required this.showPath,});

  final double progress;
  bool showDots, showPath;

  var myPaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.5;

  Paint thumbPaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;


  @override
  void paint(Canvas canvas, Size size) {

    var path = createMap(size);
    
    PathMetric pathMetric = path.computeMetrics().first;
    Path extractPath =
    pathMetric.extractPath(0.0, pathMetric.length * progress);
    if (showPath) {
      canvas.drawPath(extractPath, myPaint);
    }
    if (showDots) {
      try {
        var metric = extractPath.computeMetrics().first;
        final offset = metric.getTangentForOffset(metric.length)!.position;
        canvas.drawCircle(offset, 8.0, Paint()..color = Colors.green);
      } catch (e) {}
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}



Path createMap(Size size) {
  var path = Path();

  path.moveTo(size.width * 0.71, 0);
  path.cubicTo(size.width * 0.71, 0, size.width * 0.71, 0, size.width * 0.72, size.height * 0.01);
  path.cubicTo(size.width * 0.72, size.height * 0.01, size.width * 0.73, size.height * 0.02, size.width * 0.73, size.height * 0.01);
  path.cubicTo(size.width * 0.74, size.height * 0.01, size.width * 0.75, size.height * 0.01, size.width * 0.76, size.height * 0.03);
  path.cubicTo(size.width * 0.76, size.height * 0.03, size.width * 0.76, size.height * 0.03, size.width * 0.77, size.height * 0.04);
  path.cubicTo(size.width * 0.79, size.height * 0.05, size.width * 0.81, size.height * 0.06, size.width * 0.82, size.height * 0.09);
  path.cubicTo(size.width * 0.83, size.height * 0.11, size.width * 0.84, size.height * 0.11, size.width * 0.86, size.height * 0.12);
  path.cubicTo(size.width * 0.86, size.height * 0.12, size.width * 0.86, size.height * 0.13, size.width * 0.86, size.height * 0.14);
  path.cubicTo(size.width * 0.87, size.height * 0.13, size.width * 0.89, size.height * 0.13, size.width * 0.9, size.height * 0.12);
  path.cubicTo(size.width * 0.91, size.height * 0.12, size.width * 0.92, size.height * 0.11, size.width * 0.93, size.height * 0.1);
  path.cubicTo(size.width * 0.95, size.height * 0.09, size.width * 0.96, size.height * 0.09, size.width * 0.97, size.height * 0.11);
  path.cubicTo(size.width * 0.98, size.height * 0.12, size.width, size.height * 0.14, size.width, size.height * 0.13);
  path.cubicTo(size.width, size.height * 0.13, size.width, size.height * 0.14, size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.17, size.width, size.height / 5, size.width * 0.97, size.height / 5);
  path.cubicTo(size.width * 0.97, size.height * 0.24, size.width * 0.97, size.height * 0.24, size.width * 0.94, size.height / 4);
  path.cubicTo(size.width * 0.94, size.height * 0.26, size.width * 0.93, size.height * 0.27, size.width * 0.94, size.height * 0.28);
  path.cubicTo(size.width * 0.94, size.height * 0.29, size.width * 0.94, size.height * 0.3, size.width * 0.95, size.height * 0.31);
  path.cubicTo(size.width * 0.95, size.height * 0.31, size.width * 0.96, size.height * 0.31, size.width * 0.96, size.height * 0.31);
  path.cubicTo(size.width * 0.96, size.height * 0.32, size.width * 0.97, size.height * 0.34, size.width * 0.97, size.height * 0.35);
  path.cubicTo(size.width * 0.97, size.height * 0.35, size.width * 0.95, size.height * 0.36, size.width * 0.95, size.height * 0.36);
  path.cubicTo(size.width * 0.95, size.height * 0.37, size.width * 0.94, size.height * 0.37, size.width * 0.94, size.height * 0.37);
  path.cubicTo(size.width * 0.93, size.height * 0.36, size.width * 0.93, size.height * 0.36, size.width * 0.93, size.height * 0.35);
  path.cubicTo(size.width * 0.92, size.height * 0.35, size.width * 0.92, size.height * 0.35, size.width * 0.91, size.height * 0.36);
  path.cubicTo(size.width * 0.91, size.height * 0.35, size.width * 0.91, size.height * 0.35, size.width * 0.91, size.height * 0.34);
  path.cubicTo(size.width * 0.9, size.height * 0.34, size.width * 0.89, size.height * 0.35, size.width * 0.89, size.height * 0.35);
  path.cubicTo(size.width * 0.89, size.height * 0.34, size.width * 0.88, size.height / 3, size.width * 0.88, size.height * 0.32);
  path.cubicTo(size.width * 0.86, size.height * 0.34, size.width * 0.84, size.height / 3, size.width * 0.83, size.height * 0.31);
  path.cubicTo(size.width * 0.81, size.height * 0.29, size.width * 0.79, size.height * 0.32, size.width * 0.78, size.height / 3);
  path.cubicTo(size.width * 0.77, size.height / 3, size.width * 0.77, size.height * 0.34, size.width * 0.78, size.height * 0.35);
  path.cubicTo(size.width * 0.78, size.height * 0.35, size.width * 0.78, size.height * 0.36, size.width * 0.78, size.height * 0.36);
  path.cubicTo(size.width * 0.76, size.height * 0.37, size.width * 0.75, size.height * 0.38, size.width * 0.73, size.height * 0.39);
  path.cubicTo(size.width * 0.72, size.height * 0.4, size.width * 0.71, size.height * 0.41, size.width * 0.71, size.height * 0.42);
  path.cubicTo(size.width * 0.71, size.height * 0.46, size.width * 0.7, size.height * 0.48, size.width * 0.68, size.height * 0.51);
  path.cubicTo(size.width * 0.68, size.height * 0.51, size.width * 0.68, size.height * 0.52, size.width * 0.68, size.height * 0.53);
  path.cubicTo(size.width * 0.67, size.height * 0.53, size.width * 0.67, size.height * 0.54, size.width * 0.66, size.height * 0.55);
  path.cubicTo(size.width * 0.66, size.height * 0.56, size.width * 0.65, size.height * 0.56, size.width * 0.65, size.height * 0.57);
  path.cubicTo(size.width * 0.64, size.height * 0.6, size.width * 0.63, size.height * 0.62, size.width * 0.6, size.height * 0.64);
  path.cubicTo(size.width * 0.6, size.height * 0.64, size.width * 0.59, size.height * 0.65, size.width * 0.59, size.height * 0.66);
  path.cubicTo(size.width * 0.58, size.height * 0.67, size.width * 0.57, size.height * 0.69, size.width * 0.56, size.height * 0.7);
  path.cubicTo(size.width * 0.55, size.height * 0.71, size.width * 0.53, size.height * 0.71, size.width * 0.52, size.height * 0.72);
  path.cubicTo(size.width / 2, size.height * 0.69, size.width * 0.49, size.height * 0.69, size.width * 0.48, size.height * 0.72);
  path.cubicTo(size.width * 0.47, size.height * 0.73, size.width * 0.46, size.height * 0.74, size.width * 0.46, size.height * 0.75);
  path.cubicTo(size.width * 0.45, size.height * 0.76, size.width * 0.45, size.height * 0.77, size.width * 0.45, size.height * 0.78);
  path.cubicTo(size.width * 0.45, size.height * 0.79, size.width * 0.47, size.height * 0.8, size.width * 0.48, size.height * 0.8);
  path.cubicTo(size.width * 0.48, size.height * 0.8, size.width * 0.48, size.height * 0.8, size.width * 0.48, size.height * 0.8);
  path.cubicTo(size.width * 0.48, size.height * 0.86, size.width * 0.48, size.height * 0.86, size.width / 2, size.height * 0.87);
  path.cubicTo(size.width * 0.51, size.height * 0.89, size.width * 0.52, size.height * 0.91, size.width * 0.52, size.height * 0.93);
  path.cubicTo(size.width * 0.53, size.height * 0.94, size.width * 0.52, size.height * 0.95, size.width * 0.52, size.height * 0.96);
  path.cubicTo(size.width * 0.52, size.height * 0.96, size.width * 0.51, size.height * 0.97, size.width * 0.51, size.height * 0.96);
  path.cubicTo(size.width / 2, size.height * 0.94, size.width * 0.49, size.height * 0.96, size.width * 0.47, size.height * 0.97);
  path.cubicTo(size.width * 0.47, size.height * 0.97, size.width * 0.46, size.height * 0.97, size.width * 0.46, size.height * 0.97);
  path.cubicTo(size.width * 0.44, size.height * 0.96, size.width * 0.43, size.height * 0.96, size.width * 0.41, size.height * 0.96);
  path.cubicTo(size.width * 0.41, size.height * 0.97, size.width * 0.41, size.height * 0.98, size.width * 0.41, size.height * 0.98);
  path.cubicTo(size.width * 0.39, size.height, size.width * 0.38, size.height, size.width * 0.37, size.height);
  path.cubicTo(size.width * 0.35, size.height, size.width * 0.34, size.height, size.width / 3, size.height * 0.96);
  path.cubicTo(size.width / 3, size.height * 0.95, size.width / 3, size.height * 0.94, size.width / 3, size.height * 0.93);
  path.cubicTo(size.width * 0.32, size.height * 0.93, size.width * 0.32, size.height * 0.92, size.width * 0.31, size.height * 0.92);
  path.cubicTo(size.width * 0.29, size.height * 0.93, size.width * 0.3, size.height * 0.91, size.width * 0.3, size.height * 0.9);
  path.cubicTo(size.width * 0.29, size.height * 0.89, size.width * 0.28, size.height * 0.88, size.width * 0.27, size.height * 0.88);
  path.cubicTo(size.width * 0.22, size.height * 0.9, size.width * 0.17, size.height * 0.89, size.width * 0.12, size.height * 0.9);
  path.cubicTo(size.width * 0.1, size.height * 0.9, size.width * 0.07, size.height * 0.9, size.width * 0.04, size.height * 0.91);
  path.cubicTo(size.width * 0.03, size.height * 0.88, size.width * 0.04, size.height * 0.85, size.width * 0.05, size.height * 0.83);
  path.cubicTo(size.width * 0.07, size.height * 0.81, size.width * 0.09, size.height * 0.79, size.width * 0.12, size.height * 0.8);
  path.cubicTo(size.width * 0.12, size.height * 0.78, size.width * 0.12, size.height * 0.77, size.width * 0.13, size.height * 0.75);
  path.cubicTo(size.width * 0.12, size.height * 0.75, size.width * 0.11, size.height * 0.75, size.width * 0.1, size.height * 0.75);
  path.cubicTo(size.width * 0.1, size.height * 0.74, size.width * 0.1, size.height * 0.74, size.width * 0.1, size.height * 0.73);
  path.cubicTo(size.width * 0.1, size.height * 0.69, size.width * 0.1, size.height * 0.67, size.width * 0.06, size.height * 0.66);
  path.cubicTo(size.width * 0.05, size.height * 0.65, size.width * 0.05, size.height * 0.64, size.width * 0.04, size.height * 0.64);
  path.cubicTo(size.width * 0.03, size.height * 0.61, size.width * 0.02, size.height * 0.59, size.width * 0.01, size.height * 0.57);
  path.cubicTo(size.width * 0.01, size.height * 0.57, size.width * 0.02, size.height * 0.57, size.width * 0.02, size.height * 0.57);
  path.cubicTo(size.width * 0.04, size.height * 0.58, size.width * 0.06, size.height * 0.59, size.width * 0.08, size.height * 0.6);
  path.cubicTo(size.width * 0.13, size.height * 0.6, size.width * 0.17, size.height * 0.59, size.width / 5, size.height * 0.59);
  path.cubicTo(size.width * 0.23, size.height * 0.58, size.width / 4, size.height * 0.57, size.width * 0.27, size.height * 0.56);
  path.cubicTo(size.width * 0.28, size.height * 0.56, size.width * 0.28, size.height * 0.55, size.width * 0.28, size.height * 0.55);
  path.cubicTo(size.width * 0.28, size.height * 0.53, size.width * 0.28, size.height * 0.51, size.width * 0.29, size.height * 0.49);
  path.cubicTo(size.width * 0.29, size.height * 0.48, size.width * 0.3, size.height * 0.45, size.width / 3, size.height * 0.46);
  path.cubicTo(size.width * 0.34, size.height * 0.46, size.width * 0.35, size.height * 0.46, size.width * 0.35, size.height * 0.45);
  path.cubicTo(size.width * 0.35, size.height * 0.45, size.width * 0.35, size.height * 0.44, size.width * 0.35, size.height * 0.44);
  path.cubicTo(size.width * 0.36, size.height * 0.43, size.width * 0.37, size.height * 0.42, size.width * 0.38, size.height * 0.42);
  path.cubicTo(size.width * 0.39, size.height * 0.42, size.width * 0.4, size.height * 0.43, size.width * 0.42, size.height * 0.43);
  path.cubicTo(size.width * 0.42, size.height * 0.42, size.width * 0.44, size.height * 0.41, size.width * 0.44, size.height * 0.4);
  path.cubicTo(size.width * 0.43, size.height * 0.37, size.width * 0.45, size.height * 0.35, size.width * 0.45, size.height * 0.32);
  path.cubicTo(size.width * 0.47, size.height * 0.32, size.width * 0.48, size.height * 0.31, size.width * 0.49, size.height * 0.3);
  path.cubicTo(size.width * 0.48, size.height * 0.28, size.width * 0.48, size.height * 0.27, size.width * 0.47, size.height / 4);
  path.cubicTo(size.width * 0.48, size.height / 4, size.width * 0.49, size.height / 4, size.width * 0.51, size.height / 4);
  path.cubicTo(size.width * 0.52, size.height * 0.26, size.width * 0.54, size.height * 0.23, size.width * 0.54, size.height * 0.22);
  path.cubicTo(size.width * 0.52, size.height / 5, size.width * 0.54, size.height * 0.19, size.width * 0.54, size.height * 0.18);
  path.cubicTo(size.width * 0.55, size.height * 0.17, size.width * 0.56, size.height * 0.16, size.width * 0.56, size.height * 0.15);
  path.cubicTo(size.width * 0.56, size.height * 0.12, size.width * 0.55, size.height * 0.1, size.width * 0.54, size.height * 0.08);
  path.cubicTo(size.width * 0.55, size.height * 0.07, size.width * 0.56, size.height * 0.06, size.width * 0.57, size.height * 0.05);
  path.cubicTo(size.width * 0.6, size.height * 0.02, size.width * 0.64, size.height * 0.02, size.width * 0.67, size.height * 0.02);
  path.cubicTo(size.width * 0.69, size.height * 0.02, size.width * 0.7, size.height * 0.02, size.width * 0.71, 0);
  path.cubicTo(size.width * 0.71, 0, size.width * 0.71, 0, size.width * 0.71, 0);



  // Path number 2




  path.moveTo(size.width * 0.71, 0);
  path.cubicTo(size.width * 0.7, size.height * 0.02, size.width * 0.69, size.height * 0.02, size.width * 0.67, size.height * 0.02);
  path.cubicTo(size.width * 0.64, size.height * 0.02, size.width * 0.6, size.height * 0.02, size.width * 0.57, size.height * 0.05);
  path.cubicTo(size.width * 0.56, size.height * 0.06, size.width * 0.55, size.height * 0.07, size.width * 0.54, size.height * 0.08);
  path.cubicTo(size.width * 0.55, size.height * 0.1, size.width * 0.56, size.height * 0.12, size.width * 0.56, size.height * 0.15);
  path.cubicTo(size.width * 0.56, size.height * 0.16, size.width * 0.55, size.height * 0.17, size.width * 0.54, size.height * 0.18);
  path.cubicTo(size.width * 0.54, size.height * 0.19, size.width * 0.52, size.height / 5, size.width * 0.54, size.height * 0.22);
  path.cubicTo(size.width * 0.54, size.height * 0.23, size.width * 0.52, size.height * 0.26, size.width * 0.51, size.height / 4);
  path.cubicTo(size.width * 0.49, size.height / 4, size.width * 0.48, size.height / 4, size.width * 0.47, size.height / 4);
  path.cubicTo(size.width * 0.48, size.height * 0.27, size.width * 0.48, size.height * 0.28, size.width * 0.49, size.height * 0.3);
  path.cubicTo(size.width * 0.48, size.height * 0.31, size.width * 0.47, size.height * 0.32, size.width * 0.45, size.height * 0.32);
  path.cubicTo(size.width * 0.45, size.height * 0.35, size.width * 0.43, size.height * 0.37, size.width * 0.44, size.height * 0.4);
  path.cubicTo(size.width * 0.44, size.height * 0.41, size.width * 0.42, size.height * 0.42, size.width * 0.42, size.height * 0.43);
  path.cubicTo(size.width * 0.4, size.height * 0.43, size.width * 0.39, size.height * 0.42, size.width * 0.38, size.height * 0.42);
  path.cubicTo(size.width * 0.37, size.height * 0.42, size.width * 0.36, size.height * 0.43, size.width * 0.35, size.height * 0.44);
  path.cubicTo(size.width * 0.35, size.height * 0.44, size.width * 0.35, size.height * 0.45, size.width * 0.35, size.height * 0.45);
  path.cubicTo(size.width * 0.35, size.height * 0.46, size.width * 0.34, size.height * 0.46, size.width / 3, size.height * 0.46);
  path.cubicTo(size.width * 0.3, size.height * 0.45, size.width * 0.29, size.height * 0.48, size.width * 0.29, size.height * 0.49);
  path.cubicTo(size.width * 0.28, size.height * 0.51, size.width * 0.28, size.height * 0.53, size.width * 0.28, size.height * 0.55);
  path.cubicTo(size.width * 0.28, size.height * 0.55, size.width * 0.28, size.height * 0.56, size.width * 0.27, size.height * 0.56);
  path.cubicTo(size.width / 4, size.height * 0.57, size.width * 0.23, size.height * 0.58, size.width / 5, size.height * 0.59);
  path.cubicTo(size.width * 0.17, size.height * 0.59, size.width * 0.13, size.height * 0.6, size.width * 0.08, size.height * 0.6);
  path.cubicTo(size.width * 0.06, size.height * 0.59, size.width * 0.04, size.height * 0.58, size.width * 0.02, size.height * 0.57);
  path.cubicTo(size.width * 0.02, size.height * 0.57, size.width * 0.01, size.height * 0.57, size.width * 0.01, size.height * 0.57);
  path.cubicTo(size.width * 0.02, size.height * 0.59, size.width * 0.03, size.height * 0.61, size.width * 0.04, size.height * 0.64);
  path.cubicTo(size.width * 0.05, size.height * 0.64, size.width * 0.05, size.height * 0.65, size.width * 0.06, size.height * 0.66);
  path.cubicTo(size.width * 0.1, size.height * 0.67, size.width * 0.1, size.height * 0.69, size.width * 0.1, size.height * 0.73);
  path.cubicTo(size.width * 0.1, size.height * 0.74, size.width * 0.1, size.height * 0.74, size.width * 0.1, size.height * 0.75);
  path.cubicTo(size.width * 0.11, size.height * 0.75, size.width * 0.12, size.height * 0.75, size.width * 0.13, size.height * 0.75);
  path.cubicTo(size.width * 0.12, size.height * 0.77, size.width * 0.12, size.height * 0.78, size.width * 0.12, size.height * 0.8);
  path.cubicTo(size.width * 0.09, size.height * 0.79, size.width * 0.07, size.height * 0.81, size.width * 0.05, size.height * 0.83);
  path.cubicTo(size.width * 0.04, size.height * 0.85, size.width * 0.03, size.height * 0.88, size.width * 0.04, size.height * 0.91);
  path.cubicTo(size.width * 0.07, size.height * 0.9, size.width * 0.1, size.height * 0.9, size.width * 0.12, size.height * 0.9);
  path.cubicTo(size.width * 0.17, size.height * 0.89, size.width * 0.22, size.height * 0.9, size.width * 0.27, size.height * 0.88);
  path.cubicTo(size.width * 0.28, size.height * 0.88, size.width * 0.29, size.height * 0.89, size.width * 0.3, size.height * 0.9);
  path.cubicTo(size.width * 0.3, size.height * 0.91, size.width * 0.29, size.height * 0.93, size.width * 0.31, size.height * 0.92);
  path.cubicTo(size.width * 0.32, size.height * 0.92, size.width * 0.32, size.height * 0.93, size.width / 3, size.height * 0.93);
  path.cubicTo(size.width / 3, size.height * 0.94, size.width / 3, size.height * 0.95, size.width / 3, size.height * 0.96);
  path.cubicTo(size.width * 0.34, size.height, size.width * 0.35, size.height, size.width * 0.37, size.height);
  path.cubicTo(size.width * 0.37, size.height, size.width * 0.37, size.height, size.width * 0.37, size.height);
  path.cubicTo(size.width / 4, size.height, size.width * 0.13, size.height, 0, size.height);
  path.cubicTo(0, size.height * 0.67, 0, size.height * 0.34, 0, 0);
  path.cubicTo(size.width * 0.24, 0, size.width * 0.47, 0, size.width * 0.71, 0);
  path.cubicTo(size.width * 0.71, 0, size.width * 0.71, 0, size.width * 0.71, 0);



  // Path number 3




  path.moveTo(size.width * 0.37, size.height);
  path.cubicTo(size.width * 0.37, size.height, size.width * 0.37, size.height, size.width * 0.37, size.height);
  path.cubicTo(size.width * 0.38, size.height, size.width * 0.39, size.height, size.width * 0.41, size.height * 0.98);
  path.cubicTo(size.width * 0.41, size.height * 0.98, size.width * 0.41, size.height * 0.97, size.width * 0.41, size.height * 0.96);
  path.cubicTo(size.width * 0.43, size.height * 0.96, size.width * 0.44, size.height * 0.96, size.width * 0.46, size.height * 0.97);
  path.cubicTo(size.width * 0.46, size.height * 0.97, size.width * 0.47, size.height * 0.97, size.width * 0.47, size.height * 0.97);
  path.cubicTo(size.width * 0.49, size.height * 0.96, size.width / 2, size.height * 0.94, size.width * 0.51, size.height * 0.96);
  path.cubicTo(size.width * 0.51, size.height * 0.97, size.width * 0.52, size.height * 0.96, size.width * 0.52, size.height * 0.96);
  path.cubicTo(size.width * 0.52, size.height * 0.95, size.width * 0.53, size.height * 0.94, size.width * 0.52, size.height * 0.93);
  path.cubicTo(size.width * 0.52, size.height * 0.91, size.width * 0.51, size.height * 0.89, size.width / 2, size.height * 0.87);
  path.cubicTo(size.width * 0.48, size.height * 0.86, size.width * 0.48, size.height * 0.86, size.width * 0.48, size.height * 0.8);
  path.cubicTo(size.width * 0.48, size.height * 0.8, size.width * 0.48, size.height * 0.8, size.width * 0.48, size.height * 0.8);
  path.cubicTo(size.width * 0.47, size.height * 0.8, size.width * 0.45, size.height * 0.79, size.width * 0.45, size.height * 0.78);
  path.cubicTo(size.width * 0.45, size.height * 0.77, size.width * 0.45, size.height * 0.76, size.width * 0.46, size.height * 0.75);
  path.cubicTo(size.width * 0.46, size.height * 0.74, size.width * 0.47, size.height * 0.73, size.width * 0.48, size.height * 0.72);
  path.cubicTo(size.width * 0.49, size.height * 0.69, size.width / 2, size.height * 0.69, size.width * 0.52, size.height * 0.72);
  path.cubicTo(size.width * 0.53, size.height * 0.71, size.width * 0.55, size.height * 0.71, size.width * 0.56, size.height * 0.7);
  path.cubicTo(size.width * 0.57, size.height * 0.69, size.width * 0.58, size.height * 0.67, size.width * 0.59, size.height * 0.66);
  path.cubicTo(size.width * 0.59, size.height * 0.65, size.width * 0.6, size.height * 0.64, size.width * 0.6, size.height * 0.64);
  path.cubicTo(size.width * 0.63, size.height * 0.62, size.width * 0.64, size.height * 0.6, size.width * 0.65, size.height * 0.57);
  path.cubicTo(size.width * 0.65, size.height * 0.56, size.width * 0.66, size.height * 0.56, size.width * 0.66, size.height * 0.55);
  path.cubicTo(size.width * 0.67, size.height * 0.54, size.width * 0.67, size.height * 0.53, size.width * 0.68, size.height * 0.53);
  path.cubicTo(size.width * 0.68, size.height * 0.52, size.width * 0.68, size.height * 0.51, size.width * 0.68, size.height * 0.51);
  path.cubicTo(size.width * 0.7, size.height * 0.48, size.width * 0.71, size.height * 0.46, size.width * 0.71, size.height * 0.42);
  path.cubicTo(size.width * 0.71, size.height * 0.41, size.width * 0.72, size.height * 0.4, size.width * 0.73, size.height * 0.39);
  path.cubicTo(size.width * 0.75, size.height * 0.38, size.width * 0.76, size.height * 0.37, size.width * 0.78, size.height * 0.36);
  path.cubicTo(size.width * 0.78, size.height * 0.36, size.width * 0.78, size.height * 0.35, size.width * 0.78, size.height * 0.35);
  path.cubicTo(size.width * 0.77, size.height * 0.34, size.width * 0.77, size.height / 3, size.width * 0.78, size.height / 3);
  path.cubicTo(size.width * 0.79, size.height * 0.32, size.width * 0.81, size.height * 0.29, size.width * 0.83, size.height * 0.31);
  path.cubicTo(size.width * 0.84, size.height / 3, size.width * 0.86, size.height * 0.34, size.width * 0.88, size.height * 0.32);
  path.cubicTo(size.width * 0.88, size.height / 3, size.width * 0.89, size.height * 0.34, size.width * 0.89, size.height * 0.35);
  path.cubicTo(size.width * 0.89, size.height * 0.35, size.width * 0.9, size.height * 0.34, size.width * 0.91, size.height * 0.34);
  path.cubicTo(size.width * 0.91, size.height * 0.35, size.width * 0.91, size.height * 0.35, size.width * 0.91, size.height * 0.36);
  path.cubicTo(size.width * 0.92, size.height * 0.35, size.width * 0.92, size.height * 0.35, size.width * 0.93, size.height * 0.35);
  path.cubicTo(size.width * 0.93, size.height * 0.36, size.width * 0.93, size.height * 0.36, size.width * 0.94, size.height * 0.37);
  path.cubicTo(size.width * 0.94, size.height * 0.37, size.width * 0.95, size.height * 0.37, size.width * 0.95, size.height * 0.36);
  path.cubicTo(size.width * 0.95, size.height * 0.36, size.width * 0.97, size.height * 0.35, size.width * 0.97, size.height * 0.35);
  path.cubicTo(size.width * 0.97, size.height * 0.34, size.width * 0.96, size.height * 0.32, size.width * 0.96, size.height * 0.31);
  path.cubicTo(size.width * 0.96, size.height * 0.31, size.width * 0.95, size.height * 0.31, size.width * 0.95, size.height * 0.31);
  path.cubicTo(size.width * 0.94, size.height * 0.3, size.width * 0.94, size.height * 0.29, size.width * 0.94, size.height * 0.28);
  path.cubicTo(size.width * 0.93, size.height * 0.27, size.width * 0.94, size.height * 0.26, size.width * 0.94, size.height / 4);
  path.cubicTo(size.width * 0.97, size.height * 0.24, size.width * 0.97, size.height * 0.24, size.width * 0.97, size.height / 5);
  path.cubicTo(size.width, size.height / 5, size.width, size.height * 0.17, size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.14, size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.43, size.width, size.height * 0.72, size.width, size.height);
  path.cubicTo(size.width * 0.8, size.height, size.width * 0.59, size.height, size.width * 0.37, size.height);
  path.cubicTo(size.width * 0.37, size.height, size.width * 0.37, size.height, size.width * 0.37, size.height);



  // Path number 4




  path.moveTo(size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.14, size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.13, size.width, size.height * 0.13);
  path.cubicTo(size.width, size.height * 0.14, size.width * 0.98, size.height * 0.12, size.width * 0.97, size.height * 0.11);
  path.cubicTo(size.width * 0.96, size.height * 0.09, size.width * 0.95, size.height * 0.09, size.width * 0.93, size.height * 0.1);
  path.cubicTo(size.width * 0.92, size.height * 0.11, size.width * 0.91, size.height * 0.12, size.width * 0.9, size.height * 0.12);
  path.cubicTo(size.width * 0.89, size.height * 0.13, size.width * 0.87, size.height * 0.13, size.width * 0.86, size.height * 0.14);
  path.cubicTo(size.width * 0.86, size.height * 0.13, size.width * 0.86, size.height * 0.12, size.width * 0.86, size.height * 0.12);
  path.cubicTo(size.width * 0.84, size.height * 0.11, size.width * 0.83, size.height * 0.11, size.width * 0.82, size.height * 0.09);
  path.cubicTo(size.width * 0.81, size.height * 0.06, size.width * 0.79, size.height * 0.05, size.width * 0.77, size.height * 0.04);
  path.cubicTo(size.width * 0.76, size.height * 0.03, size.width * 0.76, size.height * 0.03, size.width * 0.76, size.height * 0.03);
  path.cubicTo(size.width * 0.75, size.height * 0.01, size.width * 0.74, size.height * 0.01, size.width * 0.73, size.height * 0.01);
  path.cubicTo(size.width * 0.73, size.height * 0.02, size.width * 0.72, size.height * 0.01, size.width * 0.72, size.height * 0.01);
  path.cubicTo(size.width * 0.82, 0, size.width * 0.91, 0, size.width, 0);
  path.cubicTo(size.width, size.height * 0.05, size.width, size.height * 0.09, size.width, size.height * 0.14);
  path.cubicTo(size.width, size.height * 0.14, size.width, size.height * 0.14, size.width, size.height * 0.14);
  path.close();
  return path;
}

