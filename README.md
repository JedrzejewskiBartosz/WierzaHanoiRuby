# 🏗️ Animowana Wieża Hanoi w Ruby

## 📋 Opis

Ten projekt to wizualizacja i automatyczne rozwiązanie klasycznego problemu _Wieży Hanoi_ w terminalu, napisane w Ruby. Używa on klas `Board`, `Level` oraz `Stone`, by odwzorować strukturę wieży oraz przesuwać krążki zgodnie z zasadami gry.

---

## 🧠 Zasady Gry

- Tylko jeden krążek może być przenoszony naraz.
- Tylko mniejszy krążek może być położony na większym.
- Krążki są początkowo ułożone na pierwszym z trzech palików.
- Celem jest przeniesienie całej wieży na ostatni palik.

---

## ⚙️ Wymagania

- Ruby 2.5+
- Terminal z obsługą czyszczenia (`IO/console`)

---

## ▶️ Uruchomienie

Upewnij się, że pliki `level.rb`, `stone.rb`, oraz `board.rb` znajdują się w folderze `./data`.

```bash
ruby app.rb
```

---

## 📂 Struktura Klas

### `Board`

Główna klasa zarządzająca logiką gry i animacją.

**Atrybuty:**

- `levels` – poziomy wieży (lista obiektów `Level`)
- `width` – szerokość potrzebna do wizualizacji

**Najważniejsze metody:**

- `initialize(stones)` – tworzy planszę z zadaną liczbą krążków
- `show_board` – rysuje całą wieżę
- `move_stone(from, to)` – przenosi krążek między palikami (jeśli ruch jest legalny)
- `solve` – automatyczne rozwiązanie Wieży Hanoi z animacją

---

### `Level`

Reprezentuje poziom (rzęd) w strukturze wieży.

**Atrybuty:**

- `level` – lista krążków (obiektów `Stone`) na 3 palikach

**Najważniejsze metody:**

- `add_stone_to_level(pin, stone)` – umieszcza krążek na określonym paliku
- `get_stone_on_pin(pin)` – zwraca krążek z konkretnego palika
- `show_level(width)` – wizualizuje poziom w konsoli

---

### `Stone`

Model pojedynczego krążka.

**Atrybuty:**

- `width` – szerokość krążka (reprezentuje jego rozmiar)

---

## 📌 Notatki

- Obsługuje do 9 krążków (np. `Board.new(6)`)
- W przypadku parzystej liczby krążków algorytm rozwiązuje zagadkę nieco inaczej niż przy nieparzystej.
- Wymaga terminala z obsługą czyszczenia ekranu (`$stdout.clear_screen`).

---

## 👤 Autor

Trzykropki33
GitHub: `@Trzykropki33`

---

## 📜 Licencja

`MIT License` – możesz używać, modyfikować i rozpowszechniać ten projekt z zachowaniem informacji o autorze.
