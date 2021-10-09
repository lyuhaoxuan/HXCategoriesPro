//
//  HXSafeMutableArray.m
//  LHX
//
//  Created by 吕浩轩 on 2021/10/9.
//  Copyright © 2021年 LHX. All rights reserved.
//

#import "HXSafeMutableArray.h"
#import "NSArray+HXCommon.h"

#define INIT(...) self = [self initCommon]; \
if (!self) return nil; \
__VA_ARGS__; \
if (!_array) return nil; \
return self;

#define SYNC_LOCK(...) \
__block id o; \
__block NSUInteger i; \
__block BOOL b; \
dispatch_barrier_sync(self.queue, ^{ \
__VA_ARGS__; \
});

#define ASYNC_LOCK(...) \
dispatch_barrier_async(self.queue, ^{ \
__VA_ARGS__; \
});

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

@interface HXSafeMutableArray()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) dispatch_queue_t queue;
@end

@implementation HXSafeMutableArray

- (instancetype)init {
    INIT(self.array = [[NSMutableArray alloc] init]);
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    INIT(self.array = [[NSMutableArray alloc] initWithCapacity:numItems]);
}

- (instancetype)initWithArray:(NSArray *)array {
    INIT(self.array = [[NSMutableArray alloc] initWithArray:array]);
}

- (instancetype)initWithObjects:(const id[])objects count:(NSUInteger)cnt {
    INIT(self.array = [[NSMutableArray alloc] initWithObjects:objects count:cnt]);
}

- (instancetype)initWithContentsOfFile:(NSString *)path {
    INIT(self.array = [[NSMutableArray alloc] initWithContentsOfFile:path]);
}

- (instancetype)initWithContentsOfURL:(NSURL *)url {
    INIT(self.array = [[NSMutableArray alloc] initWithContentsOfURL:url]);
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    INIT(self.array = [[NSMutableArray alloc] initWithCoder:coder]);
}


#pragma mark - method
- (NSUInteger)count {
    SYNC_LOCK(i = self.array.count); return i;
}

- (id)objectAtIndex:(NSUInteger)index {
    SYNC_LOCK(o = [self.array objectAtIndex:index]); return o;
}

- (NSArray *)arrayByAddingObject:(id)anObject {
    SYNC_LOCK(o = [self.array arrayByAddingObject:anObject]); return o;
}

- (NSArray *)arrayByAddingObjectsFromArray:(NSArray *)otherArray {
    SYNC_LOCK(o = [self.array arrayByAddingObjectsFromArray:otherArray]); return o;
}

- (NSString *)componentsJoinedByString:(NSString *)separator {
    SYNC_LOCK(o = [self.array componentsJoinedByString:separator]); return o;
}

- (BOOL)containsObject:(id)anObject {
    SYNC_LOCK(b = [self.array containsObject:anObject]); return b;
}

- (NSString *)description {
    SYNC_LOCK(o = self.array.description); return o;
}

- (NSString *)descriptionWithLocale:(id)locale {
    SYNC_LOCK(o = [self.array descriptionWithLocale:locale]); return o;
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    SYNC_LOCK(o = [self.array descriptionWithLocale:locale indent:level]); return o;
}

- (id)firstObjectCommonWithArray:(NSArray *)otherArray {
    SYNC_LOCK(o = [self.array firstObjectCommonWithArray:otherArray]); return o;
}

- (void)getObjects:(id __unsafe_unretained[])objects range:(NSRange)range {
    SYNC_LOCK([self.array getObjects:objects range:range]);
}

- (NSUInteger)indexOfObject:(id)anObject {
    SYNC_LOCK(i = [self.array indexOfObject:anObject]); return i;
}

- (NSUInteger)indexOfObject:(id)anObject inRange:(NSRange)range {
    SYNC_LOCK(i = [self.array indexOfObject:anObject inRange:range]); return i;
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject {
    SYNC_LOCK(i = [self.array indexOfObjectIdenticalTo:anObject]); return i;
}

- (NSUInteger)indexOfObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    SYNC_LOCK(i = [self.array indexOfObjectIdenticalTo:anObject inRange:range]); return i;
}

- (id)firstObject {
    SYNC_LOCK(o = self.array.firstObject); return o;
}

- (id)lastObject {
    SYNC_LOCK(o = self.array.lastObject); return o;
}

- (NSEnumerator *)objectEnumerator {
    SYNC_LOCK(o = [self.array objectEnumerator]); return o;
}

- (NSEnumerator *)reverseObjectEnumerator {
    SYNC_LOCK(o = [self.array reverseObjectEnumerator]); return o;
}

- (NSData *)sortedArrayHint {
    SYNC_LOCK(o = [self.array sortedArrayHint]); return o;
}

- (NSArray *)sortedArrayUsingFunction:(NSInteger (NS_NOESCAPE *)(id, id, void *))comparator context:(void *)context {
    SYNC_LOCK(o = [self.array sortedArrayUsingFunction:comparator context:context]) return o;
}

