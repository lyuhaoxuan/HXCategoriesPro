//
//  NSDictionary+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (HXCommon)

/**
 判断 NSDictionary 是否安全

 @return 安全 --> YES,  不安全 --> NO
 */
- (BOOL)isSafe;

#pragma mark - Dictionary Convertor

/**
 由基于 NSDictionary 类型的 plist 数据, 创建并返回新的 NSDictionary
 
 @param plist   基于 NSDictionary 类型的 plist 数据
 @return 由 plist 数据创建新的 NSDictionary, 如果发生错误则为nil
 */
+ (nullable NSDictionary *)dictionaryWithPlistData:(NSData *)plist;

/**
 由基于 NSDictionary 类型的 plist 字符串(XML), 创建并返回新的 NSDictionary
 
 @param plist   基于 NSDictionary 类型的 plist 字符串(XML)
 @return 由 plist 字符串(XML) 创建新的 NSDictionary, 如果发生错误则为 nil
 */
+ (nullable NSDictionary *)dictionaryWithPlistString:(NSString *)plist;

/**
 将 NSDictionary 序列化为二进制 plist 数据
 
 @return plist 数据, 如果发生错误则为 nil
 */
- (nullable NSData *)plistData;

/**
 将 NSArray 序列化为 plist 字符串(XML)
 
 @return plist 字符串(XML), 如果发生错误则为 nil
 */
- (nullable NSString *)plistString;

/**
 获取 keys 并排序 keys, 并返回新 NSArray
 
 @return 一个新 NSArray, 包含排序后的 keys, 如果字典没有条目, 则是一个空数组
 */
- (NSArray *)allKeysSorted;

/**
 排序 key, 按排序后的 key, 返回 value
 
 新 NSArray 的元素按 key 的排序来排序, 升序
 
 @return 一个新 NSArray, 包含按 keys 排序的 value, 如果字典没有条目, 则为空数组
 */
- (NSArray *)allValuesSortedByKeys;

/**
 判断 NSDictionary 中给定 key 是否有 value
 
 @param key 给定 key
 */
- (BOOL)containsObjectForKey:(id)key;

/**
 根据 keys 数组中的 key, 取 NSDictionary 中的 value, 组成新的 NSDictionary 并返回
 
 @param keys 要取得 keys
 @return 新的 NSDictionary
 */
- (NSDictionary *)entriesForKeys:(NSArray *)keys;

/**
 将 NSDictionary 转换为 json, 如果发生错误，返回 nil
 */
- (nullable NSString *)jsonString;

/**
 将 NSDictionary 转换为 json(漂亮的), 如果发生错误，返回 nil
 */
- (nullable NSString *)jsonPrettyString;

/**
 Convert dictionary to json string. return nil if an error occurs.
 */
- (nullable NSString *)jsonStringEncoded;

/**
 Convert dictionary to json string formatted. return nil if an error occurs.
 */
- (nullable NSString *)jsonPrettyStringEncoded;

#pragma mark - Dictionary Value Getter
///=============================================================================
/// @name Dictionary 的一些 Getter 扩展
///=============================================================================

- (BOOL)boolValueForKey:(NSString *)key default:(BOOL)def;

- (char)charValueForKey:(NSString *)key default:(char)def;
- (unsigned char)unsignedCharValueForKey:(NSString *)key default:(unsigned char)def;

- (short)shortValueForKey:(NSString *)key default:(short)def;
- (unsigned short)unsignedShortValueForKey:(NSString *)key default:(unsigned short)def;

- (int)intValueForKey:(NSString *)key default:(int)def;
- (unsigned int)unsignedIntValueForKey:(NSString *)key default:(unsigned int)def;

- (long)longValueForKey:(NSString *)key default:(long)def;
- (unsigned long)unsignedLongValueForKey:(NSString *)key default:(unsigned long)def;

- (long long)longLongValueForKey:(NSString *)key default:(long long)def;
- (unsigned long long)unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def;

- (float)floatValueForKey:(NSString *)key default:(float)def;
- (double)doubleValueForKey:(NSString *)key default:(double)def;

- (NSInteger)integerValueForKey:(NSString *)key default:(NSInteger)def;
- (NSUInteger)unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def;

- (nullable NSNumber *)numberValueForKey:(NSString *)key default:(NSNumber *_Nullable)def;
- (nullable NSString *)stringValueForKey:(NSString *)key default:(NSString *_Nullable)def;

@end



/**
 一些 NSMutableDictionary 常用方法
 */
@interface NSMutableDictionary (HXCommon)

/**
 由基于 NSDictionary 类型的 plist 数据, 创建并返回新的 NSMutableDictionary
 
 @param plist   基于 NSDictionary 类型的 plist 数据
 @return 由 plist 数据创建新的 NSMutableDictionary, 如果发生错误则为nil
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistData:(NSData *)plist;

/**
 由基于 NSDictionary 类型的 plist 字符串(XML), 创建并返回新的 NSMutableDictionary
 
 @param plist   基于 NSDictionary 类型的 plist 字符串(XML)
 @return 由 plist 字符串(XML) 创建新的 NSMutableDictionary, 如果发生错误则为 nil
 */
+ (nullable NSMutableDictionary *)dictionaryWithPlistString:(NSString *)plist;

/**
 取出一对 key-value, 源将被移除!
 
 @param aKey  key
 @return aKey 关联的 value, 如果没有 value 与 aKey 相关联, 则为nil
 */
- (nullable id)popObjectForKey:(id)aKey;

/**
 取出一堆 key-value, 源将被移除!
 
 @param keys keys
 @return 同上
 */
- (NSDictionary *)popEntriesForKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
