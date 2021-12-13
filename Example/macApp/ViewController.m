//
//  ViewController.m
//  macApp
//
//  Created by lyuhaoxuan on 2021/12/2.
//  Copyright © 2021 吕浩轩. All rights reserved.
//

#import "ViewController.h"
#import <HXCategories.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", [UIDevice currentDevice].name);
    NSLog(@"%@", [UIDevice currentDevice].model);
    NSLog(@"%@", [UIDevice currentDevice].systemName);
    NSLog(@"%@", [UIDevice currentDevice].systemVersion);
    NSLog(@"%@", [UIDevice currentDevice].systemBuildVersion);
    NSLog(@"%@", [UIDevice currentDevice].UUID);
    NSLog(@"%@", [UIDevice currentDevice].serialNumber);
    
    NSButton *btn = [[NSButton alloc] init];
    [btn setTitleColor:NSColor.redColor];
    
    NSLog(@"%@", [[HXDevice currentDevice] ipAddressWIFI]);

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


@end
