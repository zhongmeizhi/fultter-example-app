import 'package:flutter/material.dart';
// App升级
import 'package:flutter_downloader/flutter_downloader.dart';
// 使用 MethodChannel
import 'package:flutter/services.dart';
import 'package:zmz_app/config/base_info.dart';

class _AppVersionInfo {
  String version;
  String url;
  _AppVersionInfo.formResponse(Map json) {
    this.version = json['version'];
    this.url = json['url'];
  }
}

class UpdateApp {

  // 检查版本是否低于某版本
  bool _checkVersionLowerOf (String version) {
    // 只有当前版本不等于最新版本，就说明版本落后了
    return version == Config.version;
  }

  // 获取安装地址
  Future<_AppVersionInfo> _getApkLocalInfo() async {
    // 不发请求了，下载个QQ试试
    final directory = {
      'version': '1.0.1',
      'url': 'https://qd.myapp.com/myapp/qqteam/AndroidQQi/qq_6.0.1.6600_android_r25029_GuanWang_537057608_release.apk'
    };
    return new _AppVersionInfo.formResponse(directory);
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
        FlutterDownloader.open(taskId: taskId);
      }
    });
  }

  // 暴露方法
  void checkAndUpate(BuildContext context) {
    // 可以在第一次打开APP时执行"版本更新"的网络请求
    _getApkLocalInfo().then((_AppVersionInfo directory) {
      if (_checkVersionLowerOf(directory.version)) {
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
                    _executeDownload(directory.url);
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