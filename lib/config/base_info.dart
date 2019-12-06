enum Env {
  dev,
  test,
  prod
}

enum ZPlatform {
  ios,
  android
}

class Config {

  // 模拟器的浏览器中输入127.0.0.1所代表的是Android模拟器
  static String get baseUrl => 'http://10.93.157.7:2333';

  // app版本
  static String get version => '1.0.0';


  /* 
   * 环境
   */
  static Env _env; // 私有
  static Env get env => _env; // 暴露get
  static set setEnv(Env env) => _env = env; // 暴露set

  /* 
    平台
   */
  static ZPlatform _platform;
  static ZPlatform get platform => _platform;
  static set setPlatform(ZPlatform p) => _platform = p;

}