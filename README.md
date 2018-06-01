# ZBAlertView
提示弹出视图

![image](https://github.com/mqtJS/ZBAlertView/blob/master/2018-06-01%2012_21_04.gif)
# required
- swfit4+
# 一行代码使用
```swift
let alert = ZBAlertView(view: view, showString: "能帮助孩子提高思维敏感力和灵活性，同时在心理上更会提高孩子对学习")
        alert.show(duration: 3)// alert.show(duration: nil)参数传空，需手动调用hiden方法隐藏，非空时间过后自动隐藏
```
