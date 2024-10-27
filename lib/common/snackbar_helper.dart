import 'package:flutter/material.dart';

class SnackbarHelper {
  static void showSnackBar(
      BuildContext context, String message, MaterialColor color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: _buildSnackBarContent(message, color),
        backgroundColor: Colors.transparent,
        elevation: 0));
  }

  static Widget _buildSnackBarContent(String message, MaterialColor color) {
    return Container(
      decoration: BoxDecoration(
        color: color[100],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Expanded(child: Text(message, style: TextStyle(color: color))),
          SnackBarAction(label: 'X', onPressed: () {}, textColor: color)
        ],
      ),
    );
  }
}
