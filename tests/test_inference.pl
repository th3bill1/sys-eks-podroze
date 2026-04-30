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

test(used_attributes_are_detected) :-
    retractall(answer(_, _)),
    assertz(answer(typ_wypoczynku, miejski)),
    assertz(answer(budzet, niski)),
    used_attributes(Attributes),
    member(typ_wypoczynku, Attributes),
    member(budzet, Attributes).

:- end_tests(travel_expert_system).