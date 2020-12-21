//
//  UIApplication+HXCommon.h
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/4.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "HXHeader.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Provides extensions for `UIApplication`.
 */
@interface UIApplication (HXCommon)

/** "Documents" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *hx_documentURL;
/** "Documents" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *hx_documentPath;

/** "Library" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *hx_libraryURL;
/** "Library" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *hx_libraryPath;

/** "Caches" folder in this app's sandbox. */
@property (nonatomic, readonly) NSURL *hx_cacheURL;
/** "Caches" folder in this app's sandbox. */
@property (nonatomic, readonly) NSString *hx_cachePath;

/** APP 沙盒已使用大小 */
@property (nonatomic, readonly) NSString *hx_applicationSize;

/** Application's Bundle Name. */
@property (nullable, nonatomic, readonly) NSString *hx_appBundleName;

/** Application's Bundle ID. */
@property (nullable, nonatomic, readonly) NSString *hx_appBundleID;

/** Application's Version.  e.g. "2.2.0" */
@property (nullable, nonatomic, readonly) NSString *hx_appVersion;

/**  Application's Build number. e.g. "123" */
@property (nullable, nonatomic, readonly) NSString *hx_appBuildVersion;

@end

NS_ASSUME_NONNULL_END
