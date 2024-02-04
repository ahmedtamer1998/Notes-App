import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/view/home_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEB3D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/images/icon.png'),
              width: 300.w,
            ).animate().fade(duration: 1000.ms).scale(delay: 300.ms),
            Text(
              'Note Ease',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 5),
            ).animate().fadeIn().scale().move(delay: 500.ms,duration: 700.ms), 
            SizedBox(
              height: 8.h,
            ),
            Text(
              'YOUR WAY TO SUCCESS',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ).animate().fadeIn(duration: 500.ms).scale(delay: 200.ms),
            SizedBox(
              height: 100.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      'Start',
                      style: TextStyle(
                          fontSize: 28.sp,
                          color: Color.fromARGB(255, 92, 75, 23)),
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    icon: Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 30,
                      color: Color.fromARGB(255, 92, 75, 23),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
