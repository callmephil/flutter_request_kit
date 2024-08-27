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
        primaryColor: Colors.blue,
        primaryColorLight: Colors.lightBlue,
        primaryColorDark: Colors.blue[900],
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 12),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            // backgroundColor: Colors.blue,
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
    onAddComment: print,
    onDeleteRequest: print,
    onUpdateRequest: print,
    onVoteChange: print,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RequestPage(
        currentUser: currentUser,
        store: store,
        locale: RequestKitLocales.enUS.locale,
        theme: Theme.of(context),
      ),
    );
  }
}
