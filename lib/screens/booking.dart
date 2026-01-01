import "package:flutter/material.dart";
import "package:travel_app/screens/home_screen.dart";
import "package:travel_app/screens/main_screen.dart";

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Colors.black, size: 25),
        ),
      ),

      body: Center(child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(padding: EdgeInsetsGeometry.all(20),
        child: Form(child:
          Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: "nama",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText:"No Tlp",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)
                  ) 
                ),  
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 45
              )
            ],
          )
         ),
        ),
       ),
      ),
    );
  }
}
