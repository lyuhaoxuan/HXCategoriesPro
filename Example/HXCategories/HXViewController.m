//
//  HXViewController.m
//  HXCategories
//
//  Created by 吕浩轩 on 12/21/2020.
//  Copyright (c) 2020 吕浩轩. All rights reserved.
//

#import "HXViewController.h"
#import <HXCategories.h>

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSString *UUID = [NSString hx_UUID];
    
    NSLog(@"UUID:%@", UUID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
