import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sisi_super_app/constant/constans.dart';
import 'package:sisi_super_app/utility/Utility.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        String? token = await Utility().loadPref(key: Constans.bearerToken);
        print("tojken $token");
        if (token != null) {
          // ignore: use_build_context_synchronously
          context.go('/home/$token');
        } else {
          // ignore: use_build_context_synchronously
          context.go('/login');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logosisi.png"),
      ),
    );
  }
}
