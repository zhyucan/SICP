;; the three ways of controlling complex

;; 1st topic -- black-box abstraction

#|
computer science ;; wrong name

how to formalize intuitions about process

the thing that directs a process is 
a pattern of rules called a procedure

precedure control processes

there are techniques for controlling the complexity 
of these large systems

black-box abstraction
suppress detail

method for finding a fixed point of a function f
that is, a value x such that f(Y) = Y

- start with a guess for Y
- keep applying f over and over until the result
  doesn't change very much

for example
to compute √x, find a fixed point of the function
Y --> average of Y and x/Y

define a box that says "fixed point" using my language

one way to compute square root is to apply this general
fixed point method

f(y) = (y + x/y)/2 -> fixed point black-box -> square function

proceduce -> proceduce

black-box abstraction

- primitive objects
    primitive procedures
    primitive data

- means of combination
    procedure composition
    construction of compound data

- means of abstraction
    procedure definition
    simple data abstraction

- capturing common patterns
    high-order procedures
    data as procedures
|#


;; 2nd topic -- conventional interfaces

#|
conventional interfaces
- generic operations
- large-scale structure and modularity
- object-oriented programming
- operations on aggregates, called streams


;; 3rd topic -- making new language

we're going to express in Lisp the process of
interpretiong Lisp itself

the precess of interpreting Lisp is sort of a giant wheel
of two processes, apply and eval, which sort of constantly
reduce repressions to each other

Meta-linguistic Abstraction -- construct new language
- interpretation apply-eval
- example - logic programming
- register machines
|#