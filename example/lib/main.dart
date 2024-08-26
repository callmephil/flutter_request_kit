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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RequestHomePage(),
    );
  }
}

class RequestHomePage extends StatelessWidget {
  // Mocked current user as the creator of the requests
  final Creator currentUser = const Creator(
    userId: 'user123',
    username: 'johndoe',
    isAdmin: true,
  );

  const RequestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print('call');

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: RequestPage(
        currentUser: currentUser,
        locale: RequestKitLocales.enUS.locale,
        theme: RequestCustomTheme.defaultTheme.copyWith(
          primaryColor: Colors.blue,
          iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.red,
              iconSize: 24,
            ),
          ),
        ),
        requestService: RequestService(
          requestList: [
            RequestItem(
              id: 'request1',
              creator: currentUser,
              title: 'Request 1',
              description: 'Description of request 1',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
            RequestItem(
              id: 'request2',
              creator: currentUser,
              title: 'Request 2',
              description: 'Description of request 2',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ],
          onAddRequest: print,
          onUpdateRequest: print,
          onDeleteRequest: print,
          onAddComment: print,
          onVoteChange: print,
        ),
      ),
    );
  }
}
