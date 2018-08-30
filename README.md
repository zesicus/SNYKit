# SNYKit

[![CI Status](https://img.shields.io/travis/zesicus/SNYKit.svg?style=flat)](https://travis-ci.org/zesicus/SNYKit)
[![Version](https://img.shields.io/cocoapods/v/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)
[![License](https://img.shields.io/cocoapods/l/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)
[![Platform](https://img.shields.io/cocoapods/p/SNYKit.svg?style=flat)](https://cocoapods.org/pods/SNYKit)

## 安装方法

可以通过 [CocoaPods](https://cocoapods.org) 的方式去安装：

```ruby
pod 'SNYKit'
```

## 使用说明

是一个便利工具集，也是日常开发逐渐积累下来的一些东西，整合在一起做个SDK吧，方便更新和使用。

虽然主要语言是Swift，但有些也有OC的一些工具（互补的），在Bridge文件里`#import <SNYKit/OCSword.h>`就好了。

SNYKit分为两部分：

* Extension 写在类扩展里面的工具方法
* Providers 其他变量和工具方法的集合

详细说明⤵：

### Extension

**Int.swift**文件：

* 毫秒转Date型日期

```Swift
12345000.getDate()
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

**CGFloat.swift & Double.swift**文件：生成随机数，同 Int

**Date.swift**文件：

* 日期转字符串

```Swift
Date().getStringDate(format: "yyyy-MM-dd HH:mm")
```

* 判别时间：刚刚、1分钟前、1小时前...

```Swift
Date().judgeTime()
```

**String.swift**文件：

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

**UIButton.swift**文件：

```Swift
//左边文字右边图片
thumUpBtn.setTitleRightImgLeft(title: "点赞", font: UIFont.systemFont(ofSize: 12.0), fontColor: .leastBlack, image: #imageLiteral(resourceName: "like"), dist: 10.0)
//右边文字左边图片
thumUpBtn.setTitleLeftImgRight(title: "点赞", font: UIFont.systemFont(ofSize: 12.0), fontColor: .leastBlack, image: #imageLiteral(resourceName: "like"), dist: 10.0)
```

**UIColor.swift**文件：

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

**UIImage.swift**文件：

* 压缩图片

```Swift
image.compressImage(toByte: 100 * 1024)
```

**UIImageView.swift**文件：

* 填充虚线，注意view的高度

```Swift
imageView.fillImaginaryLine()
```

* Kingfisher 需要关闭注释

```Swift
//设置无缓存网络图片
imageView.setNetImgNoCache(urlString: "http://baidu.com/abc.jpg")
//设置网络图片
imageView.setNetImg(urlString: "http://baidu.com/abc.jpg")
```

**UIView.swift**文件：

* 适用于提示框弹出的动画展示效果, with后面跟的是阴影遮罩，手动传入

```Swift
//弹出
exchangeView.animateIn(parentVC: self.navigationController!, with: backgroundView)
//消失
exchangeView.animateOut(with: backgroundView)
```

**UIViewController.swift**文件：

* 导航栏左右按钮

```Swift
//左导航栏图片按钮
addLefttBarButtonItem(navigationItem, image: #imageLiteral(resourceName: "bar_search"), target: self, action: #selector(searchAction))
//右导航栏图片按钮
addRightBarButtonItem(navigationItem, image: #imageLiteral(resourceName: "bar_post"), target: self, action: #selector(rightBtnAction))
//左导航栏文字按钮
addLeftBarButtonItem(navigationItem, title: "左按钮", titleColor: .red, target: self, action: #selector(leftAction))
//右导航栏文字按钮
addRightBarButtonItem(navigationItem, title: "右按钮", titleColor: .blue, target: self, action: #selector(rightAction))
```

### Providers

**Sword.swift**文件：

可以直接调用的公共属性

* App版本属性`appVersion`
* Userdefaults.standard直接调用`defaults`
* NotificationCenter.default直接调用`defaultNoti`
* 机器唯一识别码`uuid`
* Documents文件夹路径`documentsDirectory`
* 在Debug环境打印Release环境不打印请使用`dprint("Hello, world!")`

**OCSword.h & OCSword.m**文件：

在桥接文件中导入头文件后可在swift中使用：

* 十六进制颜色（这个只能在OC文件中使用） `COLOR_WITH_HEX(0xff4445)`

* 颜色生成图片

```Swift
OCSword.createImage(with: .red)
```

* 改变字符串中个别字符的颜色

```Swift
OCSword.returnColorfulString("确认授权并同意《用户授权协议》", keyword: "《用户授权协议》", color: .mainTheme)
```

* 改变字符串中许多字符的颜色，比如只把字符串中的数字变色

```Swift
OCSword.returnColorfulString("我是\(Profile.nickName ?? "")，掘金联盟第 \(rankNum) 号成员", which: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"], color: .mainTheme)
```

* 给你的Layer加一个过渡效果，这样比如Push出来的页面会有不同动画效果，方法里面有详细说明

```Swift
OCSword.addAnimation(self.view.layer, type: "rotate")
```

* 生成整个View截图，当然如果想截长图传个ScrollView就好了

```Swift
OCSword.generateImage(from: self.tableView, size: self.tableView.contentSize)
```

* 输入日期显示星期几

```Swift
OCSword.getWeek(Date())
```

* 地理位置坐标转化

```Swift
let ocsword = OCSword.init(latitude: 123, andLongitude: 123)
//从GPS坐标转化到高德坐标
ocsword?.transformFromGPSToGD().latitude
ocsword?.transformFromGPSToGD().longitude
//从高德坐标转化到百度坐标
ocsword?.transformFromGDToBD().latitude
ocsword?.transformFromGDToBD().longitude
//从百度坐标到高德坐标
ocsword?.transformFromBDToGD().latitude
ocsword?.transformFromBDToGD().longitude
//从高德坐标到GPS坐标
ocsword?.transformFromGDToGPS().latitude
ocsword?.transformFromGDToGPS().longitude
//从百度坐标到GPS坐标
ocsword?.transformFromBDToGPS().latitude
ocsword?.transformFromBDToGPS().longitude
```

* 取得Label里文字数组，或许你可以拿来判断一下行数

```Swift
OCSword.getLinesArrayOfString(in: cell?.detailLabel)
```

* 跳动的View，加载多个类似于蚂蚁森林的感觉

```Swift
OCSword.jumpAnimationView(jumpView)
```

* 检查手机号

```Swift
OCSword.checkTel("12345")
```

**Screen.swift**文件：屏幕尺寸快捷调用在这里

**GCD.swift**文件：GCD封装纯属个人偏好。

* 延迟执行方法，传入延迟时间，执行线程，走回调。
```swift
GCD.after(time: 1.5, queue: GCD.main, callBack: {
	print("延迟1.5秒打印我")
})
```

**AppStates.swift**文件：存储一些全局的判断条件，还有：

* 判断App是否在前台`AppStates.foreground()`
* 判断App是否在后台：`AppStates.background()`
* 判断App是否处在非活跃状态：`AppStates.inactive()`

**AlamofireManager.swift**文件：Alamofire 600 秒长链接，如果需要可以调的更长一点，注释起来的，需要的可以打开。

## License

SNYKit is available under the MIT license. See the LICENSE file for more info.
