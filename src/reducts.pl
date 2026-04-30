% =========================
% Modul reguly minimalnych / reduktow
% =========================

% Na tym etapie zapisujemy tylko, ktore atrybuty byly uzyte.
% Pozniej ten modul mozna rozwinac do znajdowania minimalnych zestawow przeslanek.

used_attributes(Attributes) :-
    findall(Attribute, answer(Attribute, _), RawAttributes),
    sort(RawAttributes, Attributes).

show_used_attributes :-
    used_attributes(Attributes),
    nl,
    write('=== Uzyte atrybuty ==='), nl,
    write(Attributes), nl.