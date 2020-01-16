//
//  RunningSession.m
//  GoalTracker WatchKit Extension
//
//  Created by Michi on 16/01/2020.
//  Copyright © 2020 Michi. All rights reserved.
//

#import "RunningSession.h"
#import <WatchKit/WatchKit.h>

@interface RunningSession () <WKExtendedRuntimeSessionDelegate>

@property (nonatomic, strong) WKExtendedRuntimeSession *session;

@end

@implementation RunningSession

+ (instancetype)sharedSession
{
	static RunningSession *sess;

	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sess = [RunningSession new];
	});

	return sess;
}

- (void)activate
{
	WKExtendedRuntimeSession *sess = _session;

	if (sess.state == WKExtendedRuntimeSessionStateRunning)
	{
		RunningSessionBlock block = _activationBlock;
		if (block) block();
		return;
	}

	[sess invalidate];

	_session = [WKExtendedRuntimeSession session];
	_session.delegate = self;
	[_session start];
}

- (void)deactivate
{
	[_session invalidate];
}

- (void)extendedRuntimeSessionDidStart:(nonnull WKExtendedRuntimeSession *)extendedRuntimeSession {
	NSLog(@"[SESS] Session started 👍");
	RunningSessionBlock block = _activationBlock;
	if (block) block();
}

- (void)extendedRuntimeSessionWillExpire:(nonnull WKExtendedRuntimeSession *)extendedRuntimeSession {
	NSLog(@"[SESS] Session will expire!");
}

- (void)extendedRuntimeSession:(nonnull WKExtendedRuntimeSession *)extendedRuntimeSession didInvalidateWithReason:(WKExtendedRuntimeSessionInvalidationReason)reason error:(NSError * _Nullable)error {
	NSLog(@"[SESS] Invalidating session: %@", error);
	RunningSessionBlock block = _deactivationBlock;
	if (block) block();
}

@end
