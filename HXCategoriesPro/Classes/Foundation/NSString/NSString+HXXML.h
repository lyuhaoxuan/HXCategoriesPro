//
//  NSString+HXXML.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/11.
//  Copyright © 2019年 LHX. All rights reserved.
//

/*
 
 #import "NSString+HXXML.h"
 
 ...
 
 NSString *XMLString = @"<test>data</test>";
 NSDictionary *XMLAsDictionary = [XMLString hx_XMLDictionary];
 
 */

//https://github.com/AndrewHydeJr/NSString-XML
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HXXML)

/**
 xml字符串转换成NSDictionary

 @return NSDictionary
 */
- (nullable NSDictionary *)hx_XMLDictionary;

@end

NS_ASSUME_NONNULL_END
