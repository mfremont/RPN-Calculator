//
//  StackVariable.h
//  Calculator
//
//  Created by Matthew Fremont on 2/15/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalculatorStack.h"

@interface StackVariable : NSObject<StackExpression>

@property (readonly, strong, nonatomic) NSString *name;

-(id)initWithName:(NSString *)name;

@end
