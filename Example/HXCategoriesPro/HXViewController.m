//
//  HXViewController.m
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 12/21/2020.
//  Copyright (c) 2020 吕浩轩. All rights reserved.
//

#import "HXViewController.h"
#import <HXCategories.h>
#import <YYKit.h>

@interface HXViewController ()

@property (nonatomic) HXSafeMutableArray *array;

@property (atomic) NSMutableArray *tempAarray;

@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *UUID = [NSString hx_UUID];
    
    NSLog(@"UUID:%@", UUID);
    
    NSLog(@"MIMEType:%@", @"/Users/lvhaoxuan/Desktop/截屏2021-05-19 14.36.07.png".MIMEType);
    NSLog(@"MIMEType:%@", @"wav".MIMEType);
    NSLog(@"MIMEType:%@", @".aac".MIMEType);
    NSLog(@"MIMEType:%@", @"123.mp3".MIMEType);
    
    self.array = [HXSafeMutableArray array];
    self.tempAarray = [[YYThreadSafeArray alloc] init];
    
    CFAbsoluteTime currentTime0 = CFAbsoluteTimeGetCurrent();
    for (int i = 0; i < 100000; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            NSString *str = [NSString stringWithFormat:@"%d",i];
            [self.array addObject:str];
            CFAbsoluteTime currentTime1 = CFAbsoluteTimeGetCurrent();
            NSLog(@"耗时：%f", currentTime1 - currentTime0);
        });
    }
    
//    CFAbsoluteTime currentTime00 = CFAbsoluteTimeGetCurrent();
//    for (int i = 0; i < 100000; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSString *str = [NSString stringWithFormat:@"%d",i];
//            [self.tempAarray addObject:str];
//            CFAbsoluteTime currentTime01 = CFAbsoluteTimeGetCurrent();
//            NSLog(@"耗时：%f", currentTime01 - currentTime00);
//        });
//    }
    
    
    
//    for (int i = 0; i < 10000; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            NSString *str = [NSString stringWithFormat:@"%d",i];
//            [self.tempAarray addObject:str];
//        });
//    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//        for (NSString *index in self.array) {
//            NSLog(@"self.array: %@", index);
//        }
//
//        for (NSString *index in self.tempAarray) {
//            NSLog(@"self.tempAarray: %@", index);
//        }
//
//
////        // tempArray的访问
////        dispatch_queue_t queue_t00 = dispatch_queue_create("dispatch_queue00", DISPATCH_QUEUE_CONCURRENT);
////        dispatch_queue_t queue_t01 = dispatch_queue_create("dispatch_queue01", DISPATCH_QUEUE_CONCURRENT);
////        CFAbsoluteTime currentTime0 = CFAbsoluteTimeGetCurrent();
////        dispatch_apply(5000, queue_t00, ^(size_t index0) {
////            NSLog(@"1 --- %@",[self.tempAarray objectAtIndex:index0]);
////        });
////        dispatch_apply(5000, queue_t01, ^(size_t index0) {
////            NSLog(@"2 --- %@",[self.tempAarray objectAtIndex:index0+4999]);
////        });
////        CFAbsoluteTime totalTime0 = CFAbsoluteTimeGetCurrent() - currentTime0;
////
////        // array的访问
////        dispatch_queue_t queue_t10 = dispatch_queue_create("dispatch_queue10", DISPATCH_QUEUE_CONCURRENT);
////        dispatch_queue_t queue_t11 = dispatch_queue_create("dispatch_queue11", DISPATCH_QUEUE_CONCURRENT);
////        CFAbsoluteTime currentTime1 = CFAbsoluteTimeGetCurrent();
////        dispatch_apply(5000, queue_t10, ^(size_t index1) {
////            NSLog(@"3 --- %@",[self.array objectAtIndex:index1]);
////        });
////        dispatch_apply(5000, queue_t11, ^(size_t index1) {
////            NSLog(@"4 --- %@",[self.array objectAtIndex:index1 + 4999]);
////        });
////        CFAbsoluteTime totalTime1 = CFAbsoluteTimeGetCurrent() - currentTime1;
////
////        // 两个访问时间对比
////        NSLog(@"totalTime0:%f - totalTime1:%f",totalTime0,totalTime1);
//    });
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
