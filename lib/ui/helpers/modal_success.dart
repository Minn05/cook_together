import 'package:flutter/material.dart';
import 'package:recipes/ui/themes/colors_theme.dart';
import 'package:recipes/ui/widgets/widgets.dart';

void modalSuccess(BuildContext context, String text,
    {required VoidCallback onPressed}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        height: 280,
        child: Column(
          children: [
            const Row(
              children: [
                TextCustom(
                    text: 'Cook ',
                    color: ColorsCustom.primary,
                    fontWeight: FontWeight.w500),
                TextCustom(text: 'Together', fontWeight: FontWeight.w500),
              ],
            ),
            const Divider(),
            const SizedBox(height: 10.0),
            Container(
              height: 90,
              width: 90,
              child: const Image(
                image: AssetImage('assets/asset/images/checked.png'),
                height: 90,
              ),
            ),

            const SizedBox(height: 30.0),
            TextCustom(text: text, fontSize: 17, fontWeight: FontWeight.w400),
            const SizedBox(height: 20.0),
            // InkWell(
            //   onTap: onPressed,
            //   child: Container(
            //     alignment: Alignment.center,
            //     height: 35,
            //     width: 150,
            //     decoration: BoxDecoration(
            //         color: ColorsCustom.primary,
            //         borderRadius: BorderRadius.circular(5.0)),
            //     child: const TextCustom(
            //         text: 'OK', color: Colors.white, fontSize: 18),
            //   ),
            // )
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: ColorsCustom.primary,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                onPressed: onPressed,
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ))
          ],
        ),
      ),
    ),
  );
}
