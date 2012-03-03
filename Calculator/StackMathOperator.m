//
//  StackMathOperator.m
//  Calculator
//
//  Created by Matthew Fremont on 2/13/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "StackMathOperator.h"
#import <math.h>

@implementation UnaryOperator

-(NSString *)descriptionUsingStack:(CalculatorStack *)stack {
    id<StackExpression> operand = [stack popExpression];
    NSString *description = [operand descriptionUsingStack:stack];
    if ([description hasPrefix:@"("] && [description hasSuffix:@")"]) {
        // strip parentheses surrounding operand
        NSRange range;
        range.length = description.length - 2;
        range.location = 1;
        description = [description substringWithRange:range];
    }
    return [NSString stringWithFormat:@"%@(%@)", self.description, description];
}

-(NSUInteger)numberOfOperands {
    return 1;
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    // subclass should override with an actual implementation
    return 0;
}

@end

@implementation SqrtOperator

-(NSString *)description {
    return @"√";
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    double result = 0;
    id<StackExpression> operand = [stack popExpression];
    if (operand) {
        result = sqrt([operand evaluateUsingStack:stack]);
    }
    return result;
}

@end

@implementation CosOperator

-(NSString *)description {
    return @"cos";
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    double result = 0;
    id<StackExpression> operand = [stack popExpression];
    if (operand) {
        result = cos([operand evaluateUsingStack:stack]);
    }
    return result;
}
@end

@implementation SinOperator

-(NSString *)description {
    return @"sin";
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    double result = 0;
    id<StackExpression> operand = [stack popExpression];
    if (operand) {
        result = sin([operand evaluateUsingStack:stack]);
    }
    return result;
}
@end
