# ⚠️ WORK IN PROGRESS ⚠️

This project is being actively developed and therefore might rapidly change.

# Flutter Request Kit

A Flutter package for your user base to participate in the development of your application. It allows the user to suggest new features, upvote, and chat about them directly in the app.

### Demo

https://flutter-request-kit.web.app

# Motivation

Starting a SaaS is hard, getting good feedback is harder. We wanted some sort of "mini forum" where our user base could express their frustrations, suggest changes or new features. We also needed a way to communicate with them and develop ideas further.

## Our Rules:

- **No external dependencies**: It should not interfere with any other packages.
- **Adaptive Theme**: The UI should be able to adapt to the theme of the parent application.
- **I18n**: It must support localization and adapt to different dialects.

## Our Needs:

- It must be easy to set up.
- It must be performant and reliable.

# Getting Started

## Setup:

Add `flutter_request_kit` to your `pubspec.yaml`

```sh
flutter pub add flutter_request_kit
```

## Usage:

### Basic Setup

```dart
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Request Kit Demo'),
        ),
        body: RequestPage(
          currentUser: currentUser,
          store: store,
          locale: RequestKitLocales.enUS.locale,
          theme: Theme.of(context).copyWith(
             extensions: const [
               RequestStatusPillTheme(),
               RequestVotingBoxTheme(),
               RequestItemCardTheme(),
             ],
          ),
        ),
      ),
    );
  }
}
```

# Contributing

We welcome contributions! Please see CONTRIBUTING.md for more details.

# License

This project is licensed under the MIT License - see the [`LICENSE`](./LICENSE) file for details.
