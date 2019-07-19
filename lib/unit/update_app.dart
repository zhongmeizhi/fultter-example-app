// App升级
import 'package:flutter_downloader/flutter_downloader.dart';
// 使用 MethodChannel
import 'package:flutter/services.dart';

class UpdateApp {

    // 检查版本是否低于某版本
  bool checkVersionLowerOf (String version) {
    // List _versionUtilList = version.split('.');
    return true;
  }

  // 获取安装地址
  Future<Map> getApkLocalInfo() async {
    // 不发请求了。直接硬编码
    final directory = {
      'version': '1.0.1',
      'url': 'xxx'
    };
    return directory;
  }
  
  //下载
  Future<void> executeDownload(_appPath) async {
    final taskId = await FlutterDownloader.enqueue(
        url: _appPath + '/app-release.apk',
        savedDir: _appPath,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        installApk(_appPath);
      }
    });
  }

  // 安装
  Future<Null> installApk(_appPath) async {
    // 本地资源访问
    // zmz_app为项目名
    const platform = const MethodChannel('zmz_app');
    try {
      // 调用app地址
      await platform.invokeMethod('install', {'path': _appPath + '/app-release.apk'});
    } on PlatformException catch (_) {}
  }

}