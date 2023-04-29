import 'package:dineout/pages/login_page.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animationController.forward();

    Future.delayed(
      Duration(seconds: 3),
      () {
        _animationController.reverse().then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          );
        });
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 255, 84, 80),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation!.value,
                    child: Transform.scale(
                      scale: _animation!.value,
                      child: Image.asset(
                        "assets/images/logo.png",
                        height: 200,
                        width: 200,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AnimatedBuilder(
                animation: _animation!,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation!.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _animation!.value)),
                      child: const Text(
                        "dineout",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
