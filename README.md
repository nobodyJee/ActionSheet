# ActionSheet
ActionSheet 



[详细讲解在: 支持多种样式的自定义ActionSheet,了解一下](https://juejin.im/post/5b2716c16fb9a00e733f11d2)



### 使用
&emsp; 使用方法非常简单 一行代码搞定

```
 JWCActionSheet.actionSheet(titles: ["拍照","相册选取","取消"],headView:nil).show { (index, title) in
            print("index:\(index),title:\(String(describing: title))")
        }
```



### 几种效果图如下:

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style0.jpeg?raw=true)

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style1.jpeg?raw=true)

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style2.jpeg?raw=true)

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style3.jpeg?raw=true)

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style4.jpeg?raw=true)

![image](https://github.com/JiWuChao/ActionSheet/blob/master/JWCActionSheet/style5.jpeg?raw=true)

