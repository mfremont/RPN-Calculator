//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Matthew Fremont on 1/30/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (nonatomic, readonly) id program;

-(void)clearAll;

-(void)removeLastItemFromProgram;

-(void)pushOperand:(double) operand;

-(void)pushOperator:(NSString *)operator;

-(void)pushVariable:(NSString *)name;

-(double)performOperation:(NSString *)operation;

+(NSString *)descriptionOfProgram:(id)program;

+(double)runProgram:(id)program;

+(double)runProgram:(id)program usingVariableValues:(NSDictionary*)variableValues;

+(NSSet *)variablesUsedInProgram:(id)program;

@end
