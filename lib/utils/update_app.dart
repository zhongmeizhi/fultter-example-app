import 'package:flutter/material.dart';
// App升级
import 'package:flutter_downloader/flutter_downloader.dart';
// 使用 MethodChannel
import 'package:flutter/services.dart';

class UpdateApp {

    // 检查版本是否低于某版本
  bool _checkVersionLowerOf (String version) {
    // List _versionUtilList = version.split('.');
    return true;
  }

  // 获取安装地址
  Future<Map> _getApkLocalInfo() async {
    // 不发请求了。直接硬编码
    final directory = {
      'version': '1.0.1',
      'url': 'xxx'
    };
    return directory;
  }
  
  //下载
  Future<void> _executeDownload(_appPath) async {
    final taskId = await FlutterDownloader.enqueue(
        url: _appPath + '/app-release.apk',
        savedDir: _appPath,
        showNotification: true,
        openFileFromNotification: true);
    FlutterDownloader.registerCallback((id, status, progress) {
      // 当下载完成时，调用安装
      if (taskId == id && status == DownloadTaskStatus.complete) {
        _installApk(_appPath);
      }
    });
  }

  // 安装
  Future<Null> _installApk(_appPath) async {
    // 本地资源访问
    // zmz_app为项目名
    const platform = const MethodChannel('zmz_app');
    try {
      // 调用app地址
      await platform.invokeMethod('install', {'path': _appPath + '/app-release.apk'});
    } on PlatformException catch (_) {
      // xxx
    }
  }

  // 暴露方法
  void checkAndUpate(BuildContext context) {
    // 可以在第一次打开APP时执行"版本更新"的网络请求
    _getApkLocalInfo().then((directory) {
      String _version = directory['version'];
      // 比较服务器的版本号跟当前的版本号，来判断要不要升级APP应用程序
      if (_checkVersionLowerOf(_version)) {
        String _appPath = directory['url'];
        // 弹出dalog询问是否升级
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('提示'),
              content: Text('有优化更新，赶紧体验一下吧。'),
              actions: [
                RaisedButton(
                  textColor: Colors.white,
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                ),
                RaisedButton(
                  textColor: Colors.white,
                  child: Text('确定'),
                  onPressed: () {
                    // 下载 并 安装新版本
                    _executeDownload(_appPath);
                    Navigator.maybePop(context);
                  },
                )
              ]
            );
          }
        );
      }
    });
  }

}