import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quadb_project/constants/test_style.dart';
import 'package:quadb_project/screens/home_screen.dart';
import 'package:quadb_project/widgets/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 2),
        () {
          Get.offAll(() => HomeScreen(),
              transition: Transition.fadeIn,
              duration: const Duration(milliseconds: 500));
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: _buildContainer(),
    );
  }

  Widget _buildContainer() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFFF66CDAA),
            Color(0xFFF00BFFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: _buildImageSection(),
    );
  }

  Widget _buildImageSection() {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset(
              'assets/images/search.png',
            ),
            const Text(
              'Welcome!',
              style: TStyle.splashText,
            )
          ],
        ),
        const LoadingIndicator()
      ],
    ));
  }
}
