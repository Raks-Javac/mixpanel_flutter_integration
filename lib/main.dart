import 'package:flutter/material.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

Mixpanel? mixpanel;
void main() async {
  runApp(const MyApp());
  mixpanel = await Mixpanel.init([TOKEN], trackAutomaticEvents: true);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mixpanel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Mixpanel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //track user event
  trackEvent() {
    mixpanel?.track("test tracking", properties: {
      'email': "test@gmail.com",
    });
  }

//create profile for user
  createUserProfile() {
    mixpanel?.identify("test@gmail.com");
    mixpanel?.getPeople().set("Email", "test@gmail.com");
    mixpanel?.getPeople().set("name", "test user");
    mixpanel?.setUseIpAddressForGeolocation(true);
  }

  // static Future mixPanelAnalytics(
  //     String trackName, Map<String, dynamic>? trackEvent) async {
  //   Logger.logInfo("Logging mixpanel events ");
  //   mixpanel?.identify(ONBConstants.loginUser?.emailAddress ??
  //       "${ONBConstants.loginUser?.firstName ?? ""} ${ONBConstants.loginUser?.lastName ?? ""}");
  //   mixpanel
  //       ?.getPeople()
  //       .set("Email", ONBConstants.loginUser?.emailAddress ?? "");
  //   mixpanel?.getPeople().set("name",
  //       "${ONBConstants.loginUser?.firstName ?? ""} ${ONBConstants.loginUser?.lastName ?? ""}");

  //   // mixpanel?.setGroup("Alice", "Alice");
  //   mixpanel?.setUseIpAddressForGeolocation(true);
  //   mixpanel?.track(trackName, properties: trackEvent);
  //   Logger.logInfo("Logging mixpanel events ended");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Mixpanel testing",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createUserProfile();
          trackEvent();
        },
        tooltip: 'Track Event',
        child: const Icon(Icons.add),
      ),
    );
  }
}
