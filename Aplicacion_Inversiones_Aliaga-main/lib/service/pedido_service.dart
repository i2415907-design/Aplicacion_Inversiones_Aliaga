import 'package:dio/dio.dart';
import '../models/pedido_model.dart';

class PedidoService {
  final Dio _dio = Dio();

  Future<List<PedidoModel>> getMisPedidos(String token) async {
    try {
      final response = await _dio.get(
        'https://inversionesaliaga.com/v1/mis-pedidos',
        queryParameters: {'token': token},
      );

      if (response.statusCode == 200) {
        // La API devuelve un objeto, la lista real está en 'datos'
        List data = response.data['datos'];
        return data.map((json) => PedidoModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Error en PedidoService: $e");
      return [];
    }
  }
}