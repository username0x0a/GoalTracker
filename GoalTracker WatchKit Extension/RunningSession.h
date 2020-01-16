//
//  RunningSession.h
//  GoalTracker WatchKit Extension
//
//  Created by Michi on 16/01/2020.
//  Copyright © 2020 Michi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^RunningSessionBlock)(void);

@interface RunningSession : NSObject

@property (nonatomic, copy, nullable) RunningSessionBlock activationBlock;
@property (nonatomic, copy, nullable) RunningSessionBlock deactivationBlock;

- (void)activate;
- (void)deactivate;

+ (instancetype)sharedSession;
+ (instancetype)new  UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
