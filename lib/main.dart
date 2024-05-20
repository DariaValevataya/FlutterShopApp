import 'package:course_work/pages/splash_screen.dart';
import 'package:course_work/provider/category_provider.dart';
import 'package:course_work/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MultiProvider(
        providers: [
          ListenableProvider<CategoryProvider>(
            create: (ctx) => CategoryProvider(),
          ),
          ListenableProvider<ProductProvider>(
            create: (ctx) => ProductProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Emilia',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
              fontFamily: GoogleFonts.fredoka().fontFamily,
         ),
          home: FutureBuilder(
            future: _initialization,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SplashScreen();
              }
              return Container();
            },
          ),

        ));
  }
}
