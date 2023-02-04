import 'package:flutter/material.dart';

class DrawingScreen extends StatelessWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CanvasView();
  }
}

class CanvasView extends StatefulWidget {
  const CanvasView({Key? key}) : super(key: key);

  @override
  State<CanvasView> createState() => _CanvasViewState();
}

class _CanvasViewState extends State<CanvasView> {
  List<DrawingPoints?> points = [];
  Color strokeColor = Colors.black;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: const Size(60,60),
          child: Container(
            padding: const EdgeInsets.only(top: 20, left: 480),
            child: FloatingActionButton(
              backgroundColor: Colors.white30.withOpacity(0.6),
              onPressed: () => setState(() {
                points.clear();
              }),
              child: const Icon(
                Icons.clear,
                color: Colors.black87,
                size: 35,
              )
            ),
          ),
      ),

      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 40,
          child: Slider(
            value: strokeWidth,
            min: 1,
            max: 5,
            onChanged: (val) => setState(() {
              strokeWidth = val;
            }),
          ),
        ),
      ),

      floatingActionButton:
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _createColorButton(Colors.black),
          _createColorButton(Colors.white),
          _createColorButton(Colors.red),
          _createColorButton(Colors.green),
          _createColorButton(Colors.blue),
        ],
      ),
      body: GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: CustomPaint(
          size: Size.infinite,
          painter: MyPainter(points: points),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details){
    setState(() {
      _addPoint(details.localPosition);
    });
  }

  void _onPanUpdate(DragUpdateDetails details){
    setState(() {
      _addPoint(details.localPosition);
    });
  }

  void _onPanEnd(DragEndDetails details){
    setState(() {
      points.add(null);
    });
  }

  void _addPoint(Offset position) {
    points.add(DrawingPoints(
        point: position,
        paint: Paint()
          ..color = strokeColor
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt,
    ));
  }

  FloatingActionButton _createColorButton(Color color){
    return FloatingActionButton(
      backgroundColor: color,
      onPressed: () => setState(() {
        strokeColor = color;
      }),
      child: strokeColor == color ?
      const Icon(
        Icons.circle,
        color: Colors.amber,
        size: 20,
      ) :
      Container(),
    );
  }
}

class MyPainter extends CustomPainter{
  List<DrawingPoints?> points;
  MyPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < points.length-1; i++){
      var currentPoint = points[i];
      var nextPoint = points[i+1];
      if (currentPoint != null && nextPoint != null) {
        canvas.drawLine(currentPoint.point, nextPoint.point, currentPoint.paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DrawingPoints {
  Offset point;
  Paint paint;
  DrawingPoints({required this.point, required this.paint});
}
