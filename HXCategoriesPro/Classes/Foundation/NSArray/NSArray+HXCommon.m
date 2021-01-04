//
//  NSArray+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "NSArray+HXCommon.h"
#import "NSData+HXEncode.h"
#import <objc/runtime.h>

@implementation NSArray (HXCommon)

/// 对系统方法进行替换
/// @param class 类
/// @param originalSelector 被替换的方法
/// @param swizzledSelector 实际使用的方法
static inline void hx_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    
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

/// NSArray 是一个类簇
+ (void)load {
    [super load];
    
    // 越界：初始化的空数组
    hx_swizzleSelector(objc_getClass("__NSArray0"), @selector(objectAtIndex:), @selector(emptyObjectIndex:));

    // 越界：初始化的非空不可变数组
    hx_swizzleSelector(objc_getClass("__NSArrayI"), @selector(objectAtIndex:), @selector(safe_arrObjectIndex:));

    // 越界：未初始化的可变数组和未初始化不可变数组
    hx_swizzleSelector(objc_getClass("__NSPlaceholderArray"), @selector(objectAtIndex:), @selector(uninitIIndex:));

    // 越界：初始化的可变数组
    hx_swizzleSelector(objc_getClass("__NSArrayM"), @selector(objectAtIndex:), @selector(safeObjectIndex:));

    // 越界：可变数组
    hx_swizzleSelector(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(mutableArray_safe_objectAtIndexedSubscript:));

    // 越界vs插入：可变数插入nil，或者插入的位置越界
    hx_swizzleSelector(objc_getClass("__NSArrayM"), @selector(insertObject:atIndex:), @selector(safeInsertObject:atIndex:));

    // 插入：可变数插入nil
    hx_swizzleSelector(objc_getClass("__NSArrayM"), @selector(addObject:), @selector(safeAddObject:));
}

- (id)safe_arrObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self safe_arrObjectIndex:index];
}

- (id)mutableArray_safe_objectAtIndexedSubscript:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self mutableArray_safe_objectAtIndexedSubscript:index];
}

- (id)uninitIIndex:(NSUInteger)idx{
    if ([self isKindOfClass:objc_getClass("__NSPlaceholderArray")]) {
        return nil;
    }
    return [self uninitIIndex:idx];
}

- (id)safeObjectIndex:(NSInteger)index{
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self safeObjectIndex:index];
}

- (void)safeInsertObject:(id)object atIndex:(NSUInteger)index{
    if (index>self.count) {
        return ;
    }
    if (object == nil) {
        return ;
    }
    [self safeInsertObject:object atIndex:index];
}

- (void)safeAddObject:(id)object {
    if (object == nil) {
        return ;
    }
    [self safeAddObject:object];
}

- (id)emptyObjectIndex:(NSInteger)index {
    return nil;
}

+ (BOOL)hx_isEmpty:(NSArray *)array {
    if (!array || ![array isKindOfClass:[NSArray class]] || array.count == 0) {
        return YES;
    }
    return NO;
}

+ (NSArray *)hx_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([array isKindOfClass:[NSArray class]]) return array;
    return nil;
}

+ (NSArray *)hx_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self hx_arrayWithPlistData:data];
}

- (NSData *)hx_plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)hx_plistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) return xmlData.hx_UTF8String;
    return nil;
}

- (id)hx_randomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)hx_objectAtIndex:(NSUInteger)index {
    if (index >= self.count || index < 0) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (NSString *)hx_jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

- (NSString *)hx_jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
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
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:jsonOptions error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    }
    return nil;
}

@end

@implementation NSMutableArray (HXCommon)

+ (NSMutableArray *)hx_arrayWithPlistData:(NSData *)plist {
    if (!plist) return nil;
    NSMutableArray *array = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([array isKindOfClass:[NSMutableArray class]]) return array;
    return nil;
}

+ (NSMutableArray *)hx_arrayWithPlistString:(NSString *)plist {
    if (!plist) return nil;
    NSData* data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self hx_arrayWithPlistData:data];
}

- (void)hx_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)hx_removeLastObject {
    [self removeLastObject];
}

- (instancetype)hx_popFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self hx_removeFirstObject];
    }
    return obj;
}

- (instancetype)hx_popLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)hx_appendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)hx_prependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)hx_appendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)hx_prependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)hx_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)hx_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)hx_shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}

