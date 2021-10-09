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

@property (nonatomic) HXThreadSafeArray *array;

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
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
