# SNYKit

[![CI Status](https://img.shields.io/travis/zesicus/SNYKit.svg?style=flat)](https://travis-ci.org/zesicus/SNYKit)
[![Version](https://img.shields.io/cocoapods/v/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)
[![License](https://img.shields.io/cocoapods/l/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)
[![Platform](https://img.shields.io/cocoapods/p/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)

## About

日常开发逐渐积累下来的一个 iOS 便利工具集。

主要使用 Swift，还有一些用到的基于 OC 的方法（还有许多搜集到的工具代码，经自己测试和修改确保可用且应用于项目，并在此对借鉴代码的作者们说声谢谢！🙏）。

已添加的依赖库：

```
v2.1 以上
'ReachabilitySwift', '4.3.1'
v2.4 以上
'Kingfisher', '5.3.1'
```

## Installation

支持通过 [CocoaPods](https://cocoapods.org) 的方式去集成：

```ruby
pod 'SNYKit'
```

## How to Use

SNYKit有两个单拎出来的工具类 `SNY` (Swift) 和 `SNYOC` (Objective-C)， 的以及一些类的扩展 (Swift)。  

下面是详细介绍⤵：

### *SNY* 🍋

<details>
 <summary>Debug环境打印函数</summary>
 
 ```Swift
 dprint("hello")
 ```
 
</details> 

<details>
 <summary>App状态判断</summary>

```Swift
//判断App是否在前台并且能有效接收事件
SNY.appStates.isForeground

//判断App是否在后台运行
SNY.appStates.isBackground

//判断App是否在非活跃状态，这种状态可能处于正在将App转移到后台或者把app调起到前台时
SNY.appStates.isInactive
```

具体请参考 `UIApplication.shared.applicationState`

> 除了比较懒的写系统的写法，再就是我也只需要个判断。

</details>

<details>
 <summary>屏幕尺寸</summary>
 
 * 不说你们都懂得
 
 ```Swift
SNY.screen.frame
SNY.screen.height
SNY.screen.width
SNY.screen.scale
 ```
 
</details>



<details>
 <summary>GCD定时器</summary>
 
* 主线程 `GCD.main`
* 高优先后台线程 `GCD.globalHigh`
* 一般后台线程 `GCD.global`
* 标签线程: `GCD.seria(label: "hello")`
* 分组线程(default组) `GCD.concurrent(label: "hello")`

* 延迟执行

```Swift
//延迟 1 秒执行
SNY.gcd.after(time: 1.0, queue: GCD.main) {
	dprint("Hello")
}
```

> 当然，上面这个方法也可以用下面定时器执行

* 定时器

```
//设置循环定时器，1秒执行一次
SNY.gcd.scheduledDispatchTimer(WithTimerName: "hello", timeInterval: 1.0, queue: GCD.main, repeats: true) {
    dprint("Hello")
}

//检查定时器是否存在
SNY.gcd.isExistTimer(WithTimerName: "hello")

//销毁定时器
SNY.gcd.cancleTimer(WithTimerName: "hello")
```

 
</details>

<details>
 <summary>App版本</summary>
 
 ```Swift
 SNY.appVersion
 ```
 
</details> 

<details>
 <summary>UserDefaults</summary>
 
 ```Swift
 SNY.defaults.set...
 ```
 
</details> 

<details>
 <summary>NotificationCenter</summary>
 
 ```Swift
 SNY.defaultNoti.post...
 ```
 
</details> 

<details>
 <summary>设备UUID</summary>
 
 ```Swift
 SNY.uuid
 ```
 
</details> 

<details>
 <summary>Documents文件夹路径</summary>
 
 ```Swift
SNY.documentsPath
 ```
 
</details> 

<details>
 <summary>运营商信息</summary>
 
 返回一个元祖，包含 
 
 * 运营商名 carrierName 例 中国联通
 * 国家代码(大写) carrierName 例 CN
 * 网络制式 networkType 例 4G


```Swift
SNY.getCarrier()
```
 
</details> 

<details>
 <summary>设备使用权限判断</summary>
 
 * 网络使用权限
 
 ```Swift
 switch SNY.netPermission {
    case .notRestricted:
        dprint("无限制")
        break
    case .restricted:
        dprint("网络限制")
        break
    case .restrictedStateUnknown:
        dprint("未设置过网络权限时是这个状态")
        break
    default:
        break
 }
 ```
 
 * 相册使用权限

 ```Swift
 switch SNY.photoAlbumPermission {
    case .authorized:
        dprint("已授权")
        break
    case .denied:
        dprint("已阻止")
        break
    case .notDetermined:
        dprint("未知")
        break
    case .restricted:
        dprint("未授权，可能是家长控制权限")
        break
 }
 ```
 
 * 相机使用权限

 ```Swift
 switch SNY.cameraPermission {
    case .authorized:
        dprint("已授权相机")
        break
    case .denied:
        dprint("拒绝使用相机")
        break
    case .restricted:
        dprint("受限制的")
        break
    case .notDetermined:
        dprint("系统未知，可能第一次开启app时状态是这样的")
        break
 }
 ```
 
 * 麦克风使用权限

 ```Swift
 switch SNY.microphonePermission {
    case .authorized:
        dprint("已授权麦克风")
        break
    case .denied:
        dprint("已拒绝麦克风")
        break
    case .restricted:
        dprint("受限制的")
        break
    case .notDetermined:
        dprint("系统未知，可能第一次开启app时状态是这样的")
        break
 }
 ```
 
 * 推送权限

 ```Swift
 if SNY.pushPermission {
     dprint("推送已开启")
 } else {
     dprint("推送未开启/未知")
 }
 ```
 
 * 定位权限

 ```Swift
 if SNY.locationPermission {
     dprint("GPS可用")
 } else {
     dprint("GPS不可用")
 }
 ```
 
 
</details> 
 

### *SNYOC* 🌶

<details>
 <summary> UIView 深复制 </summary>

```Swift
let theView = UIView()
let cpView = SNYOC.copy(theView)
```
 
</details> 

<details>
 <summary> 多彩字 </summary>
 
 * 改变字符串中个别字符的颜色

```Swift
SNYOC.returnColorfulString("确认授权并同意《用户授权协议》", keyword: "《用户授权协议》", color: .mainTheme)
```

* 改变字符串中许多字符的颜色，比如只把字符串中的数字变色

```Swift
SNYOC.returnColorfulString("我是\(Profile.nickName ?? "")，掘金联盟第 \(rankNum) 号成员", which: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], color: .mainTheme)
```
 
</details> 


<details>
 <summary> 页面过渡效果 </summary>
 
 * 给你的Layer加一个过渡效果，这样比如Push出来的页面会有不同动画效果，方法里面有详细说明

```Swift
SNYOC.addAnimation(self.view.layer, type: "rotate")
```
 
</details>  


<details>
 <summary> View controller 截长图 </summary>
 
 * 生成整个View截图，当然如果想截长图传个ScrollView就好了

```Swift
SNYOC.generateImage(from: self.tableView, size: self.tableView.contentSize)
```
 
</details>   


<details>
 <summary> 日期转星期 </summary>

* 输入日期显示星期几

```Swift
SNYOC.getWeek(Date())
```
 
</details>   


<details>
 <summary> 地理位置坐标转化 </summary>

```Swift
let snyoc = SNYOC.init(latitude: 123, andLongitude: 123)

//从GPS坐标转化到高德坐标
snyoc?.transformFromGPSToGD().latitude
snyoc?.transformFromGPSToGD().longitude

//从高德坐标转化到百度坐标
snyoc?.transformFromGDToBD().latitude
snyoc?.transformFromGDToBD().longitude

//从百度坐标到高德坐标
snyoc?.transformFromBDToGD().latitude
snyoc?.transformFromBDToGD().longitude

//从高德坐标到GPS坐标
snyoc?.transformFromGDToGPS().latitude
snyoc?.transformFromGDToGPS().longitude

//从百度坐标到GPS坐标
snyoc?.transformFromBDToGPS().latitude
snyoc?.transformFromBDToGPS().longitude
```
 
</details>


<details>
 <summary> 取得当前显示Label里文字数组 </summary>
 
 * 取得当前显示Label里文字数组，或许你可以拿来判断一下行数，然后判断展开收缩

```Swift
SNYOC.getLinesArrayOfString(in: cell?.detailLabel)
```
 
</details>


<details>
 <summary> 浮动View </summary>
 
 * 跳动的View，加载多个类似于蚂蚁森林的感觉

```Swift
SNYOC.jumpAnimationView(jumpView)
```
 
</details>


<details>
 <summary> 检查手机号 </summary>
 
 * 返回 true 或 false
 
```Swift
SNYOC.checkTel("12345")
```
 
</details> 


<details>
 <summary> 颜色生成图片 </summary>
 
 * 颜色生成 UIImage (Extension UIColor 同样有实现)

```Swift
let redImg = SNYOC.createImage(with: .red)
```
 
</details> 


### *Extension扩展* 🥝

<details>
 <summary>Int、CGFloat、Double</summary>
 
* 解决精度丢失 (Double -> String)

```Swift
let fixedNumStr = num.decimalStr
```

* 秒转Date型日期 (毫秒自行 x 1000)

```Swift
let date = timeStamp.getDate()
```

* 毫秒转字符型日期

```Swift
12345000.getStringDate(format: "yyyy-MM-dd HH:mm")
```

* 生成随机数

```Swift
// 生成 0 - Max 中的随机数
Int.random
//生成 0 - n-1 之间的随机数
Int.random(n: 10)
//生成 min - max 之间的随机数
Int.random(min: 1, max: 10)
```
 
</details> 

<details>
 <summary>Date</summary>
 
 * 日期转字符串

```Swift
Date().getStringDate(format: "yyyy-MM-dd HH:mm")
```

* 判别时间：刚刚、1分钟前、1小时前...

```Swift
Date().judgeTime()
```
 
</details> 

<details>
 <summary>String</summary>
 
* 将身份证号除前三位和后四位，中间用*号表示

```Swift
let idNum = "311119199303252222"
let hideIdNum = idNum.hideIDCardNo
```
 
* 随机MD5，这部分给注释掉了，使用则在桥接文件中`#import <CommonCrypto/CommonCrypto.h>`

```Swift
String.randomMD5()
```

* 获得字符串宽度

```Swift
"getw".getWidth(size: 15)
```

* HTML字符串本地富文本

```Swift
"<HTML>".html2AttributedString
```

* HTML字符串本地纯文本

```Swift
"<HTML>".html2String
```

* 获得带有行间距的字符串，lineSpacing：行间距，charSpacing：字间距

```Swift
getLineSpacing(lineSpacing: 1, charSpacing: 1)
```

* 存储文件标记不同步iCloud

```Swift
path.excludeFromBackup()
```

* 截取字符串

```Swift
"12345".substring(toIndex: 1)
"1123".substring(fromIndex: 1)
```

* 字符串转为字符数组

```Swift
"1123".toCharArray()
```

* 播放声音

```Swift
musicPath.playSound()
```
 
</details> 

<details>
 <summary>UIButton</summary>
  
```Swift
//左边文字右边图片
thumUpBtn.setTitleRightImgLeft(title: "点赞", font: UIFont.systemFont(ofSize: 12.0), fontColor: .leastBlack, image: UIImage(named: "like"), dist: 10.0)

//右边文字左边图片
thumUpBtn.setTitleLeftImgRight(title: "点赞", font: UIFont.systemFont(ofSize: 12.0), fontColor: .leastBlack, image: UIImage(named: "like"), dist: 10.0)
```

</details> 


<details>
 <summary>UIColor</summary>
 
* 随机颜色

```Swift
UIColor.randomColor()
``` 
 
* 不用除255的便利方法

```Swift
UIColor(r: 12, g: 22, b: 125)
```

* 16进制颜色

```Swift
UIColor(hex: 0x3E609E)
```

* 纯色图片

```Swift
UIColor.red.getImage()
```
 
</details>  


<details>
 <summary>UIImage</summary>
 
 * 压缩图片

```Swift
image.compressImage(toByte: 100 * 1024)
```
 
</details> 


<details>
 <summary>UIImageView</summary>
 
* 设置图片形状模版 (如 聊天气泡样式图片)

```Swift
imgView.maskPic(image: img, with: bubbleImg)
```
 
* 设置圆角（便利方法）

```Swift
imgView.setCorner(radius: 4.0)
```
 
* 填充虚线，注意view的高度

```Swift
imageView.fillImaginaryLine()
```
* 修复垂直拍摄照片旋转90度问题

```Swift
let fixedImg = originImg.fixOrientation()
```

* 设置网络图片

```Swift
/// 有缓存式设置网络图片
///
/// - Parameters:
///   - urlString: 网络图片地址
///   - placeholder: 占位图
public func setNetImg(urlString: String, placeholder: UIImage? = UIImage(named: "sny_default_img"))

/// 无缓存式设置网络图片
///
/// - Parameters:
///   - urlString: 网络图片地址
///   - placeholder: 占位图
public func setNetImgNoCache(urlString: String, placeholder: UIImage? = UIImage(named: "sny_default_img"))
```
 
</details> 


<details>
 <summary>UIView</summary>
 
 * 适用于从下往上滑动入场效果，如需要阴影遮罩，传入遮罩UIView实例

 ```Swift
 //滑入
 optionsView.slideIn(parentVC: self, bounds: CGRect(x: 0, y: 0, width: SNY.screen.width, height: 200), with: bgView)
 //滑出
 optionsView.slideOut(with: bgView)
 ```
 
 * 适用于提示框弹出的动画展示效果, with后面跟的是阴影遮罩，手动传入

```Swift
//弹出
exchangeView.animateIn(parentVC: self.navigationController!, with: backgroundView)

//消失
exchangeView.animateOut(with: backgroundView)
```
 
</details> 


<details>
 <summary>UIViewController </summary>
 
* 跳过返回主控制器

```Swift
func backToRootVC(popAnimation: Bool, dismissAnimation: Bool)
```

* 导航栏左右按钮

```Swift
//左导航栏图片按钮
addLefttBarButtonItem(navigationItem, image: #imageLiteral(resourceName: "bar_search"), target: self, action: #selector(searchAction))

//右导航栏图片按钮
addRightBarButtonItem(navigationItem, image: #imageLiteral(resourceName: "bar_post"), target: self, action: #selector(rightBtnAction))

//左导航栏IconFont按钮
addIconFontLeftBarButtonItem(navigationItem, unicode: "\u{e604}", color: .white, target: self, action: #selector(h))

//右导航栏IconFont按钮
addIconFontRightBarButtonItem(navigationItem, unicode: "\u{e604}", color: .white, target: self, action: #selector(h))

//左导航栏多个文字按钮
addLeftBarButtonItem(navigationItem, title: "左按钮", titleColor: .red, target: self, action: #selector(leftAction))

//右导航栏多个文字按钮
addRightBarButtonItem(navigationItem, title: "右按钮", titleColor: .blue, target: self, action: #selector(rightAction))

//左导航栏多个文字按钮
addIconFontLeftBarButtonItems(navigationItem, unicodes: ["\u{e604}", "\u{e604}", "\u{e604}"], colors: Array.init(repeating: .white, count: 3), dist: 20, target: self, action: [#selector(h), #selector(h), #selector(h)])

//右导航栏多个文字按钮
addIconFontRightBarButtonItems(navigationItem, unicodes: ["\u{e604}", "\u{e604}", "\u{e604}"], colors: Array.init(repeating: .white, count: 3), dist: 20, target: self, action: [#selector(h), #selector(h), #selector(h)])

```

</details> 

<details>
 <summary>UITextField</summary>

* 设置 Placeholder，颜色，字体可选

```Swift
field.setPlaceholder("hello", color: .red)
field.setPlaceholder("hello", font: UIFont.systemFont(ofSize: 30))
field.setPlaceholder("hello", color: .red, font: UIFont.systemFont(ofSize: 50))
```
 
</details>


## License

SNYKit is available under the MIT license. See the LICENSE file for more info.
