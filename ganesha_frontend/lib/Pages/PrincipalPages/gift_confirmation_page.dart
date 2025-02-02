import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GiftConfirmationPage extends StatelessWidget {
  final String userId;
  final String friendId;
  final String songId;
  final String friendName;
  final String songTitle;

  const GiftConfirmationPage({
    Key? key,
    required this.userId,
    required this.friendId,
    required this.songId,
    required this.friendName,
    required this.songTitle,
  }) : super(key: key);

  Future<void> _confirmGift(BuildContext context) async {
    final url = '${dotenv.env['API_URL']}/friends/give';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': '${dotenv.env['API_KEY']}',
      },
      body: jsonEncode({
        'id_usuario': userId,
        'id_amigo': friendId,
        'id_cancion': songId,
      }),
    );

    if (response.statusCode == 200) {
      // Handle successful response
      Navigator.pop(context);
    } else if (response.statusCode == 501) {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error al regalar la canción: Ya la ha adquirido')),
      );
    } else if (response.statusCode == 502) {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Error al regalar la canción: No tienes suficientes puntos')),
      );
    } else {
      // Handle error response
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Error al regalar la canción: ${response.body}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/fondo.jpg', // Replace with your image path
            fit: BoxFit.cover,
            color: Colors.black.withAlpha(100), // Corrected method
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Confirm Gift'),
            backgroundColor:
                Colors.transparent, // Make AppBar background transparent
            elevation: 0, // Remove AppBar shadow
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
                    backgroundColor: Colors
                        .blue, // Use a custom color for the avatar background
                    child: Text(
                      friendName[0]
                          .toUpperCase(), // Display the first letter of the name in uppercase
                      style: TextStyle(
                        fontSize: 60.0, // Larger font size for the character
                        color: Colors.white, // Ensure the text color is white
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '¿Quieres regalar "$songTitle" a $friendName?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white, // Ensure the text color is white
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => _confirmGift(context),
                      child: Text('Confirmar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set button background to white
                        foregroundColor:
                            Colors.purple, // Set button text color to purple
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancelar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Set button background to white
                        foregroundColor:
                            Colors.purple, // Set button text color to purple
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
