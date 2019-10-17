//
//  AACountTime.m
//  AACountTime
//
//  Created by ChenYinHai on 2019/10/13.
//  Copyright © 2019 cyhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <mach/mach.h>
#import "AACountTime.h"
 
static uint64_t loadTime;
static uint64_t applicationRespondedTime = -1;
static mach_timebase_info_data_t timebaseInfo;
static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer) / timebaseInfo.denom;
}

static AACountTime * atime;
@implementation AACountTime{
    double _startTime;
    double _endTime;
}
+ (void)load{
    loadTime = mach_absolute_time();
    mach_timebase_info(&timebaseInfo);
    
    @autoreleasepool {
        __block id<NSObject> obs;
        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification
                                                                object:nil queue:nil
                                                            usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                applicationRespondedTime = mach_absolute_time();
                NSLog(@"统计开始加载StartupMeasurer: it took %f seconds until the app could respond to user interaction.", MachTimeToSeconds(applicationRespondedTime - loadTime));
            });
            [[NSNotificationCenter defaultCenter] removeObserver:obs];
        }];
    }
    AACountTime * count = [self shareObject];
    [count startLoad];
}

+ (instancetype)shareObject{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        atime = [[AACountTime alloc] init];
    });
    return atime;
}

- (void)startLoad{
    _startTime = CFAbsoluteTimeGetCurrent();
}

- (double)endLoad{
    _endTime = CFAbsoluteTimeGetCurrent();
    return _endTime - _startTime;
}


@end
