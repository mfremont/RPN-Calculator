//
//  StackVariable.m
//  Calculator
//
//  Created by Matthew Fremont on 2/15/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "StackVariable.h"

@implementation StackVariable

@synthesize name = _name;

-(id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self->_name = name;
    }
    return self;
}

-(NSString *)description {
    return self.name;
}

-(NSString *)descriptionUsingStack:(CalculatorStack *)stack {
    return self.description;
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    double result = 0;
    // attempt to resolve the variable using stack.variables
    id variableValue = [stack.variables valueForKey:self.name];
    if ([variableValue isKindOfClass:[NSNumber class]]) {
        result = [variableValue doubleValue];
    }
    return result;
}

-(NSUInteger)numberOfOperands {
    return 0;
}

@end
