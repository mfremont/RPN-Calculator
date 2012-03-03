The Calculator project is a simple RPN calculator for iOS based on the
assignments for Prof. Paul Hegarty's iTunesU course, "CS193P: iPad and
iPhone App Development (Fall 2011)."

Assignment #2 required making the calculator "programmable": the stack
should be treated as a "program" and pressing an operator button
evaluates the program and updates the display without consuming the
stack. This assignment also required adding initial support for
variables. Variables can be pushed onto the stack as placeholders with
the values to be supplied when the stack is evaluated. At this stage,
there is no way to set the variable values in the UI, but the test buttons
provide a way to switch between different variable dictionaries.

These features, along with the desire to better encapsulate the
semantics of each operator, led me to explore an implementation that
applies the Command pattern [GoF]. Commands are represented by classes
which adopt the StackExpression protocol for evaluation and rendering
themselves as a displayable string. At this point in the course,
protocols had been mentioned in passing but the concept had not been
discussed in any detail.
