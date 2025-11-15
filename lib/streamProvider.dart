import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class ApiStream {
  Stream<int> errorTalker() {
    return Stream.periodic(Duration(seconds: 1), (count) {
      if (count < 5) {
        return count;
      } else {
        throw Exception("error can't go longer");
      }
    }).take(6); // Take 6 to ensure we get to the error
  }
}

final errorChecker = Provider((ref) => ApiStream());

final simpleProvider = StreamProvider.autoDispose((ref) {
  final api = ref.read(errorChecker);
  return api.errorTalker();
});

class StreamPro extends ConsumerWidget {
  const StreamPro({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStream = ref.watch(simpleProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.logo_dev),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 200, top: 500),
        child: Center(
          child: asyncStream.when(
            skipLoadingOnRefresh: false,
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Stream completed with error: $error'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(simpleProvider);
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
            data: (data) => Text('time counting: $data'),
          ),
        ),
      ),
    );
  }
}
