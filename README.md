# flutter_persistent_keyboard_height

Flutter package to get keyboard height. The height is persisted during app
sessions and keyboard states (you can use the height when keyboard is closed).

![](https://github.com/f-person/flutter_persistent_keyboard_height/blob/master/doc/demo.gif?raw=true)

## Usage

#### Registering the provider

First thing you need to do is wrap a widget from children of which you want
to get the keyboard height with `FlutterPersistentKeyboardHeightProvider`.
Wrap your app widget (perhaps `MaterialApp`) if you want to get keyboard height
from all widgets.

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlutterPersistentKeyboardHeightProvider(
      child: MaterialApp(
        title: 'Flutter Persistent Keyboard Height Example',
        home: FlutterPersistentKeyboardHeightExample(),
      ),
    );
  }
}
```

#### Getting the keyboard height
In order to get keyboard height use the `FlutterPersistentKeyboardHeight`
inherited widget:
```dart
Widget build(BuildContext context) {
  final keyboardHeight =
      FlutterPersistentKeyboardHeight.of(context).keyboardHeight;

  return Scaffold(
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Flutter Persistent Keyboard Size Example',
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text('Keyboard height: $keyboardHeight'),
      ],
    ),
  );
}
```

#### Using a custom storage provider
By default, the package uses `shared_preferences` to preserve the keyboard
height but if you want to use a custom solution for preserving the height
you can do that by implementing the `IPersistentKeyboardHeightStorageProvider`
interface and passing an instance of the class to `FlutterPersistentKeyboardHeightProvider`:
```dart
class CustomPersistentKeyboardHeightStorageProvider
    implements IPersistentKeyboardHeightStorageProvider {
  const CustomPersistentKeyboardHeightStorageProvider();

  @override
  Future<double> getHeight() {
    // read the height from storage
  }

  @override
  Future<void> setHeight(double height) {
    // save the height to storage
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FlutterPersistentKeyboardHeightProvider(
      storageProvider: CustomPersistentKeyboardHeightStorageProvider(),
      child: MaterialApp(
        title: 'Flutter Persistent Keyboard Height Example',
        home: FlutterPersistentKeyboardHeightExample(),
      ),
    );
  }
}
```

---

Check out the `example` directory for a complete example app.

## The development process
The first version of this package was developed in two livestreams.
Unfortunately, my voice disappeared at the middle of the first livestream but
the second livestream is okay. In case you want to check them out, here are the links: 
[Part 1](https://www.youtube.com/watch?v=Ezks4Ae8rxI), 
[Part 2](https://www.youtube.com/watch?v=eude8Ht9bNI).

## Thanks to
* The [keyboard_utils](https://github.com/IsaiasSantana/keyboard_utils) package.
