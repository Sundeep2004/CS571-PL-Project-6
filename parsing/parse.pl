%%%%%%%%%%%%%%%%%
% Your code here:
%%%%%%%%%%%%%%%%%

% parse(+Tokens)
% True iff Tokens is a valid Lines and no tokens remain.
parse(Tokens) :-
    lines(Tokens, []).
lines(In, Out) :-line(In, Rest1),colon(Rest1, Rest2),lines(Rest2, Out).
lines(In, Out) :- line(In, Out).
line(In, Out) :- num(In, Rest1),comma(Rest1, Rest2),line(Rest2, Out).
line(In, Out) :- num(In, Out).
num(In, Out) :- digit(In, Rest1),num(Rest1, Out).
num(In, Out) :- digit(In, Out).
digit([X | R],R) :-
    X='0';
    X='1';
    X='2';
    X='3';
    X='4';
    X='5';
    X='6';
    X='7';
    X='8';
    X='9'.
colon([';'|Rest], Rest).
comma([','|Rest], Rest).

% Example execution:
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2']).
% true.
% ?- parse(['3', '2', ',', '0', ';', '1', ',', '5', '6', '7', ';', '2', ',']).
% false.
% ?- parse(['3', '2', ',', ';', '0']).
% false.