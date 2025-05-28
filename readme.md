Proces tworzenia i testowania
Podczas implementacji projektu skupiałem się na wyborze odpowiednich funkcji i technik, które umożliwią elastyczne i czytelne generowanie haseł.

Wybór Enum.random/1 do losowania długości haseł i do losowego wybierania znaków lub słów uznałem za naturalny i prosty sposób na wprowadzenie losowości.

Dla funkcji generujących hasła z liter wybrałem podejście składania zestawu znaków warunkowo na podstawie podanych opcji (uppercase, numbers, symbols), co zwiększa elastyczność generatora i ułatwia modyfikację.

W przypadku generowania haseł z losowych słów zdecydowałem się na kapitalizację pierwszej litery słowa, jeśli opcja uppercase jest aktywna — użyłem do tego funkcji String.split_at/2 oraz String.upcase/1, które dobrze nadają się do pracy na stringach w Elixir.

W module CLI użyłem OptionParser do wygodnego i idiomatycznego parsowania argumentów z linii komend — jest to standardowa i rekomendowana metoda w Elixir do tego celu.

Konwersję typu hasła z łańcucha znaków na atom (String.to_atom/1) zastosowałem, aby uprościć późniejszą logikę w module Password.

Decyzja o obsłudze zapisu do pliku przy pomocy File.write!/2 oraz potwierdzeniu operacji komunikatem na konsoli zwiększa funkcjonalność programu i jest prostym rozwiązaniem problemu wyjścia.

Testowałem poszczególne funkcje interaktywnie w iex, co pozwoliło szybko weryfikować poprawność generowania haseł. Następnie sprawdziłem integrację całego programu, testując różne kombinacje opcji i ich wpływ na wygenerowane hasło oraz obsługę zapisu do pliku.

Ostatecznie dokonałem refaktoryzacji kodu, poprawiając czytelność i spójność, a także uprościłem niektóre funkcje, aby kod był bardziej idiomatyczny i łatwiejszy w utrzymaniu.
