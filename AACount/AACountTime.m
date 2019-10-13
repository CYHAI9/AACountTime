//
//  AACountTime.m
//  AACountTime
//
//  Created by ChenYinHai on 2019/10/13.
//  Copyright © 2019 cyhai. All rights reserved.
//

#import "AACountTime.h"
 
static AACountTime * atime;
@implementation AACountTime{
    double _startTime;
    double _endTime;
}
+ (void)load{
    AACountTime * count = [self shareObject];
    NSLog(@"统计开始加载");
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
