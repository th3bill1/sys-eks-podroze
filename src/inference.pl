% =========================
% Mechanizm wnioskowania
% =========================

recommendation(Destination, Score, Reasons) :-
    destination(Destination),
    findall(
        Points-Reason,
        preference_point(Destination, Points, Reason),
        Matches
    ),
    Matches \= [],
    sum_points(Matches, Score),
    extract_reasons(Matches, Reasons).

sum_points([], 0).
sum_points([Points-_|Rest], Sum) :-
    sum_points(Rest, RestSum),
    Sum is Points + RestSum.

extract_reasons([], []).
extract_reasons([_-Reason|Rest], [Reason|Reasons]) :-
    extract_reasons(Rest, Reasons).

all_recommendations(Sorted) :-
    findall(
        Score-Destination-Reasons,
        recommendation(Destination, Score, Reasons),
        Recommendations
    ),
    predsort(compare_recommendations, Recommendations, Sorted).

% Compute recommendation only for a given destination using current answers.
recommendation_for_destination(Destination, Score, Reasons) :-
    destination(Destination),
    findall(Points-Reason, preference_point(Destination, Points, Reason), Matches),
    Matches \= [],
    sum_points(Matches, Score),
    extract_reasons(Matches, Reasons).

% Compute recommendations only for an explicit list of destinations.
recommendations_for_destinations(DestList, Sorted) :-
    findall(
        Score-Destination-Reasons,
        (
            member(Destination, DestList),
            recommendation_for_destination(Destination, Score, Reasons)
        ),
        Recommendations
    ),
    Recommendations \= [],
    predsort(compare_recommendations, Recommendations, Sorted).

compare_recommendations(Order, Score1-_-_, Score2-_-_) :-
    (
        Score1 > Score2 -> Order = <
        ;
        Score1 < Score2 -> Order = >
        ;
        Order = =
    ).

best_recommendation(Destination, Score, Reasons) :-
    all_recommendations([Score-Destination-Reasons|_]).

show_recommendations :-
    all_recommendations(Recommendations),
    nl,
    write('=== Rekomendacje ==='), nl,
    show_recommendation_list(Recommendations, 1).

show_recommendation_list([], _).
show_recommendation_list([Score-Destination-Reasons|Rest], Index) :-
    write(Index),
    write('. '),
    write(Destination),
    write(' - dopasowanie: '),
    write(Score),
    write(' pkt'),
    nl,
    write('   Powody:'), nl,
    show_reasons(Reasons),
    nl,
    NextIndex is Index + 1,
    show_recommendation_list(Rest, NextIndex).

show_reasons([]).
show_reasons([Reason|Rest]) :-
    write('   - '),
    write(Reason),
    nl,
    show_reasons(Rest).