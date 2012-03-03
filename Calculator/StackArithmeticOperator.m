//
//  StackArithmeticOperator.m
//  Calculator
//
//  Created by Matthew Fremont on 2/13/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "StackArithmeticOperator.h"

@implementation BinaryArithmeticOperator
-(NSUInteger)numberOfOperands {
    return 2;
}

-(NSString *)description {
    // subclass should override with a suitable implementation
    return nil;
}

-(NSString *)descriptionUsingStack:(CalculatorStack *)stack {
    id<StackExpression> op1 = [stack popExpression];
    NSString *op1Description = (op1 != nil) ? [op1 descriptionUsingStack:stack] : @"0";
    id<StackExpression> op0 = [stack popExpression];
    NSString *op0Description = (op0 != nil) ? [op0 descriptionUsingStack:stack] : @"0";;
    return [self descriptionForOperands: op0Description  op1:op1Description];
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    id<StackExpression> op1 = [stack popExpression];
    double op1Val = [op1 evaluateUsingStack:stack];
    id<StackExpression> op0 = [stack popExpression];
    double op0Val = [op0 evaluateUsingStack:stack];
    return [self evaluateForOperands: op0Val op1:op1Val];
}

-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString *)op1 {
    // subclass should override with a suitable implementation
    return nil;
}

-(double)evaluateForOperands:(double)op0 op1:(double)op {
    // subclass should override with a suitable implementation
    return 0;
}

@end

@implementation StackAdditionOperator
-(NSString *)description {
    return @"+";
}

-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString *)op1 {
    return [NSString stringWithFormat: @"(%@ %@ %@)", op0, self.description, op1];
}

-(double)evaluateForOperands:(double)op0 op1:(double)op1 {
    return op0 + op1;
}
@end

@implementation StackSubtractionOperator
-(NSString *)description {
    return @"-";
}

-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString *)op1 {
    return [NSString stringWithFormat: @"(%@ %@ %@)", op0, self.description, op1];
}

-(double)evaluateForOperands:(double)op0 op1:(double)op1 {
    return op0 - op1;
}
@end

@implementation StackMultiplicationOperator
-(NSString *)description {
    return @"*";
}

-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString *)op1 {
    return [NSString stringWithFormat: @"%@ %@ %@", op0, self.description, op1];
}

-(double)evaluateForOperands:(double)op0 op1:(double)op1 {
    return op0 * op1;
}
@end

@implementation StackDivisionOperator
-(NSString *)description {
    return @"/";
}

-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString *)op1 {
    return [NSString stringWithFormat: @"%@ %@ %@", op0, self.description, op1];
}

-(double)evaluateForOperands:(double)op0 op1:(double)op1 {
    if (op1 == 0) {
        // division by 0
        return NAN;
    } else {
        return op0 / op1;
    }
}
@end
