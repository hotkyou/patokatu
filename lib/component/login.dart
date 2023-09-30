import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 96),
              child: Container(
                width: 150,
                  height: 150,
                  child: Image.asset("img/patokatu.jpg"),
              ),
            ),
            Container(
              width: 200,
              height: 50,
              child: Center(
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Row(
                    children: [
                      Image.asset("img/line_logo.png"),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text("LINE LOGIN",),
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(6, 199, 85, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}