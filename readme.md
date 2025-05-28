Generator haseł w Elixir
Projekt to konsolowa aplikacja napisana w języku Elixir, służąca do generowania haseł o różnym typie i konfiguracji. Aplikacja pozwala tworzyć hasła z losowych znaków lub losowych słów z możliwością dostosowania długości, wielkości liter, użycia cyfr, symboli oraz separatorów.

Szczegółowe omówienie implementacji
Struktura i moduły
Projekt podzielony jest na dwa główne moduły:

Password — odpowiedzialny za logikę generowania haseł

CLI — interfejs konsolowy, który umożliwia uruchomienie programu z różnymi opcjami

Moduł Password
Atrybuty modułu
Użyłem atrybutów modułu (@uppercase_letters, @lowercase_letters, itd.) do przechowywania zestawów znaków oraz listy słów, co pozwala łatwo i szybko wykorzystywać je podczas generowania.

Lista słów (@words) zawiera kilkadziesiąt przykładowych angielskich słów, które wykorzystywane są podczas generowania haseł typu words.

Funkcja generate/1
Przyjmuje opcjonalną listę opcji (keyword list), która jest konwertowana na mapę (Map) dla wygodniejszej obsługi.

Domyślne wartości opcji są zdefiniowane, np. typ hasła :chars, minimalna długość 8, maksymalna 16.

Funkcja wybiera sposób generowania na podstawie opcji type i wywołuje odpowiednią prywatną funkcję (generate_chars/1 lub generate_words/1).

W przypadku nieznanego typu zwraca błąd w formie tuple {:error, "Unknown type"}.

Funkcja generate_chars/1
Losuje długość hasła w zadanym zakresie (min_length..max_length) za pomocą Enum.random.

Buduje zestaw znaków (charset) w oparciu o opcje: małe litery są zawsze, duże litery, cyfry i symbole są dodawane jeśli odpowiednie flagi są ustawione.

Generuje hasło jako listę losowo wybranych znaków z charset (za pomocą Enum.map i Enum.random).

Konwertuje listę znaków na string przez to_string().

Funkcja generate_words/1
Losuje liczbę słów w haśle w zadanym zakresie.

Dla każdego słowa losuje je z listy @words.

Jeśli opcja uppercase jest aktywna, każde słowo jest kapitalizowane — pierwsza litera zmieniana na wielką.

Słowa łączone są separatorem podanym w opcjach (domyślnie "-").

Kapitalizacja realizowana jest przez capitalize/1, która używa String.split_at i String.upcase.

Moduł CLI
Parsowanie argumentów
Korzysta z modułu OptionParser do odczytu argumentów w formacie --option=wartość.

Definiuje listę przełączników (switches) odpowiadających opcjom generatora: typ, długości, flagi (uppercase, numbers, symbols), separator, a także opcjonalny plik (file).

Przekształca argumenty, np. konwertując typ z łańcucha znaków na atom, co ułatwia dalszą pracę w module Password.

Generowanie i wyjście
Wywołuje Password.generate/1 z przetworzonymi opcjami.

Jeżeli podano opcję --file, zapisuje wynik do pliku; w przeciwnym razie wypisuje wygenerowane hasło na konsolę.

W przypadku zapisu do pliku potwierdza sukces komunikatem na konsoli.

Proces tworzenia i testowania
Projektowanie i planowanie — na początku zastanowiłem się, jakie opcje powinien mieć generator, i rozbiłem problem na dwa tryby: generowanie znaków oraz słów.

Implementacja modułu Password — zacząłem od definicji zestawów znaków i słów oraz napisania funkcji generujących.

Testowanie funkcji w iex — korzystałem z interaktywnego środowiska Elixir, by sprawdzać czy generowanie działa poprawnie.

Dodanie modułu CLI — stworzyłem prosty interfejs do obsługi argumentów z linii komend, wykorzystując OptionParser.

Testy integracyjne — sprawdziłem działanie programu z różnymi zestawami argumentów, upewniając się, że poprawnie generuje hasła i zapisuje do pliku.

Refaktoryzacja i optymalizacja — poprawiłem czytelność kodu, dodałem obsługę błędów i uprościłem logikę kapitalizacji.

Podsumowanie
Projekt pozwolił mi praktycznie zastosować funkcje Elixir takie jak Enum, String, oraz makra do pracy z atomami.

Nauczyłem się, jak łatwo tworzyć moduły z prywatnymi funkcjami i jak obsługiwać argumenty w CLI.

Zrozumiałem znaczenie czytelnego kodu i jak ważne jest rozbicie problemu na mniejsze funkcjonalności.

Zyskałem doświadczenie w tworzeniu aplikacji konsolowych, które mogą być używane w praktycznych scenariuszach.