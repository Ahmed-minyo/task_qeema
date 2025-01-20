///  ========= task qeema ===============

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_qeema/utils/providers.dart';
// import 'package:task_qeema/view/products/products_view.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: providers,
//       child: const MaterialApp(
//         title: 'Product App',
//         home: ProductListScreen(),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
//
//
//

/// ===== default flutter app with reiverpod =============


// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for the counter state
// final counterProvider = StateProvider<int>((ref) => 0);
//
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Read the current value of the counter
//     final counter = ref.watch(counterProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Riverpod Counter App'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Increment the counter using the provider
//           ref.read(counterProvider.notifier).state++;
//         },
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

/// ====== example riverpod api  get data from api ===================


// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// // post_model.dart
// class Post {
//   final int id;
//   final String title;
//   final String body;
//
//   Post({required this.id, required this.title, required this.body});
//
//   // Factory method to create a Post object from JSON
//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }
//
//
//
// class ApiService {
//   Future<List<Post>> fetchPosts() async {
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((post) => Post.fromJson(post)).toList();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
// }
//
//
// // providers.dart
//
//
// // Create a provider for the API service
// final apiServiceProvider = Provider((ref) => ApiService());
//
// // FutureProvider to fetch data asynchronously
// final postsProvider = FutureProvider<List<Post>>((ref) async {
//   final apiService = ref.watch(apiServiceProvider);
//   return apiService.fetchPosts();
// });
//
// // main.dart
//
//
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Riverpod API Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PostsScreen(),
//     );
//   }
// }
//
// class PostsScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final postsAsyncValue = ref.watch(postsProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: postsAsyncValue.when(
//         data: (posts) => ListView.builder(
//           itemCount: posts.length,
//           itemBuilder: (context, index) {
//             final post = posts[index];
//             return ListTile(
//               title: Text(post.title),
//               subtitle: Text(post.body),
//             );
//           },
//         ),
//         loading: () => Center(child: CircularProgressIndicator()),
//         error: (err, stack) => Center(child: Text('Error: $err')),
//       ),
//     );
//   }
// }


///================= example riverpod api  post data to api ===================
// import 'package:http/http.dart' as http;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
//
// class ApiService {
//   Future<void> sendData(String name, String email) async {
//     final response = await http.post(
//       Uri.parse('https://jsonplaceholder.typicode.com/posts'),
//       body: {
//         'name': name,
//         'email': email,
//       },
//     );
//
//     if (response.statusCode == 201) {
//       // Success
//       print('Data sent successfully');
//     } else {
//       throw Exception('Failed to send data');
//     }
//   }
// }
// // send_data_notifier.dart
//
//
// enum SubmissionState { idle, loading, success, error }
//
// class SendDataNotifier extends StateNotifier<SubmissionState> {
//   final ApiService apiService;
//
//   SendDataNotifier(this.apiService) : super(SubmissionState.idle);
//
//   Future<void> sendData(String name, String email) async {
//     state = SubmissionState.loading;
//
//     try {
//       await apiService.sendData(name, email);
//       state = SubmissionState.success;
//     } catch (error) {
//       state = SubmissionState.error;
//     }
//   }
// }
//
// class SendAnotherDataNotifier extends StateNotifier<SubmissionState> {
//   final ApiService apiService;
//
//   SendAnotherDataNotifier(this.apiService) : super(SubmissionState.idle);
//
//   Future<void> sendAnotherData(String name, String email) async {
//     state = SubmissionState.loading;
//
//     try {
//       await apiService.sendData(name, email);
//       state = SubmissionState.success;
//     } catch (error) {
//       state = SubmissionState.error;
//     }
//   }
// }
//
// // Provider for the SendDataNotifier
// final sendAnotherDataProvider = StateNotifierProvider<SendAnotherDataNotifier, SubmissionState>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return SendAnotherDataNotifier(apiService);
// });
//
// final sendDataProvider = StateNotifierProvider<SendDataNotifier, SubmissionState>((ref) {
//   final apiService = ref.watch(apiServiceProvider);
//   return SendDataNotifier(apiService);
// });
//
// final apiServiceProvider = Provider((ref) => ApiService());
//
//
//
// void main() {
//   runApp(ProviderScope(child: MyApp()));
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Send Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SendDataScreen(),
//     );
//   }
// }
//
// class SendDataScreen extends ConsumerStatefulWidget {
//   @override
//   _SendDataScreenState createState() => _SendDataScreenState();
// }
//
// class _SendDataScreenState extends ConsumerState<SendDataScreen> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final submissionState = ref.watch(sendDataProvider);
//     final submissionAnotherState = ref.watch(sendAnotherDataProvider);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Send Data to API'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: _emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submissionState == SubmissionState.loading
//                   ? null
//                   : () async {
//                 final name = _nameController.text;
//                 final email = _emailController.text;
//
//                 // Call the provider to send data
//                 await ref
//                     .read(sendDataProvider.notifier)
//                     .sendData(name, email);
//               },
//               child: submissionState == SubmissionState.loading
//                   ? SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//                   : Text('Submit'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: submissionAnotherState == SubmissionState.loading
//                   ? null
//                   : () async {
//                 final name = _nameController.text;
//                 final email = _emailController.text;
//
//                 // Call the provider to send data
//                 await ref
//                     .read(sendAnotherDataProvider.notifier)
//                     .sendAnotherData(name, email);
//               },
//               child: submissionAnotherState == SubmissionState.loading
//                   ? SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//                   : Text('Submit'),
//             ),
//             SizedBox(height: 20),
//             if (submissionState == SubmissionState.success)
//               Text(
//                 'Data sent successfully!',
//                 style: TextStyle(color: Colors.green),
//               ),
//             if (submissionState == SubmissionState.error)
//               Text(
//                 'Failed to send data. Please try again.',
//                 style: TextStyle(color: Colors.red),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///  ===== unit test =====
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

