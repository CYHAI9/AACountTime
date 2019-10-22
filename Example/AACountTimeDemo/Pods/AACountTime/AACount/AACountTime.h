//
//  AACountTime.h
//  AACountTime
//
//  Created by ChenYinHai on 2019/10/13.
//  Copyright © 2019 cyhai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AACountTime : NSObject

+ (instancetype)shareObject;

- (void)startLoad;
- (double)endLoad;

@end

NS_ASSUME_NONNULL_END
