//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Matthew Fremont on 1/30/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController()

@property (nonatomic) BOOL isBufferingDigits;
@property (strong, nonatomic) CalculatorBrain *brain;
@property (strong, nonatomic) NSDictionary *variables;
@property (weak, nonatomic) NSString *displayDigits;

@end

@implementation CalculatorViewController

@synthesize isBufferingDigits = _isBufferingDigits;
@synthesize display = _display;
@synthesize programDisplay = _programDisplay;
@synthesize variableDisplay = _variableDisplay;
@synthesize brain = _brain;
@synthesize variables = _variables;

- (CalculatorBrain *)brain {
    if (_brain == nil) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (NSString *)displayDigits {
    return self.display.text;
}

- (void)setDisplayDigits:(NSString *)digitString {
    self.display.text = digitString;
}

- (void)setDisplayFromDouble:(double)doubleVal {
    self.displayDigits = [NSString stringWithFormat:@"%g", doubleVal];
}

- (void)updateProgramDisplay {
    self.programDisplay.text = [[self.brain class] descriptionOfProgram:self.brain.program];
}

- (void)updateVariableDisplay {
    NSSet *variablesUsed = [CalculatorBrain variablesUsedInProgram:self.brain.program];
    NSMutableArray *displayText;
    for (NSString *variableKey in variablesUsed) {
        if (displayText == nil) {
            displayText = [[NSMutableArray alloc] initWithCapacity:variablesUsed.count];
        }
        [displayText addObject: [NSString stringWithFormat:@"%@=%g", variableKey, [[self.variables valueForKey:variableKey] doubleValue]]];
    }
    self.variableDisplay.text = [displayText componentsJoinedByString:@" "];
}

-(void)pushBufferedDigits {
    if (self.isBufferingDigits) {
        [self.brain pushOperand:[self.displayDigits doubleValue]];
        self.isBufferingDigits = NO;
    }
}

-(void)updateDisplay {
    double result = [CalculatorBrain runProgram:self.brain.program usingVariableValues:self.variables];
    [self setDisplayFromDouble:result];
    [self updateProgramDisplay];
    [self updateVariableDisplay];
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = sender.currentTitle;
    if ([digit isEqualToString:@"."]) {
        // make sure we only allow one decimal point to be added
        NSRange range = [self.displayDigits rangeOfString:digit];
        if (range.length == 0) {
            if (!self.isBufferingDigits) {
                // preserve leading "0"
                digit = [@"0" stringByAppendingString:digit];
            }
        } else {
            // user already entered a decimal. ignore this key press.
            digit = @"";
        }
    }
    // update the display
    if (self.isBufferingDigits) {
        [self setDisplayDigits:[self.displayDigits stringByAppendingString:digit]];
    } else {
        [self setDisplayDigits:digit];
        self.isBufferingDigits = YES;
    }
}

- (IBAction)operationPressed:(UIButton *)sender {
    NSString *operation = [sender currentTitle];
    // push current buffered digits to allow shortcut: 3 ENTER 2 *
    [self pushBufferedDigits];
    [self.brain pushOperator:operation];
    [self updateDisplay];
}

- (IBAction)undoPressed {
    if (self.isBufferingDigits) {
        // interpret "undo" as a backspace and remove last digit
        NSUInteger length = [self.displayDigits length];
        self.displayDigits = [self.displayDigits substringToIndex:(length-1)];
    } else {
        [self.brain removeLastItemFromProgram];
        [self updateDisplay];
    }
}

- (IBAction)clearAllPressed {
    [self.brain clearAll];
    [self updateDisplay];
}

- (IBAction)signPressed {
    // toggle sign
    if ([self.displayDigits hasPrefix:@"-"]) {
        // remove leading minus
        self.displayDigits = [self.displayDigits substringFromIndex:1];
    } else {
        self.displayDigits = [@"-" stringByAppendingString:self.displayDigits];
    }
}

- (IBAction)enterPressed {
    [self pushBufferedDigits];
    [self updateProgramDisplay];
}

- (IBAction)testVariablesPressed:(UIButton *)sender {
    [self pushBufferedDigits];
    NSString *testName = [sender currentTitle];
    if ([testName isEqualToString:@"test1"]) {
        self.variables = [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithDouble:3.3], @"x",
            [NSNumber numberWithDouble:-1.5], @"y",
            nil];
    } else if ([testName isEqualToString:@"test2"]) {
        self.variables = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithDouble:0], @"z",
                          [NSNumber numberWithDouble:1000000], @"q",
                          [NSNumber numberWithDouble:-1000000], @"w",
                          nil];
    } else if ([testName isEqualToString:@"test3"]) {
        self.variables = nil;
    }
    [self updateDisplay];
}

- (IBAction)variablePressed:(UIButton *)sender {
    NSString *variableName = [sender currentTitle];
    [self pushBufferedDigits];
    [self.brain pushVariable:variableName];
    [self updateProgramDisplay];
    [self updateVariableDisplay];
}

- (void)viewDidUnload {
    [self setProgramDisplay:nil];
    [self setVariableDisplay:nil];
    [super viewDidUnload];
}
@end
