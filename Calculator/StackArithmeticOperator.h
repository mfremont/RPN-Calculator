//
//  StackArithmeticOperator.h
//  Calculator
//
//  Created by Matthew Fremont on 2/13/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorStack.h"

@interface BinaryArithmeticOperator : NSObject<StackExpression>
-(NSString *)descriptionForOperands:(NSString *)op0 op1:(NSString*)op1;
-(double)evaluateForOperands:(double)op0 op1:(double)op;

@end

@interface StackAdditionOperator : BinaryArithmeticOperator
@end

@interface StackSubtractionOperator : BinaryArithmeticOperator
@end

@interface StackMultiplicationOperator : BinaryArithmeticOperator
@end

@interface StackDivisionOperator : BinaryArithmeticOperator
@end
