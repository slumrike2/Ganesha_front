import 'package:flutter/material.dart';

class GiftConfirmationPage extends StatelessWidget {
  final String friendName;
  final String songTitle;

  const GiftConfirmationPage({
    Key? key,
    required this.friendName,
    required this.songTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Gift'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100.0, // Set the width for the larger avatar
              height: 100.0, // Set the height for the larger avatar
              child: CircleAvatar(
                radius: 50.0,
                child: Text(
                  friendName[0].toUpperCase(), // Display the first letter of the name in uppercase
                  style: TextStyle(fontSize: 60.0), // Larger font size for the character
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              '¿Quieres regalar "$songTitle" a $friendName?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14), // Smaller font size for the text
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle confirmation logic here
                  },
                  child: Text('Confirmar'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}