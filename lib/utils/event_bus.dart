// /*
//  * Created by Flutter中文网
//  * 此代码 系 copy
//  * 出处见 页头
//  * 仅学习使用。mark
//  */

// //订阅者回调签名
// typedef void EventCallback(arg);

// class EventBus {
//   //私有构造函数
//   EventBus._internal();

//   // Dart中实现单例模式的标准做法就是：使用static变量 + 工厂构造函数的方式
//   // 这样就可以保证new EventBus()始终返回都是同一个实例

//   //保存单例
//   static EventBus _singleton = new EventBus._internal();
//   //工厂构造函数
//   factory EventBus() => _singleton;

//   //保存事件订阅者队列，key:事件名(id)，value: 对应事件的订阅者队列
//   var _emap = new Map<Object, List<EventCallback>>();

//   //添加订阅者
//   void on(eventName, EventCallback f) {
//     if (eventName == null || f == null) return;
//     _emap[eventName] ??= new List<EventCallback>();
//     _emap[eventName].add(f);
//   }

//   //移除订阅者
//   void off(eventName, [EventCallback f]) {
//     var list = _emap[eventName];
//     if (eventName == null || list == null) return;
//     if (f == null) {
//       _emap[eventName] = null;
//     } else {
//       list.remove(f);
//     }
//   }

//   //触发事件，事件触发后该事件所有订阅者会被调用
//   void emit(eventName, [arg]) {
//     var list = _emap[eventName];
//     if (list == null) return;
//     int len = list.length - 1;
//     //反向遍历，防止在订阅者在回调中移除自身带来的下标错位 
//     for (var i = len; i > -1; --i) {
//       list[i](arg);
//     }
//   }
// }

// /**
// * // 页面A中
// * 监听登录事件
// * bus.on("login", (arg) {
// *   doFunction
// * });
// *
// * 登录页B中
// * 登录成功后触发登录事件，页面A中订阅者会被调用
// * bus.emit("login", userInfo);
// *
// */