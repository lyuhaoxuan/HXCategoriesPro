//
//  NSObject+PrettyPrintedLog.m
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/11/26.
//

#import <objc/runtime.h>

#define PPL_LOAD \
+ (void)load { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        Class class = [self class]; \
        ppl_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(ppl_descriptionWithLocale:)); \
        ppl_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(ppl_descriptionWithLocale:indent:)); \
        ppl_swizzleSelector(class, @selector(debugDescription), @selector(ppl_debugDescription)); \
    }); \
}

#define PPL_DESCRIPTION \
- (NSString *)ppl_descriptionWithLocale:(id)locale { \
    NSString *result = [self ppl_convertToJsonString]; \
    if (!result) return [self ppl_descriptionWithLocale:locale]; \
    return result; \
} \
- (NSString *)ppl_descriptionWithLocale:(id)locale indent:(NSUInteger)level { \
    NSString *result = [self ppl_convertToJsonString]; \
    if (!result) return [self ppl_descriptionWithLocale:locale indent:level]; \
    return result; \
} \
- (NSString *)ppl_debugDescription{ \
    NSString *result = [self ppl_convertToJsonString]; \
    if (!result) return [self ppl_debugDescription]; \
    return result; \
}

static inline void ppl_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSObject (PrettyPrintedLog)

/// 核心代码，字典转化为有格式输出的JSON字符串
- (NSString *)ppl_convertToJsonString {
    
    if (![NSJSONSerialization isValidJSONObject:self])  return nil;
    
    NSJSONWritingOptions jsonOptions = NSJSONWritingPrettyPrinted;
    
    if (@available(macOS 10.13, iOS 11.0, watchos 4.0, tvos 11.0, *)) {
        jsonOptions |= NSJSONWritingSortedKeys;
    }
#if (__clang_major__ > 10)
    if (@available(macOS 10.14, iOS 12.0, watchos 5.0, tvos 12.0, *)) {
        jsonOptions |= NSJSONWritingFragmentsAllowed;
    }
    
    if (@available(macOS 10.15, iOS 13.0, watchos 6.0, tvos 13.0, *)) {
        jsonOptions |= NSJSONWritingWithoutEscapingSlashes;
    }
#endif
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:jsonOptions  error:&error];
    if (error || !jsonData) return nil;
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end

@implementation NSDictionary (PrettyPrintedLog)
PPL_LOAD;
PPL_DESCRIPTION;
@end

@implementation NSArray (PrettyPrintedLog)
PPL_LOAD;
PPL_DESCRIPTION;
@end

@implementation NSSet (PrettyPrintedLog)
PPL_LOAD;
PPL_DESCRIPTION;
@end
