:- module(puzzle).

:- comment(summary, "Various utilities for solving number puzzles.").
:- comment(status, "prototype").
:- comment(author, "Rob Menke <rmenke@gmail.com>").
:- comment(categories, ["Algorithms", "Constraints"]).

:- export expand_digits/2.

:- lib(ic).

:- comment(expand_digits/2, [
        summary: "Expand a number into its individual digits",
        index: ["Expand digits of an integer"],
        args: ["Number": "a domain variable or an integer",
               "Digits": "a list of domain variables or integers"],
        amode: (expand_digits(+, -) is det),
        amode: (expand_digits(-, ++) is det),
        amode: (expand_digits(?, ?) is nondet),
        resat: yes,
        desc:
            "   The Digits array will consist of integers or domain\n"
            "   variables in the range 0..9, except for the last\n"
            "   element which is in the domain 1..9.  The values in\n"
            "   the Digits are ordered least-significant digit first.",
        eg: "\
% The SEND + MORE = MONEY puzzle:
:- use_module(puzzle).
:- lib(ic).
?- expand_digits(SEND, [D,N,E,S]),
   expand_digits(MORE, [E,R,O,M]),
   expand_digits(MONEY, [Y,E,N,O,M]),
   SEND + MORE #= MONEY,
   alldifferent([D,N,E,S,R,O,M,Y]),
   search([D,N,E,S,R,O,M,Y], 0, most_constrained, indomain, complete, [])."
        ]).

:- mode expand_digits(?, ?).

expand_digits(N, [N]) :-
        N #:: 1..9.
expand_digits(N, [H,H2|T]) :-
        N #:: 10..inf, H #:: 0..9,
        N #= H + N2 * 10,
        expand_digits(N2, [H2|T]).

