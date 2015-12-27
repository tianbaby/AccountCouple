//
//  main.m
//  Client
//
//  Created by 田月 on 15/12/27.
//  Copyright © 2015年 com.tianbaby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h" // 这个是个委托,每个应用程序都会有一个AppDelegate

// 这个是入口
int main(int argc, char * argv[]) {
    
    // 内存释放池
    @autoreleasepool {
        // 直接查看ViewController中的代码 AppDelegate不用看
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
