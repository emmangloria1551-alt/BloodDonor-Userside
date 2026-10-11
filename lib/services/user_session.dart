class UserSession {
  static int? userId;
  static String? name;
  static String? email;
  static String? bloodType;
  static String? role;
  static String? status;

  static void setUser({
    required int id,
    required String userName,
    required String userEmail,
    String? userBloodType,
    String? userRole,
    String? userStatus,
  }) {
    userId = id;
    name = userName;
    email = userEmail;
    bloodType = userBloodType;
    role = userRole;
    status = userStatus;
  }

  static void clear() {
    userId = null;
    name = null;
    email = null;
    bloodType = null;
    role = null;
    status = null;
  }
}