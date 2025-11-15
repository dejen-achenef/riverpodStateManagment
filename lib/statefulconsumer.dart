import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final liveProviderState = StateProvider<String>((ref) => '');
final normalProvider = Provider<Duration>((ref) => Duration(seconds: 1));

class LiveProviderWidget extends ConsumerStatefulWidget {
  const LiveProviderWidget({super.key});

  @override
  ConsumerState<LiveProviderWidget> createState() => _LiveProviderWidgetState();
}

class _LiveProviderWidgetState extends ConsumerState<LiveProviderWidget>
    with SingleTickerProviderStateMixin {
  late final TextEditingController controller;
  late final AnimationController animController;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    final duration = ref.read(normalProvider);

    animController = AnimationController(
      vsync: this,
      duration: duration,
      lowerBound: 0.5,
      upperBound: 1.5,
    )..repeat(reverse: true); // makes it scale back and forth

    controller.addListener(() {
      ref.read(liveProviderState.notifier).state = controller.text;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = ref.watch(liveProviderState);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: controller,
            ),
          ),
          Text('live text: $text'),
          ScaleTransition(
            scale: animController,
            child: const Icon(
              Icons.circle,
              size: 50,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
