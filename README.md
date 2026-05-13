# Podróżniczy System Ekspertowy

System ekspertowy w Prologu wspomagający wybór destynacji podróżniczej na podstawie preferencji użytkownika.

## Uruchomienie

```bash
swipl -q -s src/main.pl
```

## Zmiany

- Pytania o budzet, klimat, dlugosc wyjazdu i poziom aktywnosci uzywaja teraz wartosci rozmytych.
- System pokazuje rowniez redukty, czyli minimalne zbiory odpowiedzi zachowujace najlepsza rekomendacje.

## Redukty i Logika Rozmyta

System implementuje:

1. **Pełną kalkulację bez przybliżenia** (`show_recommendations`) — ocena wszystkich 10 miast na podstawie dokładnych tablic podobieństwa rozmytego.
2. **Redukty dokładne** (`show_reducts`) — minimalne zbiory atrybutów zachowujące tę samą najlepszą rekomendację i dokładnie taki sam wynik.
3. **Redukty agresywne** (`show_reducts_tolerant_aggressive`) — minimalne zbiory atrybutów, dla których najlepsze miasto może spaść maksymalnie o 25 punktów. Pokazuje "co najmniej niezbędne atrybuty" dla praktycznego wnioskowania.

## Przykłady

Poniżej scenariusze wraz z uruchomieniami bezpośrednio z terminala (bez interaktywnych pytań).

### Scenariusz 1 — Plaża (czarter rozmyty)

Preferencje: plaża, budżet średni, ciepło, samolot, tydzień, para, aktywność średnia.

```powershell
swipl -q -s src/main.pl -g 'retractall(answer(_, _)), assertz(answer(typ_wypoczynku,plazowy)), assertz(answer(budzet,sredni)), assertz(answer(klimat,cieply)), assertz(answer(srodek_transportu,samolot)), assertz(answer(dlugosc_wyjazdu,tydzien)), assertz(answer(towarzystwo,para)), assertz(answer(poziom_aktywnosci,sredni)), show_recommendations, show_reducts_tolerant_aggressive, show_used_attributes, halt.'
```

**Oczekiwany wynik:**
- **Pełna kalkulacja:** Barcelona na czele (~114 pkt).
- **Redukty agresywne:** 6 pojedynczych atrybutów — Barcelona może spaść do ~89 pkt, ale pozostaje liderem.

*Interpretacja:* Każdy z 7 atrybutów samodzielnie chroni główną rekomendację; pokazuje równomierny rozkład ważności.

---

### Scenariusz 2 — Miasto na weekend (efektywny)

Preferencje: miasto, budżet niski, klimat umiarkowany, pociąg, weekend, para, aktywność niska.

```powershell
swipl -q -s src/main.pl -g 'retractall(answer(_, _)), assertz(answer(typ_wypoczynku,miejski)), assertz(answer(budzet,niski)), assertz(answer(klimat,umiarkowany)), assertz(answer(srodek_transportu,pociag)), assertz(answer(dlugosc_wyjazdu,weekend)), assertz(answer(towarzystwo,para)), assertz(answer(poziom_aktywnosci,niski)), show_recommendations, show_reducts_tolerant_aggressive, show_used_attributes, halt.'
```

**Oczekiwany wynik:**
- **Pełna kalkulacja:** Praga (~127 pkt), Budapeszt (~115 pkt).
- **Redukty agresywne:** Kilka reduktów — Praga może spaść do ~102 pkt, ale wciąż wygrywa. Pokazuje, które kombinacje atrybutów są wystarczające.

*Interpretacja:* Nie wszystkie atrybuty są niezbędne; dla tej preferencji można osiągnąć cel z mniejszym zestawem (np. sam typ miasta lub kombinacja weekend+para).

---

### Scenariusz 3 — Aktywnie górsko (rodzina)

Preferencje: aktywny, budżet średni, klimat umiarkowany, samochód, kilka dni, rodzina, aktywność wysoka.

```powershell
swipl -q -s src/main.pl -g 'retractall(answer(_, _)), assertz(answer(typ_wypoczynku,aktywny)), assertz(answer(budzet,sredni)), assertz(answer(klimat,umiarkowany)), assertz(answer(srodek_transportu,samochod)), assertz(answer(dlugosc_wyjazdu,kilka_dni)), assertz(answer(towarzystwo,rodzina)), assertz(answer(poziom_aktywnosci,wysoki)), show_recommendations, show_reducts_tolerant_aggressive, show_used_attributes, halt.'
```

**Oczekiwany wynik:**
- **Pełna kalkulacja:** Zakopane (~116 pkt).
- **Redukty agresywne:** Kilka reduktów (potencjalnie z mniejszą liczbą atrybutów) — Zakopane może spaść o 25 pkt, ale pozostaje liderem. Pokazuje, które atrybuty są kluczowe.

*Interpretacja:* Struktura preferencji pozwala na redukcję — niektóre kombinacje atrybutów są bardziej efektywne niż inne dla tej preferencji górskiej.

---

### Scenariusz 4 — Luksusowa para na plaży (maksymalna redukcja)

Preferencje: plaża, para, budżet wysoki (bez klimatu, transportu, czasu ani aktywności).

```powershell
swipl -q -s src/main.pl -g 'retractall(answer(_, _)), assertz(answer(typ_wypoczynku,plazowy)), assertz(answer(towarzystwo,para)), assertz(answer(budzet,wysoki)), show_recommendations, show_reducts_tolerant_aggressive, show_used_attributes, halt.'
```

**Oczekiwany wynik:**
- **Pełna kalkulacja:** Santorini (~45 pkt).
- **Redukty agresywne:** Zaledwie 2 redukty — jeden z 2 atrybutami, a drugi tylko typ plaży. Santorini pada maksymalnie o 25 pkt ale zwycięża.
- **Użyte atrybuty:** Tylko 3 atrybuty zamiast 7.

*Interpretacja:* Minimalny zestaw preferencji już wystarczy. Pokazuje ekstremalny przykład redukcji — do tylko 1-2 atrybutów zamiast wszystkich 7, demonstrując potęgę inteligentnej selekcji cech dla wnioskowania.