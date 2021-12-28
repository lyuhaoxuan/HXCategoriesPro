//
//  HXHeader.h
//  Pods
//
//  Created by 吕浩轩 on 2020/12/15.
//

#ifndef HXHeader_h
#define HXHeader_h

#import <TargetConditionals.h>

// Seems like TARGET_OS_MAC is always defined (on all platforms).
// To determine if we are running on macOS, use TARGET_OS_OSX in Xcode 8
#if TARGET_OS_OSX
    #define HX_MAC 1
#else
    #define HX_MAC 0
#endif

// iOS and tvOS are very similar, UIKit exists on both platforms
// Note: watchOS also has UIKit, but it's very limited
#if TARGET_OS_IOS
    #define HX_UIKIT 1
#else
    #define HX_UIKIT 0
#endif

#if TARGET_OS_IOS
    #define HX_IOS 1
#else
    #define HX_IOS 0
#endif

#if TARGET_OS_TV
    #define HX_TV 1
#else
    #define HX_TV 0
#endif

#if TARGET_OS_WATCH
    #define HX_WATCH 1
#else
    #define HX_WATCH 0
#endif


#if HX_MAC
    #import <Cocoa/Cocoa.h>
    #ifndef UIImage
        #define UIImage NSImage
    #endif
    #ifndef UIImageView
        #define UIImageView NSImageView
    #endif
    #ifndef UIView
        #define UIView NSView
    #endif
    #ifndef UIColor
        #define UIColor NSColor
    #endif
    #ifndef UIApplication
        #define UIApplication NSApplication
    #endif
    #ifndef UIFont
        #define UIFont NSFont
    #endif
    #ifndef UIEdgeInsets
        #define UIEdgeInsets NSEdgeInsets
    #endif
    #ifndef UITextField
        #define UITextField NSTextField
    #endif
    #ifndef UIDevice
        #define UIDevice HXDevice
    #endif

#else
    #if HX_UIKIT
        #import <UIKit/UIKit.h>
    #endif
    #if HX_WATCH
        #import <WatchKit/WatchKit.h>
        #ifndef UIView
            #define UIView WKInterfaceObject
        #endif
        #ifndef UIImageView
            #define UIImageView WKInterfaceImage
        #endif
    #endif
#endif

#endif /* HXHeader_h */