#pragma mark - 冒泡排序

/**
 冒泡排序
 
 @param array 需要进行排序的数据源
 @param isMax YES表示从大到小排序 NO表示从小到大排序
 @return 排序好的数组
 */
- (NSMutableArray *)bubbleSortWithDataSource:(NSMutableArray *)array isMaxToMin:(BOOL)isMax
{
    /* 标记最外层循环的循环次数 */
    NSUInteger count = 0;
    /* 标记交换次数 */
    NSUInteger exchangeCount = 0;
    
    NSMutableArray *changeArray = [array mutableCopy];
    /* 最外层的循环次数取决于数组的长度 */
    /* 冒泡排序中，最外层的每一次循环都能在未排列好的数（没有找到自己在数组中准确位置的数）中找到最大的那个数 */
    /* 所以数组的长度就是最外层的循环次数 */
    for (int i =0; i < changeArray.count; i++) {
        /* 最外层循环次数累加 */
        count ++;
        /* 标记是否已无需排序，当某一次最外层（最外层是指 i 这一层）循环没有产生任何一次交换时，则说明该数组已经排序成功 */
        BOOL isFinish = YES;
        /* 数组的首数下坐标是从0开始 */
        /* 最外层的每一次循环中，最内层都需要把数组中所有数据进行两两比较 */
        for (int j = 0; j < changeArray.count -1;j++) {
            /* 判断是从大到小排序还是从小到大排序 */
            if (isMax) {
                /* 冒泡排序的核心是相邻的两个数据进行比较，所以比较的数一定是相邻的 */
                if ([changeArray[j] intValue] < [changeArray[j+1] intValue]) {
                    /* 进行交换 */
                    [changeArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    /* 如果有产生交换，说明还未排序成功 */
                    isFinish = NO;
                    /* 交换次数累加 */
                    exchangeCount ++;
                }
            }else
            {
                /* 冒泡排序的核心是相邻的两个数据进行比较，所以比较的数一定是相邻的 */
                if ([changeArray[j] intValue] > [changeArray[j+1] intValue]) {
                    /* 进行交换 */
                    [changeArray exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                    /* 如果有产生交换，说明还未排序成功 */
                    isFinish = NO;
                    /* 交换次数累加 */
                    exchangeCount ++;
                }
            }
        }
        if (isFinish) {
            //结束最外层的循环
            break;
        }
    }
    //    NSLog(@"最外层循环次数:%lu",count);
    //    NSLog(@"交换次数:%lu",exchangeCount);
    return changeArray;
}

#pragma mark - 选择排序

/**
 选择排序
 
 @param array 选择排序
 @param isMax YES表示从大到小排序 NO表示从小到大
 @return 选择排序后的结果
 */
+ (NSMutableArray *)selectionSortWithDataSource:(NSMutableArray *)array isMaxToMin:(BOOL)isMax
{
    /* 标记最外层循环的循环次数 */
    NSUInteger count = 0;
    /* 标记下坐标交换次数 */
    NSUInteger exchangeCount = 0;
    
    /* 选择排序的最外层循环次数是固定的，取决于数组的长度 */
    /* 选择排序是一个比较特殊的排序，它的时间复杂度是固定的O(n²) */
    for (int i = 0; i < array.count; i++) {
        //累加最外层执行次数
        count ++;
        //创建一个新数组用于存放每次需要比较的数据
        NSMutableArray *newArray = [NSMutableArray new];
        //最外层每次都能正确排序出一个数的位置，所以已经排序好的位置不需要在加入比较
        //j = i +1的原因是，排除拿出来比较的第一个数，减少计算次数
        for (int j = i+1; j < array.count ; j++) {
            [newArray addObject:array[j]];
        }
        //取出需要比较的数
        int a = [array[i] intValue];
        //minIndex用于记录每轮比较的数据中最大数据的下坐标
        int minIndex = i;
        //进行比较
        for (int m = 0; m < newArray.count; m++) {
            //从新的数据源中取出比较的数
            int b = [newArray[m] intValue];
            //判断是从大到小排序还是从小到大
            if (isMax) {
                if (b > a) {
                    a = b;
                    //minIndex = i+m+1之所以 加1 是因为newArray中已经排除了第一个比较的数，所以下坐标相比于最外层array少了1
                    minIndex = i+m+1;
                    //累加交换次数
                    exchangeCount++;
                }
            }else
            {
                if (b < a) {
                    a = b;
                    minIndex = i+m+1;
                    //累加交换次数
                    exchangeCount++;
                }
            }
        }
        [array exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    //    NSLog(@"选择排序-最外层循环次数:%lu",count);
    //    NSLog(@"选择排序-交换次数:%lu",exchangeCount);
    
    return array;
}

/// MARK:选择排序(堆排序)

/**
 将数组按照完全二叉树方式进行重新构造成一个新堆（构造成一个标准的）
 
 @param array 源数组
 @param parent 当前需要判断的父节点(根据需要判断的父节点，去判断其左右树是否满足堆结构，不满足就进行交换)
 @param length 数组的长度
 */
+ (void)HeapAdjust:(NSMutableArray *)array parent:(int)parent length:(int)length
{
    //根据父节点parent的位置去计算其左子树在数组中的下坐标
    //因为在二叉树中，必须有左子树才会有右子树。
    //如果没有左子树说明这个父节点是最下层的子树，这种情况就可以不用再做判断了
    /*
     为什么 2*parent+1 就是左子树的下坐标呢。 因为二叉树是按照第一排显示1个，第二排显示2个，
     第三排显示3个以此类推的方式显示的。
     例如{@(3), @(8), @(15), @(31), @(25)}是一个典型的小根堆。
     堆中有两个父结点，元素3和元素8(因为15没有子树所以不是父节点)。
     元素3在数组中以array[0]表示，它的左孩子结点是array[1]，右孩子结点是array[2]。
     元素8在数组中以array[1]表示，它的左孩子结点是array[3]，右孩子结点是array[4]，
     它的父结点是array[0]。可以看出，它们满足以下规律：
     设当前元素在数组中以array[i]表示，那么，
     (1) 它的左孩子结点是：array[2*i+1];
     (2) 它的右孩子结点是：array[2*i+2];
     (3) 它的父结点是：array[(i-1)/2];
     (4) array[i] <= array[2*i+1] 且 array[i] <= array[2i+2]。
     */
    int l_child = 2*parent + 1;//左子树下坐标
    int r_child = l_child + 1;//右子树下坐标
    
    /*
     判断当前计算出来的右子树下标有没有超过数组的长度，如果没有超过说明该父节点拥有左右子树。
     如果超过且该节点拥有左子树节点则说明该节点是最下层的最后一个父节点，
     如果超过且没有左子树，则说明该节点不是父节点且是数组最后一个元素。
     
     这里之所以用while进行判断而不是if，因为判断当前节点后，还要继续向当前节点的子树节点之下进行筛选判断。所以用while
     */
    while (r_child < length) {
        //如果右子树的值大于左子树的值，则选取右子树的值来与父节点进行判断
        if ([[array hx_objectAtIndex:l_child] intValue] < [[array hx_objectAtIndex:r_child] intValue]) {
            //当右子树的值大于父节点时，需要把右子树的值与父节点进行交换
            if ([[array hx_objectAtIndex:parent] intValue] < [[array hx_objectAtIndex:r_child] intValue]) {
                //把右子树的值与父节点进行交换
                [array exchangeObjectAtIndex:parent withObjectAtIndex:r_child];
            }
            //重新选取当前已经判断过的父节点的右子树当做父节点,继续向下递归筛选判断
            parent = r_child;
        }else
        {
            //当左子树值大于右子树值时，用左子树与父节点进行判断
            if ([[array hx_objectAtIndex:parent] intValue] < [[array hx_objectAtIndex:l_child] intValue]) {
                //当左子树值大于父节点是，把左子树的值与父节点进行交换
                [array exchangeObjectAtIndex:parent withObjectAtIndex:l_child];
            }
            //重新选取当前已经判断过的父节点的左子树当做父节点,继续向下递归筛选判断
            parent = l_child;
        }
        //重新选取左右子树下坐标
        l_child = 2 * parent + 1;
        r_child = l_child + 1;
    }
    
    //判断左子树是否存在，并判断左子树是否超过父节点
    //这里不进行递归是因为如果只有左子树，则表明该左子树为数组最后一个数。不需要进行递归了
    if (l_child < length && [[array hx_objectAtIndex:l_child] intValue] > [[array hx_objectAtIndex:parent] intValue]) {
        [array exchangeObjectAtIndex:l_child withObjectAtIndex:parent];
    }
}


/**
 对数组进行堆排序方法
 
 @param array 需要进行排序的数组
 @param isFromMaxToMin 数组排序的方式，为YES是表示数组从大到小排序，为NO则从小到大排序
 */
+ (void)heapSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    if (!array) {
        return;
    }
    if (array.count < 2) {
        return;
    }
    //firstIndex表示从哪一个下坐标开始去进行节点排序
    //为什么是array.count/2，因为数组的一半，能保证前一半的数据中所有值都是父节点，都拥有子节点。而后根据父节点去递归子节点
    int firstIndex = (int)(array.count/2);
    int arrayCount = (int)array.count;
    //1.首先将原数组排序为一个初始堆
    for (int i = firstIndex; i >= 0; i--) {
        [self HeapAdjust:array parent:i length:arrayCount];
    }
    //    NSLog(@"初始堆%@",array);
    while (arrayCount > 0) {
        //将根节点最大的值与数组最末尾的值进行交换
        [array exchangeObjectAtIndex:arrayCount -1 withObjectAtIndex:0];
        arrayCount--;
        [self HeapAdjust:array parent:0 length:arrayCount];
    }
    //    NSLog(@"堆排序结果%@",array);
    if (isFromMaxToMin) {//如果是需要从大到小排序，将数组逆序
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
}

#pragma mark - 快速排序

/**
 快速排序的调用方法
 
 @param array 原始数组
 @param isFromMaxToMin YES表示从大到小排序 NO表示从小到大排序
 */
+ (void)quickSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    [self quickSort:array LeftIndex:0 rightIndex:array.count-1];
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    //    NSLog(@"快速排序结果:%@",array);
}

/**
 快速排序的核心方法
 
 基本思想：在数组随机选择一个元素，当做基准数。用基准数与数组其他元素进行比较。将数组中比基准数大的放在右边，比基准数小的放在左边。然后把数组根据基准数分成2个数组。称之为基准数左边数组和基准数右边数组。对左右数组递归重复上面的操作。直到判断的数组只有一个元素了，就表示排序已经完成
 
 @param array 需要排序的数组
 @param leftIndex 需要排序的数组最开始的数在原数组中的下坐标
 @param rightIndex 需要排序的数组最末尾的数在原数组中的下坐标
 */
+ (void)quickSort:(NSMutableArray *)array LeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex
{
    if (rightIndex <= leftIndex) {//如果排序长度是1则忽略
        return;
    }
    
    //i表示排序开始时的基准数在数组中的下坐标
    NSInteger i = leftIndex;
    //j表示排序是从i到j结束。整个排序的长度为j-i。是排序最右边元素的下坐标
    NSInteger j = rightIndex;
    //key是记录比较基准数的值
    NSInteger key = [[array hx_objectAtIndex:i] integerValue];
    
    /*
     i < j 说明当前基准数的递归排序还未完成
     while内部是根据基准数先从右向左比较(这里的从右开始位置是根据j开始的)，如果发现了比基准数小的数，则进行位置交换。
     然后又根据基准数与i+1下坐标开始，从左向右比较，如果发现了比基准数大的数，则与当前交换后的基准数位置进行交换。
     接着根据基准数与j-1下坐标开始，从右向左比较，如果发现了比基准数小的数，则进行位置交换
     这样一直递归。直到i >= j发生完成本次的递归。
     */
    while (i < j) {
        while (i < j && key <= [[array hx_objectAtIndex:j] integerValue]) {
            ////当j == i 则说明i已经是i到j这段数组中最小的数。不需要交换。所以i < j
            //如果当前j下坐标表示的值大于等于基准数，那么就将j比较的下坐标减1.让基准数从右往左依次比较，直到遇见比基准数小的数
            j--;
        }
        if (j != i) {//当j == i 则说明i已经是i到j这段数组中最小的数。不需要交换
            [array exchangeObjectAtIndex:j withObjectAtIndex:i];
        }
        
        while (i < j && key >= [[array hx_objectAtIndex:i] integerValue]) {
            //如果i+1下坐标表示的值小于基准数，那么就将比较的下坐标加1，让基准数从左往右依次比较，直到遇见比基准数大的值
            i++;
        }
        if (j != i) {//当j == i 则说明j已经是i+1到j这段数组中最大的数了。不需要交换
            [array exchangeObjectAtIndex:j withObjectAtIndex:i];
        }
    }//完成一次基准数的判断排序
    
    //根据当下基准数的下坐标把数组分为左右两部分进行左右两部分的分别递归排序
    
    //基准数右边部分
    [self quickSort:array LeftIndex:i+1 rightIndex:rightIndex];
    //基准数左边部分
    [self quickSort:array LeftIndex:leftIndex rightIndex:i-1];
    
}

#pragma mark - (插入排序)直接插入排序

/**
 直接插入排序
 
 基本思想：每轮排序把数组分为2部分，一部分为已排序好的数组，一部分为还未排序好的数组。每次取出还未排序好的数组中首元素与已排序好的数组从右往左比较。如果发现从未排序中取出的元素比从已排序中取出的元素大，就把该未排序的元素插入到从已排序中取出元素的后面。这样每一轮就能确定一个未排序元素在已排序数组中的准确位置
 
 @param array 原数组
 @param isFromMaxToMin YES表示从大到小排序 NO表示从小到大
 */
+ (void)insertSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    //i从1开始，因为第一次插入排序操作时，假设的是数组第一个元素所组成的是一个有序数组。所以需要用后面无序数组的元素与第一个元素进行插入比较
    for (int i = 1; i <= array.count-1; i++) {
        //Temp_i是当前未排序数组的首个元素，需要用该元素与已排序数组中的所有元素比较
        NSInteger Temp_i = [[array hx_objectAtIndex:i] integerValue];
        //j是已排序数组的最末尾(即最右边，从右往左比较)的元素下坐标
        NSInteger j = i - 1;
        //j必须大于0 否则数组越界，当j=0的时候说明Temp_i已经与已排序数组所有元素进行比较
        while (j >= 0) {
            //从已排序数组中取出的元素
            NSInteger Temp_j = [[array hx_objectAtIndex:j] integerValue];
            
            //当已排序数组中元素比未排序数组元素小时，说明需要把未排序元素插入到该已排序元素的后面。
            if (Temp_i > Temp_j) {
                //当j == (1-1)时，说明已排序最末尾元素与未排序最前面元素排序时正常的。
                //这种情况下不需要交换位置，直接退出while循环
                if ( j == (i - 1)) {
                    j = -1;
                }else
                {
                    //进行插入操作。先把元素从数组中移除，再把元素插入到已排序元素的后面位置
                    [array removeObjectAtIndex:i];
                    [array insertObject:[NSString stringWithFormat:@"%zd",Temp_i] atIndex:j+1];
                }
            }else
            {//当已排序数组中元素比未排序数组元素大时则忽略本次，让该未排序元素与下一个已排序元素进行比较。直到j=0或发现比未排序元素小的元素
                
                //等j==0时，说明该未排序元素与已排序数组所有元素都进行比较了，且改未排序元素小于所有已排序元素
                //那么就应该把该元素插入到已排序数组的最前面。
                if (j == 0) {
                    //进行插入操作。先把元素从数组中移除，再把元素插入到已排序元素的后面位置
                    [array removeObjectAtIndex:i];
                    [array insertObject:[NSString stringWithFormat:@"%zd",Temp_i] atIndex:0];
                }
                j--;
            }
        }
    }
    
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    //    NSLog(@"直接插入排序结果:%@",array);
}

#pragma mark - (插入排序)希尔排序

/**
 希尔排序
 
 基本思想:希尔排序相当于直接插入排序的加强版，在直接插入排序的概念之上加入了增量这个概念。
 什么是增量？插入排序只能与相邻的元素进行比较，而希尔排序则是进行跳跃比较，而增量就是跳跃的间隔数。
 所谓增量即是把数组按照一定间隔数分组成不同的数组。例如:@{1,2,3,4,5,6},一共有6个元素，假设把数组按照增量3进行分组，
 那么就是@{1,4},@{2,5},@{3,6}各分为一组。因为增量是3，所以每间隔3个下坐标为一组。
 直到取到数组末尾，如果数组还有第7个元素7，那么按照增量分组的第一组数据是@{1,4,7}。
 按照增量分组后，把每一组的元素按照插入排序进行排序。
 当按照一个增量分组完成并每组数据按照插入排序完成后，将增量设为原本的二分之一，然后重复上面的步骤进行插入排序。
 直到增量为1，按照增量为1的最后一次进行分组插入排序。即完成了排序。
 
 @param array 原数组
 @param isFromMaxToMin YES表示从大到小排序 NO表示从小到大
 */
+ (void)shellSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    // l 是增量大小 标记当前数组是按照l长度间隔分段数据的
    //例如：@{@"1",@"23",@"12",@"45",@"5",@"18",@"9"} 当l = 2
    //@"1",@"45",@"9"为一组。@"23","5",为一组。@"12",@"18"为一组。每间隔l个数取出元素组成一个新数组
    NSInteger l = array.count/2;
    //标记按照l增量大小分段数组，indexCount表示数组被分为几组
    NSInteger indexCount = array.count%2 > 0 ? array.count/2+1 : array.count/2;
    while (l >= 1) {
        //根据indexCount，对每组里包含的元素进行比较
        for (int i = 0; i < indexCount; i++) {
            //进行直接插入排序，默认比较数组第一个元素为已排序，所以从i+l开始，i表示当前数组第一个元素，i+l表示当前数组第二个元素
            for (NSInteger j = i+l; j < array.count; j += l) {
                //标记当前比较元素的下坐标
                NSInteger index_j = j;
                //用当前j元素与前面已排序的所有元素进行比较，不能越界所以数组的下坐标比大于0
                if (j-l >= 0) {
                    //temp_i是记录当前未排序元素的前一个元素(即已排序元素中最末尾一个元素)
                    NSInteger temp_i = [[array hx_objectAtIndex:j-l] integerValue];
                    //temp_j是记录当前需要比较的未排序元素
                    NSInteger temp_j = [[array hx_objectAtIndex:j] integerValue];
                    //当已排序数组最末尾元素大于未排序元素时，需要用未排序元素与已排序元素的下一个元素进行比较
                    //如果已排序数组最末尾元素小于未排序元素时，则直接进行下一个未排序元素的比较
                    if (temp_i > temp_j) {
                        //交换位置
                        [array exchangeObjectAtIndex:j withObjectAtIndex:j-l];
                        //重新记录当前需要比较的未排序元素的下坐标
                        index_j = j-l;
                        //x 是记录的是已排序元素的下一个元素下坐标
                        NSInteger x = j-l-l;
                        //数组下坐标不能越界，所以x>0
                        while (x >= 0) {
                            //temp_x记录的下一个需要比较的已排序元素
                            NSInteger temp_x = [[array hx_objectAtIndex:x] integerValue];
                            //只要发生已排序元素大于未排序元素就进行交换
                            if (temp_x > temp_j) {
                                [array exchangeObjectAtIndex:x withObjectAtIndex:index_j];
                                //重新记录未排序元素在数组的下坐标
                                index_j = x;
                                //让x进行下一个元素的比较
                                x -= l;
                            }else
                            {
                                //如果发现已排序元素小于未排序元素，则说明未排序元素已经找到在已排序数组中的位置。
                                //则使x=-1.跳出while循环
                                x = -1;
                            }
                        }
                    }
                }
            }
        }
        //重新计算下一次的组数
        indexCount = l%2 > 0 ? l/2+1 : l/2;
        //每次增量的比较计算完毕后，对增量继续除以2
        l = l/2;
    }
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    //    NSLog(@"希尔排序结果:%@",array);
}

#pragma mark - 归并排序

/**
 归并排序外部调用方法
 
 基本思想:归并排序的递归方式就类似与一个完全二叉树。把数组每次分成左右两组，然后左右两组递归分组操作，左右两组分别又再一次分为左右两组。直到子树只有一个数为止。然后把子树从下向上进行比较，先从最底层只有一个数的子树进行左右比较。如果发现顺序不对就交换。交换后又对子树的父节点层左右子树进行比较。此时的比较方式与只有一个数的子树不一样。因为现在比较的左右子树都是数组。首先需要先创建一个新数组，这个新数组是用于保存2个数组比较排序后的正确顺序，需要先用左右数组首个数比较找到左右两组中最小的元素并把最小元素加入新数组中，然后用另一个较大的元素与较小元素的其他数进行比较，直到找到下一个较小的元素加入新数组中，这样重复比较，直到比较到一个数组中所有元素比较完成后，把另一个数组剩余的数按照顺序加入到新数组中，此时新数组中就包含了2个比较数组的所有元素。把新数组与比较的左右数组在原数组中的位置元素进行替换。这样重复操作。直到没有上层了。此时数组就完成了排序。
 
 @param array 原始需要排序的数组
 @param isFromMaxToMin YES表示排序后的数组时从大到小的
 */
+ (void)mergeSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    //忽略操作
    if (!array || array.count < 2) {
        return ;
    }
    //进行归并排序
    [self mergeSort:array leftIndex:0 rightIndex:array.count-1];
    //判断是否从大到小输出
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    //    NSLog(@"归并排序结果:%@",array);
}

