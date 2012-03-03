//
//  CalculatorStack.m
//  Calculator
//
//  Created by Matthew Fremont on 2/14/12.
//  Copyright (c) 2012 Matthew Fremont. All rights reserved.
//

#import "CalculatorStack.h"

@interface StackNumber ()

@property (nonatomic) double value;

@end

@implementation StackNumber

@synthesize value = _value;
@synthesize symbol = _symbol;

-(id)init {
    return [self initWithDouble:0.0];
}

-(id)initWithDouble:(double)value {
    return [self initWithDouble:value forSymbol:nil];
}

-(id)initWithDouble:(double)value forSymbol:(NSString *)symbol {
    self = [super init];
    if (self) {
        self.value = value;
        self->_symbol = symbol;
    }
    return self;
}

-(double)evaluateUsingStack:(CalculatorStack *)stack {
    return self.value;
}

-(NSString *)description {
    if (self.symbol != nil) {
        return self.symbol;
    } else {
        return [NSString stringWithFormat:@"%g", self.value];
    }
}

-(NSString *)descriptionUsingStack:(CalculatorStack *)stack {
    return [self description];
}

-(NSUInteger)numberOfOperands {
    return 0;
}
@end

@interface CalculatorStack ()

@property (strong, nonatomic) NSMutableArray *stack;

@end

@implementation CalculatorStack

@synthesize stack = _stack;
@synthesize variables = _variables;

-(NSMutableArray *)stack {
    if (_stack == nil) {
        _stack = [[NSMutableArray alloc] init];
    }
    return _stack;
}

-(NSDictionary *)variables {
    if (_variables == nil) {
        _variables = [[NSDictionary alloc] init];
    }
    return _variables;
}

-(NSUInteger)count {
    return [self.stack count];
}

-(id)mutableCopy {
    return [[[self class] alloc] initWithStack:self];
}

-(id)init {
    return [super init];
}

-(id)initWithStack:(CalculatorStack *)stack {
    self = [super init];
    if (self) {
        self->_stack = [stack.stack mutableCopy];
        self->_variables = stack.variables;
    }
    return self;
}

-(void)pushOperand:(double)operand {
    [self.stack addObject:[[StackNumber alloc] initWithDouble:operand]];
}

-(void)pushExpression:(id<StackExpression>)object {
    [self.stack addObject:object];
}

-(id<StackExpression>)popExpression {
    id<StackExpression> topOfStack = [self.stack lastObject];
    if (topOfStack != nil) {
        [self.stack removeLastObject];
    }
    return topOfStack;
}

-(void)removeAllObjects {
    [self.stack removeAllObjects];
}

@end
