//
//  ViewController.m
//  Client
//
//  Created by 田月 on 15/12/27.
//  Copyright © 2015年 com.tianbaby. All rights reserved.
//

#import "ViewController.h"
#import <AVOSCloud/AVOSCloud.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property float money;
@end

@implementation ViewController

/*
 * 界面加载完会调用该方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.money = 0;
    self.resultLabel.text = [NSString stringWithFormat:@"总计:%.2f元",self.money];
    
    
    // 开启定时访问服务器
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)tick:(float) dt
{

    [self queryMoney];
    [self showResult];

}

- (void) queryMoney
{
    AVQuery *query = [AVQuery queryWithClassName:@"ACount"];
    id array = [query findObjects];
    
    float sum = 0.0f;
    
    for (AVObject *obj in array)
    {
        sum += [[obj valueForKey:@"money"] floatValue];
    }
    
    self.money = sum;
}

- (void) showResult {
    self.resultLabel.text = [NSString stringWithFormat:@"总计:%.2f元",self.money];

}


- (IBAction)record {
    if ([self.textField.text floatValue])
    {
        
        AVObject *testObject = [AVObject objectWithClassName:@"ACount"];
        [testObject setObject:[NSNumber numberWithFloat:[self.textField.text floatValue]] forKey:@"money"];
        [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                
                [self tick:0.1f];
                
                [self showResult];
            }
        }];
        
        self.textField.text = @"";
    }
}

/*
 * 内存不够用的时候调用该方法
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
