import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Configuramos Dio con opciones base para evitar bloqueos comunes
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://inversionesaliaga.com/v1',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    },
  ));

  Future<bool> login(String email, String password) async {
    try {
      // Usamos la ruta relativa ya que definimos baseUrl arriba
      final response = await _dio.post('/login', data: {
        'email': email,
        'contrasena': password,
      });

      if (response.statusCode == 200) {
        // Importante: Verifica si tu API devuelve 'token' o 'access_token'
        final String? token = response.data['token'];
        
        if (token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', token);
          return true;
        }
      }
      return false;
    } on DioException catch (e) {
      // Esto te dará una mejor idea de qué falló en la consola
      print("Error Dio: ${e.type} - ${e.message}");
      if (e.response != null) {
        print("Data error: ${e.response?.data}");
      }
      return false;
    } catch (e) {
      print("Error general: $e");
      return false;
    }
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Útil para cerrar sesión después
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  Future<bool> register({
  required String name,
  required String email,
  required String password,
  required String passwordConfirmation,
}) async {
  try {
    final response = await _dio.post('/register', data: {
      'name': name,                // Coincide con Laravel
      'email': email,              // Coincide con Laravel
      'password': password,        // Coincide con Laravel
      'password_confirmation': passwordConfirmation, // Coincide con Laravel
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Si Laravel te loguea y devuelve un token, guárdalo aquí
      if (response.data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']);
      }
      return true;
    }
    return false;
  } on DioException catch (e) {
    print("Error en registro: ${e.response?.data}");
    return false;
  }
}
}