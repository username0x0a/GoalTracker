//
//  InterfaceController.h
//  GoalTracker WatchKit Extension
//
//  Created by Michi on 09/01/2020.
//  Copyright © 2020 Michi. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface InterfaceController : WKInterfaceController

@property (nonatomic, weak) IBOutlet WKInterfaceLabel *purpleScoreLabel;
@property (nonatomic, weak) IBOutlet WKInterfaceLabel *yellowScoreLabel;

@property (nonatomic, weak) IBOutlet WKInterfaceButton *purpleMinusButton;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *purplePlusButton;

@property (nonatomic, weak) IBOutlet WKInterfaceButton *yellowMinusButton;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *yellowPlusButton;

@property (nonatomic, weak) IBOutlet WKInterfaceButton *resetButton;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *reallyResetGroup;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *reallyResetButton;
@property (nonatomic, weak) IBOutlet WKInterfaceButton *reallyBackButton;

@property (nonatomic, weak) IBOutlet WKInterfaceGroup *yellowGroup;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *purpleGroup;
@property (nonatomic, weak) IBOutlet WKInterfaceGroup *resetGroup;

@end
