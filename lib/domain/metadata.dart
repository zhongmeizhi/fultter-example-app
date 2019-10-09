
/* 
  页面注解
  利用元数据实现
  目前Flutter无法使用dart:mirrors获取注解的东西。暂时没太大用处
*/
class ZMeta {
  final String message;
  
  const ZMeta(this.message);
}