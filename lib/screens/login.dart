import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 96),
            child: SizedBox(
              width: 150,
              height: 150,
              child: Image.asset("img/patokatu.jpg"),
            ),
          ),
          SizedBox(
            width: 200,
            height: 50,
            child: Center(
              child: ElevatedButton(
                onPressed: () => {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(6, 199, 85, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32))),
                child: Row(
                  children: [
                    Image.asset("img/line_logo.png"),
                    const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "LINE LOGIN",
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
