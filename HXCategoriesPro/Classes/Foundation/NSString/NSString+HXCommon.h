//
//  NSString+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/5/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HXRelation) {
    Greater = 0,
    Less = 1,
    Equal = 2,
    Unordered = 3
};

@interface NSString (HXCommon)


///=============================================================================
/// 像 NSNumber 一样, 使用 NSString
///=============================================================================

@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsignedIntegerValue;

/// 获取 MIMEType
@property (readonly, copy) NSString *MIMEType;

/**
 判断字符串是否为空(安全字符串) 包括: nil, null, @"", @"\n", @"  "等

 @param string 字符串
 @return 空 --> YES,  非空 --> NO
 */
+ (BOOL)isEmpty:(nullable NSString *)string;

/**
 判断字符串是否安全 包括: nil, null, @"", @"\n", @"  "等

 @return 安全 --> YES,  不安全 --> NO
 */
- (BOOL)isSafe;

/**
 以1024作单位转换数据大小为 KB MB GB 等格式
 
 @param byteCount 大小
 @return 可能为 @""
 */
+ (NSString *)stringFromFileSize:(NSUInteger)byteCount;

/**
 以1000作单位转换数据大小为 KB MB GB 等格式
 
 @param byteCount 大小
 @return 可能为 @""
 */
+ (NSString *)stringFromDiskSize:(NSUInteger)byteCount;

/**
 生成随机字符。（可更改参数：长4位，字符表'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'）

 @return 随机字符
 */
+ (NSString *)getRandomString;

/** 去除头部和尾部的空白字符(空格和换行)。 */
- (NSString *)stringByTrim;

/** 移除结尾的子字符串 */
- (NSString *)removeLastSubString:(NSString *)string;

/** 尝试解析这个字符串并返回一个NSNumber */
- (nullable NSNumber *)numberValue;

/** NSString 转 NSData (UTF-8) */
- (NSData *)dataValue;

/** 返回 NSMakeRange(0, self.length). */
- (NSRange)rangeOfAll;

/**
 将 NSString 解码成 NSDictionary/NSArray, 如果发生错, 返回 nil
 
 例如: NSString: @"{"name":"a","count":2}"  => NSDictionary: @{@"name":@"a",@"count":@2}
 */
- (nullable id)jsonValueDecoded;

/**
 判断字符是否为纯数字

 @return YES or NO
 */
- (BOOL)isAllNum;

/**
 比较版本号大

 @param targetVersion 比较目标版本 eg: 3.2.0
 @return 0:大于、1:小于、2:等于、3:无序（失败）
 */
- (HXRelation)compareVesion:(NSString *)targetVersion;

/**
 处理URL，将 http:// 加上 s
 */
- (NSString *)handleURL;

/**
 从 mainBundle 中创建 NSString (类似于 [UIImage imageNamed:])
 
 @param name 在 mainBundle 中的文件名, 默认 txt
 
 @return 以UTF-8字符编码形式从文件创建一个新的字符串
 */
+ (nullable NSString *)stringNamed:(NSString *)name;

/// 获取 MIMEType
/// @param path 文件路径
+ (NSString *)mimeTypeForFileAtPath:(NSString *)path;


/// 计算字符串字节长度
- (NSUInteger)caculateStringInt;

@end

NS_ASSUME_NONNULL_END
