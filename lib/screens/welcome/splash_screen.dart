import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schoolapp/screens/welcome/bloc/welcome_bloc.dart';
import 'package:schoolapp/screens/welcome/first_screen.dart';
import 'package:video_player/video_player.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  late VideoPlayerController videoController;
  @override
  void initState() {
    videoController =
        VideoPlayerController.asset('lib/assets/videos/splash-light.mp4')
          ..initialize().then((_) {
            context.read<WelcomeBloc>().add(SplashEvent());
          })
          ..setVolume(0);
    playVideo();
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future<void> playVideo() async {
    await videoController.play();
    await Future.delayed(const Duration(seconds: 4)).then(
        (value) => context.read<WelcomeBloc>().add(SplashCompleteEvent()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WelcomeBloc, WelcomeState>(
      listenWhen: (previous, current) => current is WelcomeActionState,
      buildWhen: (previous, current) => current is! WelcomeActionState,
      listener: (context, state) {
        if (state is NewUserState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ScreenFirst()),
          );
        }
      },
      builder: (context, state) {
        if (state is SplashState) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: videoController.value.aspectRatio,
                          child: VideoPlayer(videoController),
                        )
                      : Container(),
                  Text('Edu Plan',
                      style: GoogleFonts.acme(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black))
                ],
              ));
        } else {
          return const SizedBox(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
