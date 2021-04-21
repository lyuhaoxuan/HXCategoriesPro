//
//  NSArray+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/2.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HXCommon)

/**
 判断 NSArray 是否为空

 @param array array
 @return 空 --> YES,  非空 --> NO
 */
+ (BOOL)hx_isEmpty:(nullable NSArray *)array;

/**
 判断 NSArray 是否安全

 @return 安全 --> YES,  不安全 --> NO
 */
- (BOOL)hx_isSafe;

/**
 由基于 NSArray 类型的 plist 数据, 创建并返回新的 NSArray
 
 @param plist   基于 NSArray 类型的 plist 数据
 @return 由 plist 数据创建新的 NSArray, 如果发生错误则为nil
 */
+ (nullable NSArray *)hx_arrayWithPlistData:(NSData *)plist;

/**
 由基于 NSArray 类型的 plist 字符串(XML), 创建并返回新的 NSArray
 
 @param plist   基于 NSArray 类型的 plist 字符串(XML)
 @return 由 plist 字符串(XML) 创建新的 NSArray, 如果发生错误则为 nil
 */
+ (nullable NSArray *)hx_arrayWithPlistString:(NSString *)plist;

/**
 将 NSArray 序列化为二进制 plist 数据
 
 @return plist 数据, 如果发生错误则为 nil
 */
- (nullable NSData *)hx_plistData;

/**
 将 NSArray 序列化为 plist 字符串(XML)
 
 @return plist 字符串(XML), 如果发生错误则为 nil
 */
- (nullable NSString *)hx_plistString;

/**
 随机返回一个对象
 
 @return 随机索引数组中的对象, 如果数组为空，则返回 nil
 */
- (nullable id)hx_randomObject;

/**
 将对象转换为 json 字符串. 如果发生错误, 则返回 nil
  包括: NSString/NSNumber/NSDictionary/NSArray
 */
- (nullable NSString *)hx_jsonStringEncoded;

/**
 将对象转换为 json 字符串格式化. 如果发生错误, 则返回 nil
 */
- (nullable NSString *)hx_jsonPrettyStringEncoded;

- (id)hx_objectAtIndex:(NSUInteger)index;

@end



@interface NSMutableArray (HXCommon)

/**
 由基于 NSArray 类型的 plist 数据, 创建并返回新的 NSArray
 
 @param plist   A基于 NSArray 类型的 plist 数据
 @return 由 plist 数据创建新的 NSArray, 如果发生错误则为nil
 */
+ (nullable NSMutableArray *)hx_arrayWithPlistData:(NSData *)plist;

/**
 由基于 NSArray 类型的 plist 字符串(XML), 创建并返回新的 NSArray
 
 @param plist   基于 NSArray 类型的 plist 字符串(XML)
 @return 由 plist 字符串(XML) 创建新的 NSArray, 如果发生错误则为 nil
 */
+ (nullable NSMutableArray *)hx_arrayWithPlistString:(NSString *)plist;

/**
 移除第一个对象, 如果数组为空, 则此方法无效.
 
 @discussion 苹果已经实现了这种方法, 但没有公开
 */
- (void)hx_removeFirstObject;

/**
 移除最后一个对象, 如果数组为空, 则此方法无效.
 
 @discussion 苹果已经实现了这种方法
 */
- (void)hx_removeLastObject;

/**
 取出第一个对象, 如果数组为空, 则返回nil
 
 @return 第一个对象 或 nil
 */
- (nullable id)hx_popFirstObject;

/**
 取出最后一对象, 如果数组为空, 则返回nil
 
 @return 最后一个对象 或 nil
 */
- (nullable id)hx_popLastObject;

/**
 在数组的末尾插入给定的对象
 
 @param anObject 要添加到数组末尾的对象
 该值不能为 nil, 如果 anObject 为 nil, 则引发 NSInvalidArgumentException 异常
 */
- (void)hx_appendObject:(id)anObject;

/**
 在数组的开头插入给定的对象
 
 @param anObject 要添加到数组开头的对象
 该值不能为 nil, 如果 anObject 为 nil, 则引发 NSInvalidArgumentException 异常
 */
- (void)hx_prependObject:(id)anObject;

/**
 将一个 NSArray 添加到另一个 NSArray 的末尾
 
 @param objects 尾部的那个 NSArray
 如果尾部的 NSArray 为 nil, 则此方法无效
 */
- (void)hx_appendObjects:(NSArray *)objects;

/**
 将一个 NSArray 添加到另一个 NSArray 的开头
 
 @param objects 尾部的那个 NSArray
 如果开头的 NSArray 为 nil, 则此方法无效
 */
- (void)hx_prependObjects:(NSArray *)objects;

/**
 将一个 NSArray 插入到另一个 NSArray 的指定索引处
 
 @param objects 中间的那个 NSArray
 
 @param index 要插入的索引值.
 这个值不能大于被插入数组的最大索引值, 否则引发 NSRangeException 异常
 */
- (void)hx_insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

/**
 使 NSArray 倒序
 例如: 使用前 @[ @1, @2, @3 ], 使用后 @[ @3, @2, @1 ]
 */
- (void)hx_reverse;

/**
 随机排列此数组中的对象
 */
- (void)hx_shuffle;

/**
 冒泡排序

 @param array 需要进行排序的数据源
 @param isMax YES表示从大到小排序 NO表示从小到大排序
 @return 排序好的数组
 */
- (NSMutableArray *)bubbleSortWithDataSource:(NSMutableArray *)array isMaxToMin:(BOOL)isMax;

/**
 选择排序
 
 @param array 选择排序
 @param isMax YES表示从大到小排序 NO表示从小到大
 @return 选择排序后的结果
 */
