//
//  HXThreadSafeDictionary.m
//  HXCategoriesPro
//
//  Created by 吕浩轩 on 2021/10/9.
//

#import "HXThreadSafeDictionary.h"
#import "NSDictionary+HXCommon.h"
#import <pthread/pthread.h>

#define INIT(...) self = super.init; \
if (!self) return nil; \
__VA_ARGS__; \
if (!_dic) return nil; \
pthread_mutex_init(&_mutex, NULL); \
pthread_mutex_init(&_mutex2, NULL); \
return self;


#define LOCK(...) \
pthread_mutex_lock(&_mutex); \
__VA_ARGS__; \
pthread_mutex_unlock(&_mutex);


@implementation HXThreadSafeDictionary {
    NSMutableDictionary *_dic;
    pthread_mutex_t _mutex;
    pthread_mutex_t _mutex2;
}

#pragma mark - Class Level
+ (instancetype)array {
    return [[HXThreadSafeDictionary alloc] init];
}

+ (id)arrayWithCapacity:(NSUInteger)numItems {
    id retVal = [[HXThreadSafeDictionary alloc] initWithCapacity:numItems];
    return retVal;
}

#pragma private methods
- (instancetype)initCommon {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_mutex, NULL);
        pthread_mutex_init(&_mutex2, NULL);
        _dic = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)dealloc {
    pthread_mutex_destroy(&_mutex);
    pthread_mutex_destroy(&_mutex2);
}

#pragma mark - init

- (instancetype)init {
    INIT(_dic = [[NSMutableDictionary alloc] init]);
}

- (instancetype)initWithObjects:(NSArray *)objects forKeys:(NSArray *)keys {
    INIT(_dic =  [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys]);
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    INIT(_dic = [[NSMutableDictionary alloc] initWithCapacity:capacity]);
}

- (instancetype)initWithObjects:(const id[])objects forKeys:(const id <NSCopying>[])keys count:(NSUInteger)cnt {
    INIT(_dic = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys count:cnt]);
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary {
    INIT(_dic = [[NSMutableDictionary alloc] initWithDictionary:otherDictionary]);
}

- (instancetype)initWithDictionary:(NSDictionary *)otherDictionary copyItems:(BOOL)flag {
    INIT(_dic = [[NSMutableDictionary alloc] initWithDictionary:otherDictionary copyItems:flag]);
}


#pragma mark - method

- (NSUInteger)count {
    LOCK(NSUInteger c = _dic.count); return c;
}

- (id)objectForKey:(id)aKey {
    LOCK(id o = [_dic objectForKey:aKey]); return o;
}

- (NSEnumerator *)keyEnumerator {
    LOCK(NSEnumerator * e = [_dic keyEnumerator]); return e;
}

- (NSArray *)allKeys {
    LOCK(NSArray * a = [_dic allKeys]); return a;
}

- (NSArray *)allKeysForObject:(id)anObject {
    LOCK(NSArray * a = [_dic allKeysForObject:anObject]); return a;
}

- (NSArray *)allValues {
    LOCK(NSArray * a = [_dic allValues]); return a;
}

- (NSString *)description {
    LOCK(NSString * d = [_dic description]); return d;
}

- (NSString *)descriptionInStringsFileFormat {
    LOCK(NSString * d = [_dic descriptionInStringsFileFormat]); return d;
}

- (NSString *)descriptionWithLocale:(id)locale {
    LOCK(NSString * d = [_dic descriptionWithLocale:locale]); return d;
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    LOCK(NSString * d = [_dic descriptionWithLocale:locale indent:level]); return d;
}

- (BOOL)isEqualToDictionary:(NSDictionary *)otherDictionary {
    if (otherDictionary == self) return YES;
    
    if ([otherDictionary isKindOfClass:HXThreadSafeDictionary.class]) {
        HXThreadSafeDictionary *other = (id)otherDictionary;
        BOOL isEqual;
        pthread_mutex_lock(&_mutex);
        pthread_mutex_lock(&other->_mutex2);
        isEqual = [_dic isEqual:other->_dic];
        pthread_mutex_unlock(&other->_mutex2);
        pthread_mutex_unlock(&_mutex);
        return isEqual;
    }
    return NO;
}

- (NSEnumerator *)objectEnumerator {
    LOCK(NSEnumerator * e = [_dic objectEnumerator]); return e;
}

- (NSArray *)objectsForKeys:(NSArray *)keys notFoundMarker:(id)marker {
    LOCK(NSArray * a = [_dic objectsForKeys:keys notFoundMarker:marker]); return a;
}

