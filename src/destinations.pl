% =========================
% Baza destynacji i ich cech
% =========================

destination(barcelona).
destination(paryz).
destination(rzym).
destination(zakopane).
destination(praga).
destination(lizbona).
destination(wieden).
destination(budapeszt).
destination(madeira).
destination(oslo).

% Kraj

country(barcelona, hiszpania).
country(paryz, francja).
country(rzym, wlochy).
country(zakopane, polska).
country(praga, czechy).
country(lizbona, portugalia).
country(wieden, austria).
country(budapeszt, wegry).
country(madeira, portugalia).
country(oslo, norwegia).

% Cechy ogólne

feature(barcelona, ma_plaze).
feature(barcelona, ma_zabytki).
feature(barcelona, dobra_komunikacja).
feature(barcelona, wysoka_temperatura_latem).
feature(barcelona, rozrywka).

feature(paryz, ma_zabytki).
feature(paryz, dobra_komunikacja).
feature(paryz, kultura).
feature(paryz, romantyczny).

feature(rzym, ma_zabytki).
feature(rzym, kultura).
feature(rzym, wysoka_temperatura_latem).
feature(rzym, dobra_komunikacja).

feature(zakopane, ma_gory).
feature(zakopane, aktywny_wypoczynek).
feature(zakopane, dobry_na_weekend).
feature(zakopane, odpowiedni_dla_rodzin).

feature(praga, ma_zabytki).
feature(praga, dobra_komunikacja).
feature(praga, dobry_na_weekend).
feature(praga, tani).

feature(lizbona, ma_plaze).
feature(lizbona, ma_zabytki).
feature(lizbona, wysoka_temperatura_latem).
feature(lizbona, dobra_komunikacja).

feature(wieden, ma_zabytki).
feature(wieden, kultura).
feature(wieden, dobra_komunikacja).
feature(wieden, bezpieczny).

feature(budapeszt, ma_zabytki).
feature(budapeszt, tani).
feature(budapeszt, dobry_na_weekend).
feature(budapeszt, dobra_komunikacja).

feature(madeira, natura).
feature(madeira, aktywny_wypoczynek).
feature(madeira, wysoka_temperatura_latem).
feature(madeira, ma_gory).

feature(oslo, natura).
feature(oslo, bezpieczny).
feature(oslo, dobra_komunikacja).
feature(oslo, chlodny_klimat).

% Koszt

cost(barcelona, sredni).
cost(paryz, wysoki).
cost(rzym, sredni).
cost(zakopane, sredni).
cost(praga, niski).
cost(lizbona, sredni).
cost(wieden, wysoki).
cost(budapeszt, niski).
cost(madeira, sredni).
cost(oslo, wysoki).

% Klimat

climate(barcelona, cieply).
climate(paryz, umiarkowany).
climate(rzym, cieply).
climate(zakopane, umiarkowany).
climate(praga, umiarkowany).
climate(lizbona, cieply).
climate(wieden, umiarkowany).
climate(budapeszt, umiarkowany).
climate(madeira, cieply).
climate(oslo, chlodny).

% Długość wyjazdu

good_length(barcelona, kilka_dni).
good_length(barcelona, tydzien).

good_length(paryz, weekend).
good_length(paryz, kilka_dni).

good_length(rzym, kilka_dni).
good_length(rzym, tydzien).

good_length(zakopane, weekend).
good_length(zakopane, kilka_dni).

good_length(praga, weekend).
good_length(praga, kilka_dni).

good_length(lizbona, kilka_dni).
good_length(lizbona, tydzien).

good_length(wieden, weekend).
good_length(wieden, kilka_dni).

good_length(budapeszt, weekend).
good_length(budapeszt, kilka_dni).

good_length(madeira, tydzien).
good_length(madeira, dlugi_pobyt).

good_length(oslo, kilka_dni).

% Transport

transport_ok(barcelona, samolot).
transport_ok(paryz, samolot).
transport_ok(paryz, pociag).
transport_ok(rzym, samolot).
transport_ok(zakopane, samochod).
transport_ok(zakopane, pociag).
transport_ok(praga, samochod).
transport_ok(praga, pociag).
transport_ok(lizbona, samolot).
transport_ok(wieden, pociag).
transport_ok(wieden, samochod).
transport_ok(budapeszt, pociag).
transport_ok(budapeszt, samochod).
transport_ok(madeira, samolot).
transport_ok(oslo, samolot).

% Towarzystwo

good_for(barcelona, znajomi).
good_for(barcelona, para).

good_for(paryz, para).
good_for(paryz, solo).

good_for(rzym, para).
good_for(rzym, rodzina).

good_for(zakopane, rodzina).
good_for(zakopane, znajomi).

good_for(praga, znajomi).
good_for(praga, para).
good_for(praga, solo).

good_for(lizbona, para).
good_for(lizbona, znajomi).

good_for(wieden, rodzina).
good_for(wieden, para).
good_for(wieden, solo).

good_for(budapeszt, znajomi).
good_for(budapeszt, solo).

good_for(madeira, para).
good_for(madeira, znajomi).

good_for(oslo, solo).
good_for(oslo, para).

% Aktywność

activity_level(barcelona, sredni).
activity_level(paryz, sredni).
activity_level(rzym, sredni).
activity_level(zakopane, wysoki).
activity_level(praga, niski).
activity_level(lizbona, sredni).
activity_level(wieden, niski).
activity_level(budapeszt, sredni).
activity_level(madeira, wysoki).
activity_level(oslo, sredni).