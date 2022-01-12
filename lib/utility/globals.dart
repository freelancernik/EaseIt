// Global variables

class Globals {
  String _uid;
  String _email;
  String _fname;
  String _lname;
  String _phoneNum;
  String _flatNo;
  String _wing;
  String _role;

  static final Globals _instance = Globals._internal();

  factory Globals() => _instance;

  Globals._internal();

  // Getters
  String get uid => _uid;
  String get email => _email;
  String get fname => _fname;
  String get lname => _lname;
  String get phoneNum => _phoneNum;
  String get flatNo => _flatNo;
  String get wing => _wing;
  String get role => _role;

  //   Setters
  set setUid(String uid) => _uid = uid;
  set setEmail(String email) => _email = email;
  set setFname(String fname) => _fname = fname;
  set setLname(String lname) => _lname = lname;
  set setPhoneNum(String phoneNum) => _phoneNum = phoneNum;
  set setFlatNo(String flatNo) => _flatNo = flatNo;
  set setWing(String wing) => _wing = wing;
  set setRole(String role) => _role = role;
}