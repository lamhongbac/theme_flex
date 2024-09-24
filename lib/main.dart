import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_flex/theme/theme_constants.dart';
import 'package:theme_flex/theme/theme_manager.dart';
import 'package:theme_flex/utils/helper_widgets.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) {
  //   runApp(const MyApp());
  // });

  runApp(const MyApp());
}

ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const MyHomeScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    ThemeMode themmode = _themeManager.themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo flexible theme "),
        actions: [
          Switch(
              value: themmode == ThemeMode.dark,
              onChanged: (newValue) {
                _themeManager.toggleTheme(newValue);
              })
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/profile_pic.png",
                width: 200,
                height: 200,
              ),
              addVerticalSpace(10),
              Text(
                "HeadlineMedium theme change color/fontweight",
                style: textTheme.headlineMedium!.copyWith(
                    color: isDark ? Colors.red : Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
              addVerticalSpace(10),
              Text("title larger default theme gg font",
                  style: textTheme.titleLarge),
              addVerticalSpace(10),
              Text(
                "default textTheme titleMedium",
                style: textTheme.titleMedium,
              ),
              addVerticalSpace(10),
              Text(
                "default text theme bodyMedium ",
                style: textTheme.bodyMedium,
              ),
              addVerticalSpace(20),
              const TextField(),
              addVerticalSpace(20),
              ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  child: const Text("default theme"),
                  onPressed: () {}),
              addVerticalSpace(20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // foreground (text) color
                  backgroundColor: const Color.fromARGB(255, 240, 30, 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ), // background color
                ),
                onPressed: () => print('pressed'),
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton:
      // //For Test of change default
      // Theme(
      //   data: Theme.of(context).copyWith(splashColor: Colors.blue), // For Test
      //   child: FloatingActionButton(
      //     child: const Icon(Icons.add),
      //     onPressed: () {},
      //   ),

      floatingActionButton:
          // For Test of default
          FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