/**
 归并排序之左右分组递归方法
 
 @param array 原始数组
 @param left 需要分组的数据最左边下坐标
 @param right 需要分组的数据最右边下坐标
 */
+ (void)mergeSort:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    //如果left下坐标不小于right下坐标。说明已经是最底层子树。只有左右子树只有1个元素了。不需要在分组
    if (left < right) {
        //mind是把数组左右分组后，右边数组第一个元素的下坐标。如果数组长度是单数，则把最中间的数放在右边数组中
        NSInteger mind = (left+right)%2 > 0 ? (left+right)/2+1 : (left+right)/2;
        //循环递归分组
        [self mergeSort:array leftIndex:left rightIndex:mind-1];
        [self mergeSort:array leftIndex:mind rightIndex:right];
        //分组完成后对数组进行比较排序
        [self merge:array leftIndex:left rightIndex:right MindIndex:mind];
    }
}

/**
 归并排序的核心比较方法
 
 @param array 原数组
 @param left 比较的左边数组的首位元素下坐标
 @param right 比较的右边数组的最末尾元素下坐标
 @param mind 比较的右边数组的首位元素下坐标
 */
+ (void)merge:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right MindIndex:(NSInteger)mind
{
    //left == mind 说明这是最下层子树
    if (right == mind) {
        //最下层子树，只需要比较后交换位置即可
        if ([[array hx_objectAtIndex:left] integerValue] > [[array hx_objectAtIndex:right] integerValue]) {
            [array exchangeObjectAtIndex:left withObjectAtIndex:right];
        }
    }else
    {
        //非最下层子树，需要先创建一个新的数组，来保存正确排序的结果
        NSMutableArray *newArray = [NSMutableArray new];
        //临时记录原mind值,用作比较
        NSInteger mind_x = mind;
        //临时记录原left值,用作比较
        NSInteger left_x = left;
        //循环操作，直到左右两个数组中有一方的所有元素都比较完成
        while (mind_x <= right && left_x < mind) {
            if ([[array hx_objectAtIndex:left_x] integerValue] > [[array hx_objectAtIndex:mind_x] integerValue]) {
                //如果左边元素大于右边元素那么就把小的元素加入新数组中
                [newArray addObject:[array hx_objectAtIndex:mind_x]];
                //然后把mind_x加1，让较大的左边元素与下一个右边元素进行比较
                mind_x++;
            }else
            {
                //如果左边元素小于右边元素那么就把小的元素加入新数组中
                [newArray addObject:[array hx_objectAtIndex:left_x]];
                //然后把left_x加1，让较大的右边元素与下一个左边元素进行比较
                left_x++;
            }
        }
        
        //如果左边的元素没有比较完，那么把剩下的左边元素依次加入到新数组中
        while (left_x < mind) {
            [newArray addObject:[array hx_objectAtIndex:left_x]];
            left_x++;
        }
        //如果右边的元素没有比较完，那么把剩下的右边元素依次加入到新数组中
        while (mind_x <= right) {
            [newArray addObject:[array hx_objectAtIndex:mind_x]];
            mind_x++;
        }
        //把排序好的正确数组与比较的左右数组在原始数组中对应位置的元素进行替换
        NSRange range = NSMakeRange(left, (right-left)+1);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [array replaceObjectsAtIndexes:indexSet withObjects:newArray];
        
    }
}

