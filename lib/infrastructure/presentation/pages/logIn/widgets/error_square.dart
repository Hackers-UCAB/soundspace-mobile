import 'package:flutter/material.dart';

class ErrorSquare extends StatelessWidget {
  final bool invalidData;
  final String mensaje;

  const ErrorSquare({
    super.key,
    required this.invalidData,
    required this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: invalidData,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          height: 70.0,
          width: MediaQuery.of(context).size.width * 0.90,
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15.0)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Wrap(
                        children: [
                          Text(
                            mensaje,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
