//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Matthew Fremont on 1/30/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *programDisplay;
@property (weak, nonatomic) IBOutlet UILabel *variableDisplay;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)variablePressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;
- (IBAction)undoPressed;
- (IBAction)clearAllPressed;
- (IBAction)signPressed;
- (IBAction)enterPressed;
- (IBAction)testVariablesPressed:(UIButton *)sender;

@end
