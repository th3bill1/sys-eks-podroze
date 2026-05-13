% =========================
% Reguly eksperckie
% =========================

% Reguly zwracaja punkty oraz powod rekomendacji.
% preference_point(Destination, Points, Reason).

fuzzy_points(MaxPoints, Degree, Points) :-
    PointsFloat is MaxPoints * Degree,
    Points is round(PointsFloat).

type_similarity(plazowy, D, 1.0) :-
    feature(D, ma_plaze).
type_similarity(plazowy, D, 0.7) :-
    feature(D, wysoka_temperatura_latem),
    \+ feature(D, ma_plaze).

type_similarity(miejski, D, 1.0) :-
    feature(D, dobra_komunikacja),
    feature(D, ma_zabytki).
type_similarity(miejski, D, 0.7) :-
    feature(D, dobra_komunikacja),
    \+ feature(D, ma_zabytki).
type_similarity(miejski, D, 0.7) :-
    feature(D, ma_zabytki),
    \+ feature(D, dobra_komunikacja).

type_similarity(gorski, D, 1.0) :-
    feature(D, ma_gory).
type_similarity(gorski, D, 0.7) :-
    feature(D, natura),
    \+ feature(D, ma_gory).

type_similarity(aktywny, D, 1.0) :-
    feature(D, aktywny_wypoczynek).
type_similarity(aktywny, D, 0.7) :-
    feature(D, ma_gory),
    \+ feature(D, aktywny_wypoczynek).
type_similarity(aktywny, D, 0.5) :-
    feature(D, natura),
    \+ feature(D, aktywny_wypoczynek),
    \+ feature(D, ma_gory).

type_similarity(kulturowy, D, 1.0) :-
    feature(D, kultura).
type_similarity(kulturowy, D, 0.8) :-
    feature(D, ma_zabytki),
    \+ feature(D, kultura).

type_similarity(relaksacyjny, D, 1.0) :-
    feature(D, ma_plaze).
type_similarity(relaksacyjny, D, 1.0) :-
    feature(D, natura),
    \+ feature(D, ma_plaze).
type_similarity(relaksacyjny, D, 0.7) :-
    feature(D, bezpieczny),
    \+ feature(D, ma_plaze),
    \+ feature(D, natura).

budget_similarity(bardzo_niski, niski, 1.0).
budget_similarity(bardzo_niski, sredni, 0.6).
budget_similarity(bardzo_niski, wysoki, 0.1).
budget_similarity(niski, niski, 1.0).
budget_similarity(niski, sredni, 0.75).
budget_similarity(niski, wysoki, 0.2).
budget_similarity(sredni, niski, 0.4).
budget_similarity(sredni, sredni, 1.0).
budget_similarity(sredni, wysoki, 0.45).
budget_similarity(wysoki, niski, 0.1).
budget_similarity(wysoki, sredni, 0.65).
budget_similarity(wysoki, wysoki, 1.0).
budget_similarity(bardzo_wysoki, sredni, 0.4).
budget_similarity(bardzo_wysoki, wysoki, 1.0).

climate_similarity(bardzo_cieply, cieply, 1.0).
climate_similarity(bardzo_cieply, umiarkowany, 0.6).
climate_similarity(bardzo_cieply, chlodny, 0.1).
climate_similarity(cieply, cieply, 1.0).
climate_similarity(cieply, umiarkowany, 0.7).
climate_similarity(cieply, chlodny, 0.2).
climate_similarity(umiarkowany, cieply, 0.6).
climate_similarity(umiarkowany, umiarkowany, 1.0).
climate_similarity(umiarkowany, chlodny, 0.6).
climate_similarity(chlodny, cieply, 0.1).
climate_similarity(chlodny, umiarkowany, 0.7).
climate_similarity(chlodny, chlodny, 1.0).
climate_similarity(bardzo_chlodny, cieply, 0.1).
climate_similarity(bardzo_chlodny, umiarkowany, 0.5).
climate_similarity(bardzo_chlodny, chlodny, 1.0).

