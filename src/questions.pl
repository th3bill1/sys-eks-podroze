% =========================
% Pytania do użytkownika
% =========================

:- dynamic answer/2.

question(
    typ_wypoczynku,
    'Jaki typ wypoczynku preferujesz?',
    [plazowy, miejski, gorski, aktywny, kulturowy, relaksacyjny]
).

question(
    budzet,
    'Jaki masz budzet?',
    [niski, sredni, wysoki]
).

question(
    klimat,
    'Jaki klimat preferujesz?',
    [cieply, umiarkowany, chlodny]
).

question(
    srodek_transportu,
    'Jaki srodek transportu preferujesz?',
    [samolot, samochod, pociag, dowolny]
).

question(
    dlugosc_wyjazdu,
    'Jak dlugi ma byc wyjazd?',
    [weekend, kilka_dni, tydzien, dlugi_pobyt]
).

question(
    towarzystwo,
    'Z kim podrozujesz?',
    [solo, para, rodzina, znajomi]
).

question(
    poziom_aktywnosci,
    'Jaki poziom aktywnosci preferujesz?',
    [niski, sredni, wysoki]
).

start_consultation :-
    retractall(answer(_, _)),
    nl,
    write('=== System ekspertowy wyboru destynacji podrozniczej ==='), nl,
    write('Odpowiadaj wpisujac jedna z dostepnych opcji.'), nl,
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