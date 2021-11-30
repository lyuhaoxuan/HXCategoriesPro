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
    
    NSString *UUID = [NSString UUID];
    
    NSLog(@"UUID:%@", UUID);
    
    NSLog(@"MIMEType:%@", @"/Users/lvhaoxuan/Desktop/截屏2021-05-19 14.36.07.png".MIMEType);
    NSLog(@"MIMEType:%@", @"wav".MIMEType);
    NSLog(@"MIMEType:%@", @".aac".MIMEType);
    NSLog(@"MIMEType:%@", @"123.mp3".MIMEType);
    
//    NSMutableDictionary *p = [NSMutableDictionary dictionary];
//    [p setValue:@"" forKey:@""];
//    [p setValue:@"" forKey:@""];
//    [p setValue:@"" forKey:@""];
//    [p setValue:@"" forKey:@""];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"Json" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:jsonPath];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    NSString *dateString = [[NSDate date] stringWithISOFormat];
    NSDate *date = [NSDate dateWithString:@"2022-05-07T07:39:18Z"];
    
    NSLog(@"weekday         %ld", [date weekday]);
    NSLog(@"weekOfMonth     %ld", [date weekOfMonth]);
    NSLog(@"weekOfYear      %ld", [date weekOfYear]);
    
    MyModel *model = [MyModel modelWithJSON:data];
    
    NSLog(@"model:%@", [model.date stringWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"]);
    
    MAX(1, 2);
    NSInteger aaa = CLAMP(3, 2, 40);
    NSInteger bb = 444;
    SWAP(aaa, bb);
    NSLog(@"model:%@", [model.date stringWithFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"]);
    
    
    
    
    NSString * result = @"http://demo.demo.com/demo?{userToken:按时发斯蒂芬}";
    NSLog(@"result: = %@",result.URLEntityEncode);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
