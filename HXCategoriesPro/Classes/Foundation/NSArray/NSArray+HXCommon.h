//
//  NSArray+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HXCommon)

/// 判断 NSArray 是否为空
/// @param array 需要判断的数组
+ (BOOL)isEmpty:(nullable NSArray *)array;

/// 判断 NSArray 是否安全
- (BOOL)isSafe;

/// 由基于 NSArray 类型的 plist 数据, 创建并返回新的 NSArray
/// @param plist 基于 NSArray 类型的 plist 数据
+ (nullable NSArray *)arrayWithPlistData:(NSData *)plist;

/// 由基于 NSArray 类型的 plist 字符串(XML), 创建并返回新的 NSArray
/// @param plist 基于 NSArray 类型的 plist 字符串(XML)
+ (nullable NSArray *)arrayWithPlistString:(NSString *)plist;

/// 将 NSArray 序列化为二进制 plist 数据
- (nullable NSData *)plistData;

/// 将 NSArray 序列化为 plist 字符串(XML)
- (nullable NSString *)plistString;

/// 随机返回一个对象
- (nullable id)randomObject;

/// 将对象转换为 json 字符串. 如果发生错误, 则返回 nil
/// 包括: NSString/NSNumber/NSDictionary/NSArray
- (nullable NSString *)jsonStringEncoded;

/// 将对象转换为 json 字符串格式化. 如果发生错误, 则返回 nil
- (nullable NSString *)jsonPrettyStringEncoded;

@end



@interface NSMutableArray (HXCommon)

/// 由基于 NSArray 类型的 plist 数据, 创建并返回新的 NSArray
/// @param plist A基于 NSArray 类型的 plist 数据
+ (nullable NSMutableArray *)arrayWithPlistData:(NSData *)plist;

/// 由基于 NSArray 类型的 plist 字符串(XML), 创建并返回新的 NSArray
/// @param plist 基于 NSArray 类型的 plist 字符串(XML)
+ (nullable NSMutableArray *)arrayWithPlistString:(NSString *)plist;

/// 移除第一个对象, 如果数组为空, 则此方法无效.
- (void)removeFirstObject;

/// 移除最后一个对象, 如果数组为空, 则此方法无效.
- (void)removeLastObject;

/// 取出第一个对象, 如果数组为空, 则返回nil
- (nullable id)popFirstObject;

/// 取出最后一对象, 如果数组为空, 则返回nil
- (nullable id)popLastObject;

/// 在数组的末尾插入给定的对象
/// @param anObject 要添加到数组末尾的对象
- (void)appendObject:(id)anObject;

/// 在数组的开头插入给定的对象
/// @param anObject 要添加到数组开头的对象
- (void)prependObject:(id)anObject;

/// 将一个 NSArray 添加到另一个 NSArray 的末尾
/// @param objects 尾部的那个 NSArray
- (void)appendObjects:(NSArray *)objects;

/// 将一个 NSArray 添加到另一个 NSArray 的开头
/// @param objects 尾部的那个 NSArray
- (void)prependObjects:(NSArray *)objects;

/// 将一个 NSArray 插入到另一个 NSArray 的指定索引处
/// @param objects 中间的那个 NSArray
/// @param index 要插入的索引值
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/// 使 NSArray 倒序
/// 例如: 使用前 @[ @1, @2, @3 ], 使用后 @[ @3, @2, @1 ]
- (void)reverse;

/// 随机排列此数组中的对象
- (void)shuffle;

@end

NS_ASSUME_NONNULL_END
