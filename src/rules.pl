% =========================
% Reguly eksperckie
% =========================

% Reguly zwracaja punkty oraz powod rekomendacji.
% preference_point(Destination, Points, Reason).

preference_point(D, 20, 'pasuje do wypoczynku plazowego') :-
    answer(typ_wypoczynku, plazowy),
    feature(D, ma_plaze).

preference_point(D, 20, 'pasuje do wypoczynku miejskiego') :-
    answer(typ_wypoczynku, miejski),
    feature(D, dobra_komunikacja),
    feature(D, ma_zabytki).

preference_point(D, 20, 'pasuje do wypoczynku gorskiego') :-
    answer(typ_wypoczynku, gorski),
    feature(D, ma_gory).

preference_point(D, 20, 'pasuje do wypoczynku aktywnego') :-
    answer(typ_wypoczynku, aktywny),
    feature(D, aktywny_wypoczynek).

preference_point(D, 20, 'pasuje do wypoczynku kulturowego') :-
    answer(typ_wypoczynku, kulturowy),
    feature(D, kultura).

preference_point(D, 15, 'pasuje do wybranego budzetu') :-
    answer(budzet, B),
    cost(D, B).

preference_point(D, 15, 'pasuje do preferowanego klimatu') :-
    answer(klimat, K),
    climate(D, K).

preference_point(D, 15, 'pasuje do dlugosci wyjazdu') :-
    answer(dlugosc_wyjazdu, L),
    good_length(D, L).

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

preference_point(D, 10, 'pasuje do poziomu aktywnosci') :-
    answer(poziom_aktywnosci, A),
    activity_level(D, A).

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