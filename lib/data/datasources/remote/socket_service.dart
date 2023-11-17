import 'dart:convert';
import 'dart:io';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  SocketService._internal();
  Socket? _socket;
  bool _isConnected = false; // Track the connection status
  Future<void> connect(String host, int port) async {
    if (_isConnected) {
      // Si ya estamos conectados, no es necesario establecer una nueva conexión.
      return;
    }

    _socket = await Socket.connect(host, port);
    _isConnected = true; // Mark the socket as connected
  }


  Future<String> sendRequest(String request) async {
    try {
      if (_isConnected && _socket != null) {
        _socket!.write(request);
        final responseBytes = await _socket!.first;
        final responseString = utf8.decode(responseBytes); // Decodificar los bytes
        return responseString;
      }
      throw Exception('Socket not connected');
    } catch (e) {
      // Manejar la excepción aquí, como registrarla o tomar medidas apropiadas
      print('Error en sendRequest: $e');
      rethrow; // Lanzar nuevamente la excepción para que los consumidores la manejen si es necesario
    }
  }


  void close() {
    if (_isConnected && _socket != null) {
      _socket!.close();
      _isConnected = false; // Mark the socket as closed
    }
  }

  // Add a method to check if the socket is connected
  bool isConnected() {
    return _isConnected;
  }

  Map<String, dynamic> parseJsonResponse(String response) {
    return json.decode(response);
  }
}
