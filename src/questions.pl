% =========================
% Pytania do użytkownika
% =========================

:- use_module(library(readutil)).

:- dynamic answer/2.

question(
    typ_wypoczynku,
    'Jaki typ wypoczynku preferujesz?',
    [plazowy, miejski, gorski, aktywny, kulturowy, relaksacyjny]
).

question(
    budzet,
    'Jaki masz budzet?',
    [bardzo_niski, niski, sredni, wysoki, bardzo_wysoki]
).

question(
    klimat,
    'Jaki klimat preferujesz?',
    [bardzo_cieply, cieply, umiarkowany, chlodny, bardzo_chlodny]
).

question(
    srodek_transportu,
    'Jaki srodek transportu preferujesz?',
    [samolot, samochod, pociag, dowolny]
).

question(
    dlugosc_wyjazdu,
    'Jak dlugi ma byc wyjazd?',
    [krotki, weekend, kilka_dni, tydzien, dlugi_pobyt]
).

question(
    towarzystwo,
    'Z kim podrozujesz?',
    [solo, para, rodzina, znajomi]
).

question(
    poziom_aktywnosci,
    'Jaki poziom aktywnosci preferujesz?',
    [bardzo_niski, niski, sredni, wysoki, bardzo_wysoki]
).

start_consultation :-
    retractall(answer(_, _)),
    nl,
    write('=== System ekspertowy wyboru destynacji podrozniczej ==='), nl,
    write('Odpowiadaj wpisujac jedna z dostepnych opcji.'), nl,
    write('Budzet, klimat, dlugosc wyjazdu i aktywnosc maja teraz opcje rozmyte.'), nl,
    nl,
    ask_all_questions.

ask_all_questions :-
    forall(
        question(Attribute, Text, Options),
        ask_question(Attribute, Text, Options)
    ).

ask_question(Attribute, Text, Options) :-
    write(Text), nl,
    write('Opcje: '), write(Options), nl,
    write('> '),
    read_line_to_string(user_input, Input),
    normalize_input(Input, Answer),
    (
        member(Answer, Options)
        ->
        assertz(answer(Attribute, Answer)),
        nl
        ;
        write('Niepoprawna odpowiedz. Sprobuj ponownie.'), nl, nl,
        ask_question(Attribute, Text, Options)
    ).

normalize_input(Input, Atom) :-
    string_lower(Input, Lower),
    normalize_space(string(Clean), Lower),
    atom_string(Atom, Clean).