//
//  UIApplication+HXCommon.m
//  LHX.
//
//  Created by 吕浩轩 on 2018/6/4.
//  Copyright © 2019年 LHX. All rights reserved.
//

#import "UIApplication+HXCommon.h"

@implementation UIApplication (HXCommon)

- (NSURL *)hx_documentURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hx_documentPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)hx_libraryURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hx_libraryPath {
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSURL *)hx_cacheURL {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)hx_cachePath {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *)hx_applicationSize {
    NSUInteger docSize   =  [self hx_sizeOfFolder:[self hx_documentPath]];
    NSUInteger libSize   =  [self hx_sizeOfFolder:[self hx_libraryPath]];
    NSUInteger cacheSize =  [self hx_sizeOfFolder:[self hx_cachePath]];
    
    NSUInteger total = docSize + libSize + cacheSize;
    
    NSString *folderSizeStr = [NSByteCountFormatter stringFromByteCount:total countStyle:NSByteCountFormatterCountStyleFile];
    return folderSizeStr;
}

-(NSUInteger)hx_sizeOfFolder:(NSString *)folderPath
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:nil];
    NSEnumerator *contentsEnumurator = [contents objectEnumerator];
    
    NSString *file;
    NSUInteger folderSize = 0;
    
    while (file = [contentsEnumurator nextObject]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:[folderPath stringByAppendingPathComponent:file] error:nil];
        folderSize += [[fileAttributes objectForKey:NSFileSize] integerValue];
    }
    return folderSize;
}

- (NSString *)hx_appBundleName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
}

- (NSString *)hx_appBundleID {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
}

- (NSString *)hx_appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)hx_appBuildVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
}



@end
