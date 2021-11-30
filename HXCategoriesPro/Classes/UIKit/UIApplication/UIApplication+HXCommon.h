//
//  UIApplication+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/4.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIApplication`.
 */
@interface UIApplication (HXCommon)

/** "Documents" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *documentURL;
/** "Documents" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *documentPath;

/** "Library" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *libraryURL;
/** "Library" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *libraryPath;

/** "Caches" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *cacheURL;
/** "Caches" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *cachePath;

/** APP 沙盒已使用大小 */
@property (nonatomic, readonly) NSString *applicationSize;

/** Application's Bundle Name. */
@property (nullable, nonatomic, readonly) NSString *appBundleName;

/** Application's Bundle ID. */
@property (nullable, nonatomic, readonly) NSString *appBundleID;

/** Application's Version.  e.g. "2.2.0" */
@property (nullable, nonatomic, readonly) NSString *appVersion;

/**  Application's Build number. e.g. "123" */
@property (nullable, nonatomic, readonly) NSString *appBuildVersion;

@end

NS_ASSUME_NONNULL_END
