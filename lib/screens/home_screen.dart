import 'package:flutter/material.dart';
import 'package:travel_app/screens/Test.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15,),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.search, color: Colors.grey,),
                            border: InputBorder.none,
                            hintText: 'Cari destinasi...',
                          ),
                      )
                      )
                   ),
                  const SizedBox(width: 5,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:IconButton(
                    icon: const Icon(Icons.person, color: Colors.grey),
                    onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => const TestScreen()));
                    },
                  )
                  ),
                  ],
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                    'Kategories',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
       )
      );
  }  
}