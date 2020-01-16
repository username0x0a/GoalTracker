//
//  InterfaceController.m
//  GoalTracker WatchKit Extension
//
//  Created by Michi on 09/01/2020.
//  Copyright © 2020 Michi. All rights reserved.
//

#import "InterfaceController.h"
#import "RunningSession.h"


@interface InterfaceController ()

@property (nonatomic) NSUInteger yellowScore;
@property (nonatomic) NSUInteger purpleScore;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
	[super awakeWithContext:context];

	// Configure interface objects here.
	[self loadState];

	__auto_type __weak ws = self;
	RunningSession *sess = [RunningSession sharedSession];

	sess.activationBlock = ^{
		__auto_type ss = ws;
		[ss notifyActivated:YES];
	};

	sess.deactivationBlock = ^{
		__auto_type ss = ws;
		[ss notifyActivated:NO];
	};

	[self notifyActivated:NO];
}

- (void)notifyActivated:(BOOL)activated
{
	WKMenuItemIcon icon = (activated) ? WKMenuItemIconDecline : WKMenuItemIconPlay;
	NSString *title = (activated) ? @"Stop Session" : @"Start Session";
	SEL sel = (activated) ? @selector(stopSession) : @selector(startSession);

	[self clearAllMenuItems];
	[self addMenuItemWithItemIcon:icon title:title action:sel];

	CGFloat alpha = (activated) ? 1.0 : 0.4;
	[_yellowGroup setAlpha:alpha];
	[_purpleGroup setAlpha:alpha];
	[_resetGroup setAlpha:alpha];
}

- (void)willActivate {
	// This method is called when watch view controller is about to be visible to user
	[super willActivate];
	[self loadState];
}

- (void)didDeactivate {
	// This method is called when watch view controller is no longer visible
	[super didDeactivate];
	[self saveState];
}

- (void)startSession
{
	[[RunningSession sharedSession] activate];
}

- (void)stopSession
{
	[[RunningSession sharedSession] deactivate];
}

- (void)loadState
{
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	_yellowScore = [def integerForKey:@"YellowScore"];
	_purpleScore = [def integerForKey:@"PurpleScore"];
	[self reloadScore];
}

- (void)saveState
{
	NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
	[def setInteger:_yellowScore forKey:@"YellowScore"];
	[def setInteger:_purpleScore forKey:@"PurpleScore"];
	[def synchronize];
}

- (void)setYellowScore:(NSUInteger)yellowScore
{
	_yellowScore = yellowScore;
	[self reloadScore];
}

- (void)setPurpleScore:(NSUInteger)purpleScore
{
	_purpleScore = purpleScore;
	[self reloadScore];
}

- (void)reloadScore
{
	[_yellowScoreLabel setText:[NSString stringWithFormat:@"%tu", _yellowScore]];
	[_purpleScoreLabel setText:[NSString stringWithFormat:@"%tu", _purpleScore]];
	[self setReallyResetVisible:NO];
	[self saveState];
}

- (IBAction)yellowMinusButtonAction:(id)sender
{
	if (_yellowScore)
		self.yellowScore -= 1;
}

- (IBAction)yellowPlusButtonAction:(id)sender
{
	self.yellowScore += 1;
}

- (IBAction)purpleMinusButtonAction:(id)sender
{
	if (_purpleScore)
		self.purpleScore -= 1;
}

- (IBAction)purplePlusButtonAction:(id)sender
{
	self.purpleScore += 1;
}

- (void)setReallyResetVisible:(BOOL)reallyResetVisible
{
	[_resetButton setHidden:reallyResetVisible];
	[_reallyResetGroup setHidden:!reallyResetVisible];
}

- (IBAction)resetButtonAction:(id)sender
{
	[self setReallyResetVisible:YES];
}

- (IBAction)reallyBackButtonAction:(id)sender
{
	[self setReallyResetVisible:NO];
}

- (IBAction)reallyResetButtonAction:(id)sender
{
	self.purpleScore = 0;
	self.yellowScore = 0;
	[self setReallyResetVisible:NO];
}

@end
