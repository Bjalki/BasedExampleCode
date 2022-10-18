# Based Documentation:

## program --> {register | expression}*

## register --> ::{label}?, expression
* *saves evaluated expression at the current register index/label*

## expression --> label | literal | block | access | conditional | assignment | function | eval | iterator | built-in function | derived expression

## label --> identifier
* *label evaluates to the location of that label (env-layer, index)*
* *identifier is basically the same as mini-scheme with some minor changes to accommodate our syntax*

## literal
* *basic literals like ints, bools, and strings (bools are #t #f)*

## block --> {run "{" run box {, run box}* "}"} | {store "{" store box {, store box}* "}"}
* *creates local environment*
* *evaluates boxes within {}, notation is different based on whether it is a run or store block*
* *returns its env as its evaluation

## run box --> {expression | {label}?::expression}
* *:: indicates store like with registers*

## store box --> {!!expression!! | {label::}?expression}
* *!! !! indicates do not store evaluation*

## access --> [{expression | expression, expression}]{access}?
* *if one exp: 
  * *if exp evaluates to a int index, gets val at loc(current env layer, index)*
  * *if exp evaluates to a location (e.g. from a label evaluation) gets the value at that location*
* *if two exps: both should eval to int, and gets value at loc(int1, int2)*
* *optional recursive access only works if first access evaluates to a saved env (from block), then performs an access from that location*

## conditional --> "(" expression ? expression : expression ")"
* *structured like ternary operator*

## assignment --> "(" expression --> expression ")"
* *first expression is the new value which is put in the location evaluated from the second expression (the second expression should eval to a location)*

## function --> "("{label}?{,label}*")" => expression
* *built like a lambda function*

## eval --> expression"("{expression}?{,expression}*")"
* *the first expression should evaluate to a function object. the number of inner expressions should match the number of params in the function. this should evaluate the function object.*

## iterator --> "|"{expression | "("expression, expression")"} : function "|"
* *if one exp:*
  * *if expression evaluates to an integer, maps function on arraylist from 1 to n inclusive*
  * *if expression evaluates to an environment, maps function on that environment's arraylist*
  * *if expression evalutes to a boolean, saves the original expression, and performs the function given until the expression evaluates to #f (while loop)*
* if two exps:*
   * *both should evaluate to integers, maps function on arraylist from n to m inclusive*

## built-in function --> read() | write(expression) | add(expression, expression, expression) | set(expression, expression, expression) | remove(expression, expression) | contains(expression, expression) | swap(expression, expression, expression) | indexof(expression, expression)
* *except for read and write, all the others mimic Java ArrayList functions (except that the first exp is the targeted env list for the function)*
* *we thought these should be built in since our language is largely based in storing our values in nested ArrayLists*

## derived expressions
* *these are basically the same as the scheme derived expressions, except for read and write, and operators are ordered (exp + exp) (exp < exp) etc.*