- (NSArray *)keysSortedByValueUsingSelector:(SEL)comparator {
    LOCK(NSArray * a = [_dic keysSortedByValueUsingSelector:comparator]); return a;
}

- (void)getObjects:(id __unsafe_unretained [])objects andKeys:(id __unsafe_unretained [])keys count:(NSUInteger)count {
    LOCK([_dic getObjects:objects andKeys:keys count:count]);
}

- (id)objectForKeyedSubscript:(id)key {
    LOCK(id o = [_dic objectForKeyedSubscript:key]); return o;
}

- (void)enumerateKeysAndObjectsUsingBlock:(void (NS_NOESCAPE ^)(id key, id obj, BOOL *stop))block {
    LOCK([_dic enumerateKeysAndObjectsUsingBlock:block]);
}

- (void)enumerateKeysAndObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id key, id obj, BOOL *stop))block {
    LOCK([_dic enumerateKeysAndObjectsWithOptions:opts usingBlock:block]);
}

- (NSArray *)keysSortedByValueUsingComparator:(NSComparator NS_NOESCAPE)cmptr {
    LOCK(NSArray * a = [_dic keysSortedByValueUsingComparator:cmptr]); return a;
}

- (NSArray *)keysSortedByValueWithOptions:(NSSortOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmptr {
    LOCK(NSArray * a = [_dic keysSortedByValueWithOptions:opts usingComparator:cmptr]); return a;
}

- (NSSet *)keysOfEntriesPassingTest:(BOOL (NS_NOESCAPE ^)(id key, id obj, BOOL *stop))predicate {
    LOCK(NSSet * a = [_dic keysOfEntriesPassingTest:predicate]); return a;
}

- (NSSet *)keysOfEntriesWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id key, id obj, BOOL *stop))predicate {
    LOCK(NSSet * a = [_dic keysOfEntriesWithOptions:opts passingTest:predicate]); return a;
}

#pragma mark - mutable

- (void)removeObjectForKey:(id)aKey {
    LOCK([_dic removeObjectForKey:aKey]);
}

- (void)setObject:(id)anObject forKey:(id <NSCopying> )aKey {
    LOCK([_dic setObject:anObject forKey:aKey]);
}

- (void)addEntriesFromDictionary:(NSDictionary *)otherDictionary {
    LOCK([_dic addEntriesFromDictionary:otherDictionary]);
}

- (void)removeAllObjects {
    LOCK([_dic removeAllObjects]);
}

- (void)removeObjectsForKeys:(NSArray *)keyArray {
    LOCK([_dic removeObjectsForKeys:keyArray]);
}

- (void)setDictionary:(NSDictionary *)otherDictionary {
    LOCK([_dic setDictionary:otherDictionary]);
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying> )key {
    LOCK([_dic setObject:obj forKeyedSubscript:key]);
}

#pragma mark - protocol

- (id)copyWithZone:(NSZone *)zone {
    return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    LOCK(id copiedDictionary = [[self.class allocWithZone:zone] initWithDictionary:_dic]);
    return copiedDictionary;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained[])stackbuf
                                    count:(NSUInteger)len {
    LOCK(NSUInteger count = [_dic countByEnumeratingWithState:state objects:stackbuf count:len]);
    return count;
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    
    if ([object isKindOfClass:HXThreadSafeDictionary.class]) {
        HXThreadSafeDictionary *other = object;
        BOOL isEqual;
        pthread_mutex_lock(&_mutex);
        pthread_mutex_lock(&other->_mutex2);
        isEqual = [_dic isEqual:other->_dic];
        pthread_mutex_unlock(&other->_mutex2);
        pthread_mutex_unlock(&_mutex);
        return isEqual;
    }
    return NO;
}

- (NSUInteger)hash {
    LOCK(NSUInteger hash = [_dic hash]); return hash;
}

#pragma mark - custom methods for NSDictionary(HXCommon)

- (NSDictionary *)entriesForKeys:(NSArray *)keys {
    LOCK(NSDictionary * dic = [_dic hx_entriesForKeys:keys]) return dic;
}

- (NSString *)jsonStringEncoded {
    LOCK(NSString * s = [_dic hx_jsonStringEncoded]) return s;
}

- (NSString *)jsonPrettyStringEncoded {
    LOCK(NSString * s = [_dic hx_jsonPrettyStringEncoded]) return s;
}

- (id)popObjectForKey:(id)aKey {
    LOCK(id o = [_dic hx_popObjectForKey:aKey]) return o;
}

- (NSDictionary *)popEntriesForKeys:(NSArray *)keys {
    LOCK(NSDictionary * d = [_dic hx_popEntriesForKeys:keys]) return d;
}

@end
