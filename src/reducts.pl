% =========================
% Modul reguly minimalnych / reduktow
% =========================

% Nadal udostepniamy liste uzytych atrybutow, ale dodatkowo liczmy
% minimalne redukty: najmniejsze zbiory odpowiedzi, ktore zachowuja
% aktualna najlepsza rekomendacje.

used_attributes(Attributes) :-
    findall(Attribute, answer(Attribute, _), RawAttributes),
    sort(RawAttributes, Attributes).

answered_answers(Answers) :-
    findall(answer(Attribute, Value), answer(Attribute, Value), Answers).

reducts(Reducts) :-
    answered_answers(Answers),
    best_recommendation(Destination, Score, _),
    findall(
        Reduct,
        minimal_reduct_for(Destination, Score, Answers, Reduct),
        RawReducts
    ),
    sort(RawReducts, Reducts),
    !.

reducts([]).

minimal_reduct_for(Destination, Score, Answers, Reduct) :-
    subset_of_answers(Reduct, Answers),
    Reduct \= [],
    with_answers(Reduct, best_recommendation(Destination, Score, _)),
    \+ (
        proper_subset_of_answers(ProperSubset, Reduct),
        ProperSubset \= [],
        with_answers(ProperSubset, best_recommendation(Destination, Score, _))
    ).

subset_of_answers([], _).
subset_of_answers([X|Xs], [X|Ys]) :-
    subset_of_answers(Xs, Ys).
subset_of_answers(Xs, [_|Ys]) :-
    subset_of_answers(Xs, Ys).

proper_subset_of_answers(Subset, Superset) :-
    subset_of_answers(Subset, Superset),
    Subset \= Superset.

with_answers(Answers, Goal) :-
    answered_answers(OriginalAnswers),
    setup_call_cleanup(
        (retractall(answer(_, _)), assert_answer_terms(Answers)),
        Goal,
        (retractall(answer(_, _)), assert_answer_terms(OriginalAnswers))
    ).

assert_answer_terms([]).
assert_answer_terms([answer(Attribute, Value)|Rest]) :-
    assertz(answer(Attribute, Value)),
    assert_answer_terms(Rest).

show_used_attributes :-
    used_attributes(Attributes),
    nl,
    write('=== Uzyte atrybuty ==='), nl,
    write(Attributes), nl.

show_reducts :-
    reducts(ReductList),
    nl,
    write('=== Redukty ==='), nl,
    show_reduct_list(ReductList, 1).

show_reduct_list([], _) :- !.
show_reduct_list([Reduct|Rest], Index) :-
    write(Index),
    write('. '),
    write(Reduct),
    nl,
    NextIndex is Index + 1,
    show_reduct_list(Rest, NextIndex).

show_reduct_recommendations :-
    reducts(ReductList),
    nl,
    write('=== Rekomendacje z wykorzystaniem reduktow ==='), nl,
    (   ReductList = []
    ->  write('Brak reduktow do analizy.'), nl
    ;   show_reduct_recommendations_list(ReductList, 1)
    ).

show_reduct_recommendations_list([], _).
show_reduct_recommendations_list([Reduct|Rest], Index) :-
    write('Redukt '), write(Index), write(': '), write(Reduct), nl,
    (   with_answers(Reduct, best_recommendation(Destination, Score, Reasons))
    ->  write('  Najlepsza rekomendacja przy tym redukcie: '), write(Destination), write(' - '), write(Score), write(' pkt'), nl,
        write('  Powody: '), write(Reasons), nl
    ;   write('  Brak rekomendacji przy tym redukcie.'), nl
    ),
    Next is Index + 1,
    show_reduct_recommendations_list(Rest, Next).

% Build a shortlist of candidate destinations by querying each reduct's
% best recommendation and collecting unique destinations.
shortlist_from_reducts(Shortlist) :-
    reducts(ReductList),
    findall(Dest,
        (
            member(R, ReductList),
            with_answers(R, ( best_recommendation(Dest, _, _) -> true ; fail ))
        ),
        Dests),
    sort(Dests, Shortlist).

% Tolerant reducts: accept a reduct if applying it yields the same best
% recommendation or the best score drops by at most MaxDrop points.
reducts_tolerant(MaxDrop, Reducts) :-
    answered_answers(Answers),
    best_recommendation(BestDest, BestScore, _),
    findall(
        Reduct,
        minimal_reduct_tolerant_for(BestDest, BestScore, MaxDrop, Answers, Reduct),
        RawReducts
    ),
    sort(RawReducts, Reducts),
    !.

reducts_tolerant(_, []).

minimal_reduct_tolerant_for(BestDest, BestScore, MaxDrop, Answers, Reduct) :-
    subset_of_answers(Reduct, Answers),
    Reduct \= [],
    with_answers(Reduct, best_recommendation(SubDest, SubScore, _)),
    (
        SubDest == BestDest
        ;
        (number(SubScore), number(BestScore), SubScore >= BestScore - MaxDrop)
    ),
    \+ (
        proper_subset_of_answers(ProperSubset, Reduct),
        ProperSubset \= [],
        with_answers(ProperSubset, best_recommendation(PSDest, PSScore, _)),
        (
            PSDest == BestDest
            ;
            (number(PSScore), number(BestScore), PSScore >= BestScore - MaxDrop)
        )
    ).

show_reducts_tolerant(MaxDrop) :-
    reducts_tolerant(MaxDrop, Reducts),
    nl,
    write('=== Redukty (tolerancja spadku punktow = '), write(MaxDrop), write(') ==='), nl,
    ( Reducts = [] -> write('Brak reduktow spełniających kryterium.'), nl
    ; show_reduct_list(Reducts, 1)
    ).

% Aggressive tolerant display (25 points tolerance) to demonstrate strong reduction.
show_reducts_tolerant_aggressive :-
    show_reducts_tolerant(25).