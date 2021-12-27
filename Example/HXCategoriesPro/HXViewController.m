//
//  HXViewController.m
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 12/21/2020.
//  Copyright (c) 2020 吕浩轩. All rights reserved.
//

#import "HXViewController.h"
#import <HXCategories.h>
#import "MyModel.h"

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSData *UUID = [NSString UUID];
    
    NSLog(@"UUID:%@", UUID);
    
    NSLog(@"MIMEType:%@", @"/Users/lvhaoxuan/Desktop/截屏2021-05-19 14.36.07.png".MIMEType);
    NSLog(@"MIMEType:%@", @"wav".MIMEType);
    NSLog(@"MIMEType:%@", @".aac".MIMEType);
    NSLog(@"MIMEType:%@", @"123.mp3".MIMEType);
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Json" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSString *dateString = [[NSDate date] ISOFormatString];
    NSDate *date = [NSDate dateWithString:@"2022-05-07T07:39:18Z"];
    
    NSLog(@"weekday         %ld", [date weekday]);
    NSLog(@"weekOfMonth     %ld", [date weekOfMonth]);
    NSLog(@"weekOfYear      %ld", [date weekOfYear]);
    
    MyModel *model = [MyModel modelWithJSON:data];
    
    NSLog(@"model:%@", [model.date stringWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"]);

    NSString *strName = [[UIDevice currentDevice] name];
    NSLog(@"设备名称：%@", strName);//e.g. "My iPhone"
    NSString *strModel = [[UIDevice currentDevice] model];
    NSLog(@"设备模式：%@", strModel);// e.g. @"iPhone", @"iPod touch"
    
    NSString *strSysName = [[UIDevice currentDevice] systemName];
    NSLog(@"系统名称：%@", strSysName);// e.g. @"iOS"
    
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"系统版本号：%@", strSysVersion);// e.g. @"4.0"
    
    NSLog(@"%@", [UIDevice currentDevice].machineModel);
    NSLog(@"%@", [UIDevice currentDevice].machineModelName);
    
    NSLog(@"局域网 IP: %@", [UIDevice currentDevice].local_IP);
    NSLog(@"蜂窝数据 IP: %@", [UIDevice currentDevice].cellular_IP);
    
    
    
    NSMutableDictionary *p = [NSMutableDictionary dictionary];
    [p setValue:@"2啊" forKey:@"A啊"];
    [p setValue:@"2啊" forKey:@"A啊1"];
    [p setValue:@"2啊" forKey:@"A啊2"];
    [p setValue:@"2啊" forKey:@"A啊3"];
    
    NSLog(@"%@", p.queryStringFromParameters);
    
    // nil, null, @"", @"\n", @"  "
    NSString *stt = [NSNull null];
    
    if (stt.isSafe) {
        NSLog(@"safe");
    } else {
        NSLog(@"no safe");
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
