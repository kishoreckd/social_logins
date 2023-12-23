import 'package:flutter/material.dart';
import 'package:social/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Email and Password',
            theme: ThemeData(primarySwatch: Colors.blue),
            // home: Scaffold(
            //   appBar: AppBar(),
            // ),
            home: LoginPage(),
          );
        });
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MyHomePage(title: 'Flutter Firebase Page'),
    // );
  }
}

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _tabs = [
//     // Add your pages/widgets here
//     // Example: Tab1(), Tab2(), ...
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paytm Footer Navigation'),
//       ),
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         type: BottomNavigationBarType.fixed, // Make sure to set type to fixed
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Mall',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.payment),
//             label: 'Pay',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.account_balance_wallet),
//             label: 'Passbook',
//           ),
//         ],
//       ),
//     );
//   }
// }

/// [/Curved navigation Bar]
// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _tabs = [
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paytm Footer Navigation'),
//       ),
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.blueAccent, // Set your desired background color
//         items: [
//           Icon(Icons.home, size: 30),
//           Icon(Icons.shopping_cart, size: 30),
//           Icon(Icons.payment, size: 30),
//           Icon(Icons.account_balance_wallet, size: 30),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }



// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;

//   final List<Widget> _tabs = [
//     // Add your pages/widgets here
//     // Example: Tab1(), Tab2(), ...
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//     Placeholder(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Paytm Footer Navigation'),
//       ),
//       body: _tabs[_currentIndex],
//       bottomNavigationBar: ConvexAppBar(
//         backgroundColor: Colors.blueAccent, // Set your desired background color
//         items: [
//           TabItem(icon: Icons.home, title: 'Home'),
//           TabItem(icon: Icons.shopping_cart, title: 'Cart'),
//           TabItem(icon: Icons.payment, title: 'Payment'),
//           TabItem(icon: Icons.account_balance_wallet, title: 'Wallet'),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }