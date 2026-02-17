import 'package:dio/dio.dart';
import 'package:rutasinversionesaliaga/models/digi_model.dart';
import 'package:rutasinversionesaliaga/utils/dio_client.dart';

class DigiService {
  final Dio _dio = DioClient.dio;
  static int nextPage = 0;

  Future<List<DigiModel>> getDigimons() async {
    try {
      final response = await _dio.get("/digimon?page=${DigiService.nextPage}");
      // Extraido la data de json
      if (response.data["content"] == null) {
        DigiService.nextPage = -1;
        return [];
      }
      DigiService.nextPage = DigiService.nextPage + 1;
      final List listado = response.data["content"];
      // Convierto el json en modelos para Flutter
      return listado.map((e) => DigiModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Error cargando la data.");
    }
  }
}