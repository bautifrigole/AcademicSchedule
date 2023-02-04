import 'package:academic_schedule/screens/drawing_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentPage = 0;
  final pageController = PageController( initialPage: 0 );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academic Schedule"),
        centerTitle: true,
        elevation: 0,
      ),

      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          CustomScreen(color: Colors.black12,),
          DrawingScreen(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,

        onTap: (index) {
          currentPage = index;
          pageController.animateToPage(index,
              duration: const Duration( milliseconds: 300),
              curve: Curves.easeOut);
          setState(() {});
        },

        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.5),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.draw),
              label: "Draw"
          ),
        ],
      ),
    );
  }
}

class CustomScreen extends StatelessWidget {
  const CustomScreen({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: const Center(
        child: Text("Custom screen"),
      ),
    );
  }
}