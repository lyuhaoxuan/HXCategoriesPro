//
//  HXThreadSafeArray.h
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/10/9.
//

#import <Foundation/Foundation.h>
NS_SWIFT_NAME(ThreadSafeArray)

/**
 A simple implementation of thread safe mutable array.
 
 @discussion Generally, access performance is lower than NSMutableArray,
 but higher than using @synchronized, NSLock.
 
 @discussion It's also compatible with the custom methods in `NSArray(HXCommon)`
 and `NSMutableArray(HXCommon)`
 
 @warning Fast enumerate(for..in) and enumerator is not thread safe,
 use enumerate using block instead. When enumerate or sort with block/callback,
 do *NOT* send message to the array inside the block/callback.
 */
@interface HXThreadSafeArray : NSMutableArray

@end
