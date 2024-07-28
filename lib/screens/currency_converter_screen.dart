import 'package:currenc/widgets/converter.dart';
import 'package:currenc/widgets/user_details_top.dart';
import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen(
      {super.key, required this.userName, required this.pickedImageFile});
  final String userName;
  final String pickedImageFile;

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Column(
          children: [
            UserDetailsTop(
              userName: widget.userName,
              userImageUrl: widget.pickedImageFile,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                height: double.infinity,
                width: double.infinity,
                child: Center(child: SingleChildScrollView(child: Converter())),
              ),
            )
          ],
        )),
      ),
    );
  }
}
