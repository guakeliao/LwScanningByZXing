# LwScanningByZxing

[![CI Status](http://img.shields.io/travis/liaowei/LwScanningByZxing.svg?style=flat)](https://travis-ci.org/liaowei/LwScanningByZxing)
[![Version](https://img.shields.io/cocoapods/v/LwScanningByZxing.svg?style=flat)](http://cocoapods.org/pods/LwScanningByZxing)
[![License](https://img.shields.io/cocoapods/l/LwScanningByZxing.svg?style=flat)](http://cocoapods.org/pods/LwScanningByZxing)
[![Platform](https://img.shields.io/cocoapods/p/LwScanningByZxing.svg?style=flat)](http://cocoapods.org/pods/LwScanningByZxing)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LwScanningByZxing is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LwScanningByZxing"
```


##HOW TO USE

 - ### LwScanView 扫描二维码
	1.用ZXing做的二维码扫面View,支持自定义扫描图层
	
	2.用法:
	- 支持用xib，直接将一个View改变成LwScanView，在VC中加入回调代码即可:
	
			    //扫描二维码
   				 self.scanVIew.callBack = ^(id data) {
   				 	//data即扫描得到的字符串
     				 NSLog(@"hello:%@", data);
   				};
  - ### UIViewController+Recognize 相册识别二维码
    1.用ZXing做的二维码识别VC
   
    2.用法:
    - 在你的VC中,引入类别UIViewController+Recognize即可，加入回调代码:
       
   	   		 //识别二维码
   			 [self recognizeImage:^(id string) {
			      NSLog(@"%@", string);
    		}];

    			
  - ### LwCreateView 生成二维码
    1.。。。

    2.用法:
    - 支持Xib,将一个View改变车让那个LwCreateView,在VC中加入执行回调代码即可:
  
   			 [self.createView createImage:CGSizeMake(1080, 1080)
                	   			successBlock:^(id image) {
        		    	       	self.imageView.image = image;
                    		}];

## Author

liaowei, 598951856@qq.com

## License

LwScanningByZxing is available under the MIT license. See the LICENSE file for more info.