- (NSArray *)sortedArrayUsingFunction:(NSInteger (NS_NOESCAPE *)(id, id, void *))comparator context:(void *)context hint:(NSData *)hint {
    SYNC_LOCK(o = [self.array sortedArrayUsingFunction:comparator context:context hint:hint]); return o;
}

- (NSArray *)sortedArrayUsingSelector:(SEL)comparator {
    SYNC_LOCK(o = [self.array sortedArrayUsingSelector:comparator]); return o;
}

- (NSArray *)subarrayWithRange:(NSRange)range {
    SYNC_LOCK(o = [self.array subarrayWithRange:range]) return o;
}

- (void)makeObjectsPerformSelector:(SEL)aSelector {
    SYNC_LOCK([self.array makeObjectsPerformSelector:aSelector]);
}

- (void)makeObjectsPerformSelector:(SEL)aSelector withObject:(id)argument {
    SYNC_LOCK([self.array makeObjectsPerformSelector:aSelector withObject:argument]);
}

- (NSArray *)objectsAtIndexes:(NSIndexSet *)indexes {
    SYNC_LOCK(o = [self.array objectsAtIndexes:indexes]); return o;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    SYNC_LOCK(o = [self.array objectAtIndexedSubscript:idx]); return o;
}

- (void)enumerateObjectsUsingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block {
    SYNC_LOCK([self.array enumerateObjectsUsingBlock:block]);
}

- (void)enumerateObjectsWithOptions:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block {
    SYNC_LOCK([self.array enumerateObjectsWithOptions:opts usingBlock:block]);
}

- (void)enumerateObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts usingBlock:(void (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))block {
    SYNC_LOCK([self.array enumerateObjectsAtIndexes:s options:opts usingBlock:block]);
}

- (NSUInteger)indexOfObjectPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(i = [self.array indexOfObjectPassingTest:predicate]); return i;
}

- (NSUInteger)indexOfObjectWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(i = [self.array indexOfObjectWithOptions:opts passingTest:predicate]); return i;
}

- (NSUInteger)indexOfObjectAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(i = [self.array indexOfObjectAtIndexes:s options:opts passingTest:predicate]); return i;
}

- (NSIndexSet *)indexesOfObjectsPassingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(o = [self.array indexesOfObjectsPassingTest:predicate]); return o;
}

- (NSIndexSet *)indexesOfObjectsWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(o = [self.array indexesOfObjectsWithOptions:opts passingTest:predicate]); return o;
}

- (NSIndexSet *)indexesOfObjectsAtIndexes:(NSIndexSet *)s options:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id obj, NSUInteger idx, BOOL *stop))predicate {
    SYNC_LOCK(o = [self.array indexesOfObjectsAtIndexes:s options:opts passingTest:predicate]); return o;
}

- (NSArray *)sortedArrayUsingComparator:(NSComparator NS_NOESCAPE)cmptr {
    SYNC_LOCK(o = [self.array sortedArrayUsingComparator:cmptr]); return o;
}

- (NSArray *)sortedArrayWithOptions:(NSSortOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmptr {
    SYNC_LOCK(o = [self.array sortedArrayWithOptions:opts usingComparator:cmptr]); return o;
}

- (NSUInteger)indexOfObject:(id)obj inSortedRange:(NSRange)r options:(NSBinarySearchingOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmp {
    SYNC_LOCK(i = [self.array indexOfObject:obj inSortedRange:r options:opts usingComparator:cmp]); return i;
}

#pragma mark - mutable

- (void)addObject:(id)anObject {
    ASYNC_LOCK([self.array addObject:anObject]);
}

- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    ASYNC_LOCK([self.array insertObject:anObject atIndex:index]);
}

- (void)removeLastObject {
    ASYNC_LOCK([self.array removeLastObject]);
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    ASYNC_LOCK([self.array removeObjectAtIndex:index]);
}

- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    ASYNC_LOCK([self.array replaceObjectAtIndex:index withObject:anObject]);
}

- (void)addObjectsFromArray:(NSArray *)otherArray {
    ASYNC_LOCK([self.array addObjectsFromArray:otherArray]);
}

- (void)exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    ASYNC_LOCK([self.array exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2]);
}

- (void)removeAllObjects {
    ASYNC_LOCK([self.array removeAllObjects]);
}

- (void)removeObject:(id)anObject inRange:(NSRange)range {
    ASYNC_LOCK([self.array removeObject:anObject inRange:range]);
}

- (void)removeObject:(id)anObject {
    ASYNC_LOCK([self.array removeObject:anObject]);
}

- (void)removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    ASYNC_LOCK([self.array removeObjectIdenticalTo:anObject inRange:range]);
}

- (void)removeObjectIdenticalTo:(id)anObject {
    ASYNC_LOCK([self.array removeObjectIdenticalTo:anObject]);
}

