import 'package:flutter/material.dart';
import 'package:ganesha_frontend/Components/user_avatar.dart';

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
            Container(
              width: 100.0, // Set the width for the larger avatar
              height: 100.0, // Set the height for the larger avatar
              child: UserAvatar(name: friendName),
            ),
            SizedBox(height: 16),
            Text(
              '¿Quieres regalar "$songTitle" a $friendName?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
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