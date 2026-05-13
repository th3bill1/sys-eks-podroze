% =========================
% Testy mechanizmu wnioskowania
% =========================

:- begin_tests(travel_expert_system).

:- ensure_loaded('../src/destinations.pl').
:- ensure_loaded('../src/questions.pl').
:- ensure_loaded('../src/rules.pl').
:- ensure_loaded('../src/inference.pl').
:- ensure_loaded('../src/reducts.pl').

test(beach_recommendation_exists) :-
    retractall(answer(_, _)),
    assertz(answer(typ_wypoczynku, plazowy)),
    assertz(answer(budzet, sredni)),
    assertz(answer(klimat, cieply)),
    assertz(answer(srodek_transportu, samolot)),
    assertz(answer(dlugosc_wyjazdu, tydzien)),
    assertz(answer(towarzystwo, para)),
    assertz(answer(poziom_aktywnosci, sredni)),
    all_recommendations(Recommendations),
    Recommendations \= [].

test(barcelona_should_score_for_beach_trip) :-
    retractall(answer(_, _)),
    assertz(answer(typ_wypoczynku, plazowy)),
    assertz(answer(budzet, sredni)),
    assertz(answer(klimat, cieply)),
    assertz(answer(srodek_transportu, samolot)),
    assertz(answer(dlugosc_wyjazdu, tydzien)),
    assertz(answer(towarzystwo, para)),
    assertz(answer(poziom_aktywnosci, sredni)),
    recommendation(barcelona, Score, _),
    Score > 0.

test(fuzzy_climate_match_scores_partially) :-
    retractall(answer(_, _)),
    assertz(answer(klimat, cieply)),
    recommendation(praga, Score, _),
    Score =:= 11.

test(minimal_reducts_preserve_best_recommendation) :-
    retractall(answer(_, _)),
    once((
        Answers = [
            answer(typ_wypoczynku, plazowy),
            answer(budzet, sredni),
            answer(klimat, cieply),
            answer(srodek_transportu, samolot),
            answer(dlugosc_wyjazdu, tydzien),
            answer(towarzystwo, para),
            answer(poziom_aktywnosci, sredni)
        ],
        maplist(assert_answer, Answers),
        best_recommendation(Destination, Score, _),
        reducts(ReductList),
        ReductList \= [],
        once(member(Reduct, ReductList)),
        subset_of_answers(Reduct, Answers),
        once(with_answers(Reduct, best_recommendation(Destination, Score, _)))
    )).

test(used_attributes_are_detected) :-
    retractall(answer(_, _)),
    assertz(answer(typ_wypoczynku, miejski)),
    assertz(answer(budzet, niski)),
    used_attributes(Attributes),
    once((member(typ_wypoczynku, Attributes), member(budzet, Attributes))).

assert_answer(answer(Attribute, Value)) :-
    assertz(answer(Attribute, Value)).
% helper `subset_of_answers/2`, `with_answers/2` and
% `assert_answer_terms/1` are provided by src/reducts.pl
% to avoid duplicate definitions they are not repeated here.

:- end_tests(travel_expert_system).