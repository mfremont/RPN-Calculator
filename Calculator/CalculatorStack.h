//
//  CalculatorStack.h
//  Calculator
//
//  Created by Matthew Fremont on 2/14/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CalculatorStack;

@protocol StackExpression <NSObject>

-(double)evaluateUsingStack:(CalculatorStack *)stack;
/// @description Returns the value of the expression by evaluating itself in the
/// context of the stack, consuming its operands from the stack.

-(NSString *)descriptionUsingStack:(CalculatorStack *)stack;
/// @descrption Returns string representation of the expression in the context of the
/// stack, consuming its operands from the stack.

-(NSUInteger)numberOfOperands;
/// @description Returns the number of operands required to evaluate the expression or
/// produce its description.

@end

/** Representation of a double as a StackExpression.
 */
@interface StackNumber : NSObject<StackExpression>

-(id)init;
/// @description Initializes a new object with a value of 0.0

-(id)initWithDouble:(double)value;
/// @description Initializes a new object with value

-(id)initWithDouble:(double)value forSymbol:(NSString *)symbol;

@property (readonly, nonatomic, strong) NSString *symbol;
@end

/** Encapsulates the stack used to implement a simple programmable RPN Calculator
 */
@interface CalculatorStack : NSObject

@property (readonly, nonatomic) NSUInteger count;
/// @description the number of entries in the stack

@property (strong, nonatomic) NSDictionary *variables;
/// @description a mapping of values to varible names

-(id)mutableCopy;
/// @description Returns a new object that is a copy of the stack.

-(id)init;
/// @description Initializes an empty stack. Designated initializer.

-(id)initWithStack:(CalculatorStack *)stack;
/// @description Initializes the object as a copy of stack.

-(void)pushOperand:(double)operand;
/// @description Pushes an operand onto the stack.

-(void)pushExpression:(id<StackExpression>)object;
/// @description Pushes an expression onto the stack.

-(id<StackExpression>)popExpression;
/// @description Removes the topmost expression from the stack and returns it.

-(void)removeAllObjects;
/// @description Removes all objects from the stack.

@end
