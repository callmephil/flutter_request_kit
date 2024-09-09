import 'package:flutter/material.dart';
import 'package:flutter_request_kit/flutter_request_kit.dart';

void main() {
  runApp(const RequestApp());
}

class RequestApp extends StatelessWidget {
  const RequestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Request Kit Demo',
      theme: RequestCustomTheme.defaultTheme.copyWith(
        extensions: [
          const RequestStatusPillTheme(),
          const RequestVotingBoxTheme(),
          const RequestItemCardTheme(),
        ],
        primaryColor: Colors.blue,
        primaryColorLight: Colors.lightBlue,
        primaryColorDark: Colors.blue[900],
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          constraints: BoxConstraints(maxHeight: 42),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            iconSize: 24,
          ),
        ),
      ),
      home: const RequestHomePage(),
    );
  }
}

class RequestHomePage extends StatefulWidget {
  const RequestHomePage({super.key});

  @override
  State<RequestHomePage> createState() => _RequestHomePageState();
}

class _RequestHomePageState extends State<RequestHomePage> {
  // Mocked current user as the creator of the requests
  final Creator currentUser = const Creator(
    userId: 'user123',
    username: 'johndoe',
    isAdmin: true,
  );

  late final store = RequestStore(
    requests: <RequestItem>[],
    onAddRequest: print,
    onAddComment: (requestId, comment) {
      print(requestId);
      print(comment);
    },
    onDeleteRequest: print,
    onUpdateRequest: print,
    onVoteChange: print,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Request Kit Demo'),
        ),
        body: RequestPage(
          currentUser: currentUser,
          store: store,
          locale: RequestKitLocales.enUS.locale,
          theme: Theme.of(context),
        ),
      ),
    );
  }
}