length_similarity(krotki, weekend, 1.0).
length_similarity(krotki, kilka_dni, 0.6).
length_similarity(krotki, tydzien, 0.1).
length_similarity(weekend, weekend, 1.0).
length_similarity(weekend, kilka_dni, 0.8).
length_similarity(weekend, tydzien, 0.2).
length_similarity(kilka_dni, weekend, 0.7).
length_similarity(kilka_dni, kilka_dni, 1.0).
length_similarity(kilka_dni, tydzien, 0.7).
length_similarity(tydzien, kilka_dni, 0.6).
length_similarity(tydzien, tydzien, 1.0).
length_similarity(tydzien, dlugi_pobyt, 0.7).
length_similarity(dlugi_pobyt, tydzien, 0.6).
length_similarity(dlugi_pobyt, dlugi_pobyt, 1.0).

activity_similarity(bardzo_niski, niski, 1.0).
activity_similarity(bardzo_niski, sredni, 0.5).
activity_similarity(bardzo_niski, wysoki, 0.1).
activity_similarity(niski, niski, 1.0).
activity_similarity(niski, sredni, 0.75).
activity_similarity(niski, wysoki, 0.2).
activity_similarity(sredni, niski, 0.4).
activity_similarity(sredni, sredni, 1.0).
activity_similarity(sredni, wysoki, 0.5).
activity_similarity(wysoki, niski, 0.1).
activity_similarity(wysoki, sredni, 0.6).
activity_similarity(wysoki, wysoki, 1.0).
activity_similarity(bardzo_wysoki, sredni, 0.4).
activity_similarity(bardzo_wysoki, wysoki, 1.0).

preference_point(D, Points, 'pasuje do wypoczynku plazowego') :-
    answer(typ_wypoczynku, plazowy),
    type_similarity(plazowy, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do wypoczynku miejskiego') :-
    answer(typ_wypoczynku, miejski),
    type_similarity(miejski, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do wypoczynku gorskiego') :-
    answer(typ_wypoczynku, gorski),
    type_similarity(gorski, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do wypoczynku aktywnego') :-
    answer(typ_wypoczynku, aktywny),
    type_similarity(aktywny, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do wypoczynku kulturowego') :-
    answer(typ_wypoczynku, kulturowy),
    type_similarity(kulturowy, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do relaksacyjnego stylu wyjazdu') :-
    answer(typ_wypoczynku, relaksacyjny),
    type_similarity(relaksacyjny, D, Degree),
    fuzzy_points(20, Degree, Points).

preference_point(D, Points, 'pasuje do wybranego budzetu') :-
    answer(budzet, B),
    cost(D, Cost),
    budget_similarity(B, Cost, Degree),
    fuzzy_points(15, Degree, Points).

preference_point(D, Points, 'pasuje do preferowanego klimatu') :-
    answer(klimat, K),
    climate(D, Climate),
    climate_similarity(K, Climate, Degree),
    fuzzy_points(15, Degree, Points).

preference_point(D, Points, 'pasuje do dlugosci wyjazdu') :-
    answer(dlugosc_wyjazdu, L),
    good_length(D, Length),
    length_similarity(L, Length, Degree),
    fuzzy_points(15, Degree, Points).

preference_point(D, 10, 'pasuje do preferowanego transportu') :-
    answer(srodek_transportu, T),
    T \= dowolny,
    transport_ok(D, T).

preference_point(D, 10, 'transport dowolny - destynacja pozostaje mozliwa') :-
    answer(srodek_transportu, dowolny),
    destination(D).

preference_point(D, 10, 'pasuje do typu towarzystwa') :-
    answer(towarzystwo, T),
    good_for(D, T).

preference_point(D, Points, 'pasuje do poziomu aktywnosci') :-
    answer(poziom_aktywnosci, A),
    activity_level(D, Activity),
    activity_similarity(A, Activity, Degree),
    fuzzy_points(10, Degree, Points).

% Reguly bardziej specjalistyczne

preference_point(D, 10, 'dobra opcja dla taniego wyjazdu') :-
    answer(budzet, niski),
    feature(D, tani).

preference_point(D, 10, 'dobra opcja na weekend') :-
    answer(dlugosc_wyjazdu, weekend),
    feature(D, dobry_na_weekend).

preference_point(D, 10, 'dobra opcja dla rodzin') :-
    answer(towarzystwo, rodzina),
    feature(D, odpowiedni_dla_rodzin).

preference_point(D, 10, 'bezpieczna opcja dla podrozy solo') :-
    answer(towarzystwo, solo),
    feature(D, bezpieczny).

preference_point(D, 10, 'ciepla destynacja z dobra pogoda latem') :-
    answer(klimat, cieply),
    feature(D, wysoka_temperatura_latem).