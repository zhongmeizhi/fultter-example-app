enum Env {
  dev,
  test,
  prod
}

class Config {

  // 模拟器的浏览器中输入127.0.0.1所代表的是Android模拟器
  static String get baseUrl => 'http://10.93.157.7:2333';


  /* 
   * 环境
   */
  static Env _env;
  static Env get env => _env;
  static set setEnv(Env env) => _env = env;

}