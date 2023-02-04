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
  List<List<DrawingPoints>> lines = [];
  Color strokeColor = Colors.black;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context){
    return Scaffold(

      appBar: PreferredSize(
          preferredSize: const Size(60,60),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                  backgroundColor: Colors.white30.withOpacity(0.6),
                  onPressed: () => setState(() {
                    lines.removeLast();
                  }),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                    size: 35,
                  )
              ),
              FloatingActionButton(
                backgroundColor: Colors.white30.withOpacity(0.6),
                onPressed: () => setState(() {
                  lines.clear();
                }),
                child: const Icon(
                  Icons.clear,
                  color: Colors.black87,
                  size: 35,
                )
              ),
            ],
          ),
      ),

      bottomNavigationBar: SafeArea(
        child: SizedBox(
          height: 40,
          child: Slider(
            value: strokeWidth,
            min: 1,
            max: 7,
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
          painter: MyPainter(lines: lines),
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details){
    setState(() {
      List<DrawingPoints> newLine = [];
      lines.add(newLine);
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

    });
  }

  void _addPoint(Offset position) {
    lines.last.add(DrawingPoints(
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
  List<List<DrawingPoints>> lines;
  MyPainter({required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    for (List<DrawingPoints> line in lines) {
      for (var i = 0; i < line.length - 1; i++) {
        var currentPoint = line[i];
        var nextPoint = line[i + 1];
        if (currentPoint != null && nextPoint != null) {
          canvas.drawLine(
              currentPoint.point, nextPoint.point, currentPoint.paint);
        }
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
