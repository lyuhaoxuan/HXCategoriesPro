//
//  HXThreadSafeDictionary.h
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/10/9.
//

#import <Foundation/Foundation.h>
NS_SWIFT_NAME(ThreadSafeDictionary)

/**
 A simple implementation of thread safe mutable dictionary.
 
 @warning Fast enumerate(for...in) and enumerator is not thread safe,
 use enumerate using block instead. When enumerate or sort with block/callback,
 do *NOT* send message to the dictionary inside the block/callback.
 */
@interface HXThreadSafeDictionary<KeyType, ObjectType> : NSMutableDictionary<KeyType, ObjectType>

@end
