//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Matthew Fremont on 1/30/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "CalculatorBrain.h"
#import "CalculatorStack.h"
#import "StackArithmeticOperator.h"
#import "StackMathOperator.h"
#import "StackVariable.h"

#import <math.h>

@interface CalculatorBrain()
@property (nonatomic, strong) CalculatorStack *programStack;
@property (nonatomic, strong) NSMutableDictionary *operatorMap;

@end

@implementation CalculatorBrain

@synthesize programStack = _programStack;
@synthesize operatorMap = _operatorMap;

-(NSDictionary *)operatorMap {
    if (_operatorMap == nil) {
        _operatorMap = [[NSMutableDictionary alloc] init];
        // initialize with set of allowable operators
        [_operatorMap setValue:[[StackAdditionOperator alloc] init] forKey:@"+"];
        [_operatorMap setValue:[[StackSubtractionOperator alloc] init] forKey:@"-"];
        [_operatorMap setValue:[[StackMultiplicationOperator alloc] init] forKey:@"*"];
        [_operatorMap setValue:[[StackDivisionOperator alloc] init] forKey:@"/"];
        [_operatorMap setValue:[[SqrtOperator alloc] init] forKey:@"√"];
        [_operatorMap setValue:[[CosOperator alloc] init] forKey:@"cos"];
        [_operatorMap setValue:[[SinOperator alloc] init] forKey:@"sin"];
        [_operatorMap setValue:[[StackNumber alloc] initWithDouble:M_PI forSymbol:@"π"] forKey:@"π"];
    }
    return _operatorMap;
}

-(CalculatorStack *)programStack {
    if (_programStack == nil) {
        _programStack = [[CalculatorStack alloc] init];
    }
    return _programStack;
}

-(id)program {
    return [self.programStack mutableCopy];
}

-(void)clearAll {
    [self.programStack removeAllObjects];
}

-(void)removeLastItemFromProgram {
    // pop and discard last expression
    [self.programStack popExpression];
}

-(void)pushOperand:(double)operand {
    [self.programStack pushOperand:operand];
}

-(void)pushOperator:(NSString *)operation {
    id<StackExpression> operator = [self.operatorMap valueForKey:operation];
    if (operator != nil) [self.programStack pushExpression:operator];
}

-(void)pushVariable:(NSString *)name {
    [self.programStack pushExpression:[[StackVariable alloc] initWithName:name]];
}

-(double)performOperation:(NSString *)operation {
    [self pushOperator:operation];
    return [[self class] runProgram:self.program];
}

+(NSString *)descriptionOfProgram:(id)program {
    NSString *description = nil;
    if ([program isKindOfClass:[CalculatorStack class]]) {
        NSMutableArray *descriptionElem = [[NSMutableArray alloc] init];
        CalculatorStack *stack = program;
        id<StackExpression> expression;
        while ((expression = [stack popExpression]) != nil) {
            NSString *d = [expression descriptionUsingStack:stack];
            if (d != nil) [descriptionElem insertObject:d atIndex:0];
        }
        description = [descriptionElem componentsJoinedByString:@", "];
    }
    return description;
}
                                
+(double)runProgram:(id)program {
    return [self runProgram:program usingVariableValues:nil];
}

+(double)runProgram:(id)program usingVariableValues:(NSDictionary *)variableValues {
    double result = 0;
    if ([program isKindOfClass:[CalculatorStack class]]) {
        CalculatorStack *stack = program;
        stack.variables = variableValues;
        id<StackExpression> expression = [stack popExpression];
        result = [expression evaluateUsingStack:stack];
    }
    return result;
}

+(NSSet *)variablesUsedInProgram:(id)program {
    NSMutableSet *variablesUsed = nil;
    if ([program isKindOfClass:[CalculatorStack class]]) {
        CalculatorStack *stack = [program mutableCopy];
        variablesUsed = [[NSMutableSet alloc] init];
        id<StackExpression> topOfStack;
        while ((topOfStack = [stack popExpression]) != nil) {
            if ([topOfStack isKindOfClass:[StackVariable class]]) {
                [variablesUsed addObject:topOfStack.description];
            }
        }
    }
    return [variablesUsed copy];
}

@end