#pragma mark - 基数排序

/**
 基数排序
 基本思想:基数排序最核心思想就是入桶。基数排序主要的步骤有3步
 1.找到元素组中最大的元素
 2.根据1找到的元素，把原数组中所有元素按照最大元素补位，例如：最大元素是1001，而原数组中有一个元素为2，那么把2按照最大元素补位，就是把2的长度补到与最大元素长度一样，前面补0，2补位后就变成了0002。
 3.创建桶，因为数字是从0-9的。一共10个桶。把补位后的数组从个位，十位，百位...以此类推。进行每一位的单独排序，从桶0开始，只要有比较的位数是0，就把元素放入桶0中。个位比较完了就比较十位，一直比较到最大位。最后数组就已经成为一个有序数组了
 
 @param array 原数组
 @param isFromMaxToMin YES表示从大到小排序
 */
+ (void)radixSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin
{
    //忽略操作
    if (!array || array.count < 2) {
        return ;
    }
    
    /* 进行基数排序 */
    
    //1.获取数组中最大的元素
    NSString *maxNumber = [self getArrayInMaxNumber:array];
    //2.根据最大元素对数组进行补位
    [self complementWithArray:array maxNumber:maxNumber];
    //3.入桶比较排序
    array = [self radixSort:array maxNumber:maxNumber];
    
    /* 进行基数排序 */
    
    
    //判断是否从大到小输出
    if (isFromMaxToMin) {
        array = [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    }
    //    NSLog(@"基数排序结果:%@",array);
}
//从数组中获取最大值
+ (NSString *)getArrayInMaxNumber:(NSMutableArray *)array
{
    NSString *maxNumber = @"0";
    for (NSString *number in array) {
        if ([maxNumber integerValue] < [number integerValue]) {
            maxNumber = [number copy];
        }
    }
    return maxNumber;
}

/**
 根据最大元素，对数组中所有元素进行补位
 
 @param array 需要补位的数组
 @param maxNumber 最大元素，用作补位的参照
 */
+ (void)complementWithArray:(NSMutableArray *)array maxNumber:(NSString *)maxNumber
{
    //我这里元素都是用的NSString。所以补位采用该方法。
    //如果元素是int等可以不用进行这种补位。在比较的时候判断下长度,长度不够直接补0比较即可
    for (NSInteger j = 0; j < array.count; j++) {
        NSString *number = [array hx_objectAtIndex:j];
        if (number.length < maxNumber.length) {
            NSInteger len = maxNumber.length-number.length;
            NSString *str = @"";
            for (NSInteger i = 0; i < len; i++) {
                str = [str stringByAppendingString:@"0"];
            }
            array[j] = [NSString stringWithFormat:@"%@%@",str,number];
        }
    }
}

/**
 基数排序的核心防化服
 
 @param array 原数组
 @param maxNumber 原数组中最大的元素
 @return 返回一个排序完成的新数组
 */
+ (NSMutableArray *)radixSort:(NSMutableArray *)array maxNumber:(NSString *)maxNumber
{
    //copy一份原数组，arrayCopy后面主要是用来记录重新排序后的最新数组
    NSMutableArray *arrayCopy = [array mutableCopy];
    //根据最大元素判断需要比较多少位
    for (NSInteger i = 0; i < maxNumber.length; i++) {
        //创建装桶的数组
        NSMutableArray *bucketArray = [NSMutableArray array];
        //0-9一共10个桶，
        for (NSInteger j = 0; j < 10; j++) {
            //桶，当前需要放入的元素根据j定
            NSMutableArray *bucket = [NSMutableArray array];
            //遍历数组，找到相应位数的元素是否该放入当前桶
            for (NSInteger m = 0; m < arrayCopy.count; m++) {
                //取出数组每个元素
                NSString *number = [arrayCopy hx_objectAtIndex:m];
                //取出需要比较的位所对应的值
                NSInteger num = [[number substringWithRange:NSMakeRange(number.length-1-i, 1)] integerValue];
                //如果比较的位所对应的值跟桶的值一样，就把该元素加入对应桶中
                if (num == j) {
                    [bucket addObject:number];
                }
            }
            //如果桶中有元素才把桶加入存放桶的数组
            if (bucket.count > 0) {
                //把桶加入数组
                [bucketArray addObject:bucket];
            }
        }
        //移除上一次记录的值
        [arrayCopy removeAllObjects];
        //把根据桶排序好的数组放入arrayCopy中，直到每一位都比较完，那么数组已经排序完成了
        for (NSMutableArray *obj in bucketArray) {
            for (NSString *str in obj) {
                [arrayCopy addObject:str];
            }
        }
    }
    return arrayCopy;
}

@end
