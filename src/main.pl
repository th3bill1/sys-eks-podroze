% =========================
% main.pl
% =========================

:- ensure_loaded('destinations.pl').
:- ensure_loaded('questions.pl').
:- ensure_loaded('rules.pl').
:- ensure_loaded('inference.pl').
:- ensure_loaded('reducts.pl').

main :-
    start_consultation,
    show_recommendations,
    show_used_attributes,
    nl,
    write('Koniec konsultacji.'), nl.