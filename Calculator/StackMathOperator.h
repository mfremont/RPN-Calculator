//
//  StackMathOperator.h
//  Calculator
//
//  Created by Matthew Fremont on 2/13/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorStack.h"

@interface UnaryOperator : NSObject <StackExpression>
@end

@interface SqrtOperator : UnaryOperator
@end

@interface SinOperator : UnaryOperator
@end

@interface CosOperator : UnaryOperator
@end