+ (NSMutableArray *)selectionSortWithDataSource:(NSMutableArray *)array isMaxToMin:(BOOL)isMax;

/**
 将数组按照完全二叉树方式进行重新构造成一个新堆（构造成一个标准的）
 
 @param array 源数组
 @param parent 当前需要判断的父节点(根据需要判断的父节点，去判断其左右树是否满足堆结构，不满足就进行交换)
 @param length 数组的长度
 */
+ (void)HeapAdjust:(NSMutableArray *)array parent:(int)parent length:(int)length;

/**
 对数组进行堆排序方法

 @param array 需要进行排序的数组
 @param isFromMaxToMin 数组排序的方式，为YES是表示数组从大到小排序，为NO则从小到大排序
 */
+ (void)heapSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;

/**
 快速排序的调用方法

 @param array 原始数组
 @param isFromMaxToMin YES表示从大到小排序 NO表示从小到大排序
 */
+ (void)quickSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;

/**
 快速排序的核心方法

 基本思想：在数组随机选择一个元素，当做基准数。用基准数与数组其他元素进行比较。将数组中比基准数大的放在右边，比基准数小的放在左边。然后把数组根据基准数分成2个数组。称之为基准数左边数组和基准数右边数组。对左右数组递归重复上面的操作。直到判断的数组只有一个元素了，就表示排序已经完成
 
 @param array 需要排序的数组
 @param leftIndex 需要排序的数组最开始的数在原数组中的下坐标
 @param rightIndex 需要排序的数组最末尾的数在原数组中的下坐标
 */
+ (void)quickSort:(NSMutableArray *)array LeftIndex:(NSInteger)leftIndex rightIndex:(NSInteger)rightIndex;

/**
 直接插入排序

 基本思想：每轮排序把数组分为2部分，一部分为已排序好的数组，一部分为还未排序好的数组。每次取出还未排序好的数组中首元素与已排序好的数组从右往左比较。如果发现从未排序中取出的元素比从已排序中取出的元素大，就把该未排序的元素插入到从已排序中取出元素的后面。这样每一轮就能确定一个未排序元素在已排序数组中的准确位置
 
 @param array 原数组
 @param isFromMaxToMin YES表示从大到小排序 NO表示从小到大
 */
+ (void)insertSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;

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
+ (void)shellSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;

/**
 归并排序外部调用方法
 
 基本思想:归并排序的递归方式就类似与一个完全二叉树。把数组每次分成左右两组，然后左右两组递归分组操作，左右两组分别又再一次分为左右两组。直到子树只有一个数为止。然后把子树从下向上进行比较，先从最底层只有一个数的子树进行左右比较。如果发现顺序不对就交换。交换后又对子树的父节点层左右子树进行比较。此时的比较方式与只有一个数的子树不一样。因为现在比较的左右子树都是数组。首先需要先创建一个新数组，这个新数组是用于保存2个数组比较排序后的正确顺序，需要先用左右数组首个数比较找到左右两组中最小的元素并把最小元素加入新数组中，然后用另一个较大的元素与较小元素的其他数进行比较，直到找到下一个较小的元素加入新数组中，这样重复比较，直到比较到一个数组中所有元素比较完成后，把另一个数组剩余的数按照顺序加入到新数组中，此时新数组中就包含了2个比较数组的所有元素。把新数组与比较的左右数组在原数组中的位置元素进行替换。这样重复操作。直到没有上层了。此时数组就完成了排序。

 @param array 原始需要排序的数组
 @param isFromMaxToMin YES表示排序后的数组时从大到小的
 */
+ (void)mergeSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;

/**
 归并排序之左右分组递归方法

 @param array 原始数组
 @param left 需要分组的数据最左边下坐标
 @param right 需要分组的数据最右边下坐标
 */
+ (void)mergeSort:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right;

/**
 归并排序的核心比较方法

 @param array 原数组
 @param left 比较的左边数组的首位元素下坐标
 @param right 比较的右边数组的最末尾元素下坐标
 @param mind 比较的右边数组的首位元素下坐标
 */
+ (void)merge:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right MindIndex:(NSInteger)mind;

/**
 基数排序
 基本思想:基数排序最核心思想就是入桶。基数排序主要的步骤有3步
    1.找到元素组中最大的元素
    2.根据1找到的元素，把原数组中所有元素按照最大元素补位，例如：最大元素是1001，而原数组中有一个元素为2，那么把2按照最大元素补位，就是把2的长度补到与最大元素长度一样，前面补0，2补位后就变成了0002。
    3.创建桶，因为数字是从0-9的。一共10个桶。把补位后的数组从个位，十位，百位...以此类推。进行每一位的单独排序，从桶0开始，只要有比较的位数是0，就把元素放入桶0中。个位比较完了就比较十位，一直比较到最大位。最后数组就已经成为一个有序数组了

 @param array 原数组
 @param isFromMaxToMin YES表示从大到小排序
 */
+ (void)radixSort:(NSMutableArray *)array isFromMaxToMin:(BOOL)isFromMaxToMin;
//从数组中获取最大值
+ (NSString *)getArrayInMaxNumber:(NSMutableArray *)array;

/**
 根据最大元素，对数组中所有元素进行补位

 @param array 需要补位的数组
 @param maxNumber 最大元素，用作补位的参照
 */
+ (void)complementWithArray:(NSMutableArray *)array maxNumber:(NSString *)maxNumber;

/**
 基数排序的核心防化服

 @param array 原数组
 @param maxNumber 原数组中最大的元素
 @return 返回一个排序完成的新数组
 */
+ (NSMutableArray *)radixSort:(NSMutableArray *)array maxNumber:(NSString *)maxNumber;

@end

NS_ASSUME_NONNULL_END