- (void)removeObjectsInArray:(NSArray *)otherArray {
    ASYNC_LOCK([self.array removeObjectsInArray:otherArray]);
}

- (void)removeObjectsInRange:(NSRange)range {
    ASYNC_LOCK([self.array removeObjectsInRange:range]);
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray range:(NSRange)otherRange {
    ASYNC_LOCK([self.array replaceObjectsInRange:range withObjectsFromArray:otherArray range:otherRange]);
}

- (void)replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    ASYNC_LOCK([self.array replaceObjectsInRange:range withObjectsFromArray:otherArray]);
}

- (void)setArray:(NSArray *)otherArray {
    ASYNC_LOCK([self.array setArray:otherArray]);
}

- (void)sortUsingFunction:(NSInteger (NS_NOESCAPE *)(id, id, void *))compare context:(void *)context {
    ASYNC_LOCK([self.array sortUsingFunction:compare context:context]);
}

- (void)sortUsingSelector:(SEL)comparator {
    ASYNC_LOCK([self.array sortUsingSelector:comparator]);
}

- (void)insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    ASYNC_LOCK([self.array insertObjects:objects atIndexes:indexes]);
}

- (void)removeObjectsAtIndexes:(NSIndexSet *)indexes {
    ASYNC_LOCK([self.array removeObjectsAtIndexes:indexes]);
}

- (void)replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    ASYNC_LOCK([self.array replaceObjectsAtIndexes:indexes withObjects:objects]);
}

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    ASYNC_LOCK([self.array setObject:obj atIndexedSubscript:idx]);
}

- (void)sortUsingComparator:(NSComparator NS_NOESCAPE)cmptr {
    ASYNC_LOCK([self.array sortUsingComparator:cmptr]);
}

- (void)sortWithOptions:(NSSortOptions)opts usingComparator:(NSComparator NS_NOESCAPE)cmptr {
    ASYNC_LOCK([self.array sortWithOptions:opts usingComparator:cmptr]);
}

- (BOOL)isEqualToArray:(NSArray *)otherArray {
    if (otherArray == self) return YES;
    if ([otherArray isKindOfClass:HXSafeMutableArray.class]) {
        HXSafeMutableArray *other = (id)otherArray;
        SYNC_LOCK(b = [self.array isEqualToArray:otherArray]);
        return b;
    }
    return NO;
}

#pragma mark - protocol

- (id)copyWithZone:(NSZone *)zone {
    return [self mutableCopyWithZone:zone];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    SYNC_LOCK(o = [[self.class allocWithZone:zone] initWithArray:self.array]);
    return o;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained[])stackbuf
                                    count:(NSUInteger)len {
    SYNC_LOCK(i = [self.array countByEnumeratingWithState:state objects:stackbuf count:len]); return i;
}

- (BOOL)isEqual:(id)object {
    if (object == self) return YES;
    
    if ([object isKindOfClass:HXSafeMutableArray.class]) {
        HXSafeMutableArray *other = object;
        SYNC_LOCK(b = [self.array isEqual:other]);
        return b;
    }
    return NO;
}

- (NSUInteger)hash {
    SYNC_LOCK(i = [self.array hash]); return i;
}


#pragma mark - Class Level
+ (instancetype)array {
    return [[HXSafeMutableArray alloc] init];
}

+ (id)arrayWithCapacity:(NSUInteger)numItems {
    id retVal = [[HXSafeMutableArray alloc] initWithCapacity:numItems];
    return retVal;
}

#pragma mark - custom methods for NSArray(YYAdd)

- (id)randomObject {
    SYNC_LOCK(o = [self.array hx_randomObject]) return o;
}

- (void)removeFirstObject {
    SYNC_LOCK([self.array hx_removeFirstObject]);
}

- (id)popFirstObject {
    SYNC_LOCK(o = [self.array hx_popFirstObject]) return o;
}

- (id)popLastObject {
    SYNC_LOCK(o = [self.array hx_popLastObject]) return o;
}

- (void)appendObjects:(NSArray *)objects {
    SYNC_LOCK([self.array hx_appendObjects:objects]);
}

- (void)prependObjects:(NSArray *)objects {
    SYNC_LOCK([self.array hx_prependObjects:objects]);
}

- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    SYNC_LOCK([self.array hx_insertObjects:objects atIndex:index]);
}

- (void)reverse {
    SYNC_LOCK([self.array hx_reverse]);
}

- (void)shuffle {
    SYNC_LOCK([self.array hx_shuffle]);
}

#pragma private methods
- (instancetype)initCommon {
    self = [super init];
    if (self) {
        NSString* identifier = [NSString stringWithFormat:@"<SafeMutableArray>%p", self];
        _queue = dispatch_queue_create([identifier UTF8String], DISPATCH_QUEUE_CONCURRENT);
        _array = [NSMutableArray array];
    }
    return self;
}

#pragma clang diagnostic pop

@end
