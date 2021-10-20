import 'package:flutter/material.dart';

class GeolocationButton extends StatelessWidget {
  const GeolocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 60.0,
        width: 60.0,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.3),
        padding: const EdgeInsets.all(10.0),
        child: FloatingActionButton(
          elevation: 1.0,
          backgroundColor: Colors.white,
          onPressed: () {},
          child: const Icon(
            Icons.my_location,
            color: Colors.grey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: Color(0xFFECEDF1),
            ),
          ),
        ),
      ),
    );
  }
}
