import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // =====================================================
  // LOGIN
  // =====================================================

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // REGISTER
  // =====================================================

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
    String? bloodType,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'blood_type': bloodType,
        }),
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // CREATE BLOOD REQUEST
  // =====================================================

  static Future<Map<String, dynamic>> createBloodRequest({
    required int userId,
    required String patientName,
    required String bloodType,
    required int unitsNeeded,
    required String hospital,
    String? notes,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/blood-requests'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'patient_name': patientName,
          'blood_type': bloodType,
          'units_needed': unitsNeeded,
          'hospital': hospital,
          'notes': notes,
        }),
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // GET BLOOD REQUESTS
  // =====================================================

  static Future<Map<String, dynamic>> getBloodRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/blood-requests'),
        headers: {
          'Accept': 'application/json',
        },
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // GET REAL DONORS FROM LARAVEL
  // =====================================================

  static Future<Map<String, dynamic>> getDonors() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/donors'),
        headers: {
          'Accept': 'application/json',
        },
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // RESPOND TO DONATION
  // =====================================================

  static Future<Map<String, dynamic>> respondToDonation({
    required int userId,
    required int bloodRequestId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/donations/respond'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': userId,
          'blood_request_id': bloodRequestId,
        }),
      );

      return _parseResponse(response);
    } catch (e) {
      return _connectionError(e);
    }
  }

  // =====================================================
  // COMMON RESPONSE HANDLER
  // =====================================================

  static Map<String, dynamic> _parseResponse(
    http.Response response,
  ) {
    try {
      final dynamic decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        return {
          'statusCode': response.statusCode,
          ...decoded,
        };
      }

      return {
        'statusCode': response.statusCode,
        'success': false,
        'message': 'The server returned an unexpected response.',
      };
    } on FormatException {
      return {
        'statusCode': response.statusCode,
        'success': false,
        'message': 'The server returned an invalid response.',
      };
    }
  }

  // =====================================================
  // CONNECTION ERROR HANDLER
  // =====================================================

  static Map<String, dynamic> _connectionError(Object error) {
    return {
      'statusCode': 0,
      'success': false,
      'message': 'Unable to connect to the Laravel server.',
      'error': error.toString(),
    };
  }
}