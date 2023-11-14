--Tworzenie schematu

CREATE SCHEMA ksiegowosc

--Tworzenie tabel 

CREATE TABLE ksiegowosc.pracownicy (
id_pracownika VARCHAR PRIMARY KEY, 
imie TEXT NOT NULL, 
nazwisko TEXT NOT NULL,
adres VARCHAR NOT NULL, 
telefon  VARCHAR NOT NULL 
);

CREATE TABLE ksiegowosc.godziny (
id_godziny VARCHAR PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin INT NOT NULL,
id_pracownika VARCHAR NOT NULL
);

CREATE TABLE  ksiegowosc.pensja (
id_pensji VARCHAR PRIMARY KEY,
stanowisko TEXT NOT NULL,
kwota FLOAT NOT NULL	
);

CREATE TABLE ksiegowosc.premia(
id_premii VARCHAR PRIMARY KEY,
rodzaj TEXT NOT NULL,
kwota FLOAT	NOT NULL
);

CREATE TABLE  IF NOT EXISTS ksiegowosc.wynagrodzenia(
id_wynagrodzenia VARCHAR PRIMARY KEY,
data DATE NOT NULL,
id_pracownika VARCHAR NOT NULL,
id_pensji VARCHAR NOT NULL,
id_premii VARCHAR NOT NULL
);

-- Dodawanie klucza obcego 

ALTER TABLE ksiegowosc.godziny
ADD FOREIGN KEY (id_pracownika)
REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_pensji)
REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenia
ADD FOREIGN KEY (id_premii)
REFERENCES ksiegowosc.premia(id_premii);



-- Dodawanie komentarzy do tabeli

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Info o pracownikach';

COMMENT ON TABLE ksiegowosc.godziny IS 'Info o godzinach pracy';

COMMENT ON TABLE ksiegowosc.pensja IS 'Info o pensjach';

COMMENT ON TABLE ksiegowosc.premia IS 'Info o premiach';

COMMENT ON TABLE ksiegowosc.wynagrodzenia IS 'Info o wynagro';

--Wypełnianie tabeli rekordami
INSERT INTO ksiegowosc.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
VALUES
('123', 'Jan', 'Kowalski', 'Leśne 62', '543992102'),
('456', 'Anna', 'Nowak',  'Wodna', '774992002'),
('789', 'Karol', 'Wiśniewski', 'Podwodna 53', '420691213'),
('012', 'Bartosz', 'Kubicki', 'Długa 74', '532137069'),
('345', 'Robert', 'Lewandowski', 'Słoneczna 45', '748490123'),
('678', 'Ewa', 'Kubica', 'Miodowa 16', '757830215'),
('901', 'Tomasz', 'Zieliński', 'Ogrodowa 87', '940832774'),
('234', 'Magdalena', 'Smutna', 'Krótka 98', '785931293'),
('567', 'Krzysztof', 'Zielony', 'Zielona 99', '554832929'),
('890', 'Agnieszka', 'Wójcik', 'Polna 10', '997998999');


INSERT INTO ksiegowosc.godziny (id_godziny, data, liczba_godzin, id_pracownika) 
VALUES
('G1', '2023-01-01', 20, '123'),
('G2', '2023-01-02', 20, '123'),
('G3', '2023-01-03', 20, '123'),
('G4', '2023-01-04', 20, '123'),
('G5', '2023-01-05', 20, '123'),
('G6', '2023-01-06', 20, '123'),
('G7', '2023-01-07', 20, '123'),
('G8', '2023-01-08', 21, '123'),
('G9', '2023-01-09', 8, 	'456'),
('G10', '2023-01-10', 9, '789');

INSERT INTO ksiegowosc.pensja (id_pensji, stanowisko, kwota)
VALUES
('P1', 'Stanowisko_A', 1200),
('P2', 'Stanowisko_B', 1300),
('P3', 'Stanowisko_C', 1100),
('P4', 'Stanowisko_D', 1600),
('P5', 'Stanowisko_E', 1050),
('P6', 'Stanowisko_F', 1700),
('P7', 'Stanowisko_G', 2600),
('P8', 'Stanowisko_H', 2100),
('P9', 'Stanowisko_I',	2800),
('P10', 'Kiernownik', 2900);

INSERT INTO ksiegowosc.premia (id_premii, rodzaj, kwota)
VALUES
(1, 'Premia_a', 500),
(2, 'Premia_b', 300),
(3, 'Premia_c', 1000),
(4, 'Premia_d', 700),
(5, 'Premia_e ', 400),
(6, 'Premia_f', 600),
(7, 'Premia_g', 800),
(8, 'Premia_h', 200),
(9, 'Premia_i', 900),
(10, 'Premia_j', 350);

INSERT INTO ksiegowosc.wynagrodzenia (id_wynagrodzenia, data, id_pracownika, id_pensji, id_premii)
VALUES
('W1', '2023-01-01', '123', 'P1', 1),
('W2', '2023-01-02', '123', 'P2', 2),
('W3', '2023-01-03', '123', 'P3', 3),
('W4', '2023-01-04', '123', 'P4', 4),
('W5', '2023-01-05', '123', 'P5', 5),
('W6', '2023-01-06', '123', 'P6', 6),
('W7', '2023-01-07', '123', 'P7', 7),
('W8', '2023-01-08', '123', 'P8', 8),
('W9', '2023-01-09', '123', 'P9', 9),
('W10', '2023-01-10', '789', 'P10', 10);

--Wyświetlanie id pracownika i nazwisko
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

--wyświetla id pracownikow, któych płaca jest większa niż 1000
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota > 1000;

--Wyświetl id pracowników nieposiadających premii, których płaca jest większa niż 2000. 
SELECT ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenia.id_premii = ksiegowosc.premia.id_premii
WHERE ksiegowosc.pensja.kwota > 2000 AND ksiegowosc.premia.id_premii IS NULL;

--Wyświetl pracowników, których pierwsza litera imienia zaczyna się na literę ‘J’
SELECT id_pracownika
FROM ksiegowosc.pracownicy
WHERE imie LIKE 'J%';

--Wyświetl pracowników, których nazwisko zawiera literę ‘n’ oraz imię kończy się na literę ‘a’
SELECT id_pracownika, imie, nazwisko
FROM ksiegowosc.pracownicy
WHERE nazwisko LIKE '%n%' AND imie LIKE '%a';

--Wyświetl imię i nazwisko pracowników oraz liczbę ich nadgodzin, przyjmując, standardowy czas pracy to 160 h miesięcznie
SELECT imie, nazwisko, 
       GREATEST(SUM(ksiegowosc.godziny.liczba_godzin) - 160, 0) AS nadgodziny
FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.godziny  ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
GROUP BY pracownicy.imie, pracownicy.nazwisko;

--Wyświetl imię i nazwisko pracowników, których pensja zawiera się w przedziale 1500 – 3000 PLN. 
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy 
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
WHERE ksiegowosc.pensja.kwota BETWEEN 1500 AND 3000;

--Wyświetl imię i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii
SELECT imie, nazwisko
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.godziny ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.godziny.id_pracownika
LEFT JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.godziny.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
WHERE ksiegowosc.wynagrodzenia.id_premii IS NULL
GROUP BY ksiegowosc.pracownicy.id_pracownika, ksiegowosc.pracownicy.imie, ksiegowosc.pracownicy.nazwisko
HAVING
    COALESCE(SUM(ksiegowosc.godziny.liczba_godzin), 0) > 160;
	
--Uszereguj pracowników według pensji
SELECT imie, nazwisko, ksiegowosc.pensja.kwota as pensja
FROM ksiegowosc.pracownicy
JOIN ksiegowosc.wynagrodzenia ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenia.id_pracownika
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
ORDER BY ksiegowosc.pensja.kwota;

--Zlicz i pogrupuj pracowników według pola ‘stanowisko’
SELECT stanowisko, COUNT(*) 
FROM ksiegowosc.pensja
GROUP BY ksiegowosc.pensja.stanowisko;

--Policz średnią, minimalną i maksymalną płacę dla stanowiska ‘kierownik’
SELECT
    AVG(ksiegowosc.pensja.kwota) AS srednia_placa_Kierownik,
    MIN(ksiegowosc.pensja.kwota) AS min_placa_Kierownik,
    MAX(ksiegowosc.pensja.kwota) AS max_placa_Kierownik
FROM ksiegowosc.pensja
WHERE ksiegowosc.pensja.stanowisko = 'Kierownik';

--Policz sumę wszystkich wynagrodzeń
SELECT SUM(ksiegowosc.pensja.kwota) as suma_wynagrodzen
FROM ksiegowosc.wynagrodzenia
JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji;

--Policz sumę wynagrodzeń w ramach danego stanowiska
SELECT stanowisko,
    SUM(pensja.kwota) + COALESCE(SUM(premia.kwota), 0) AS suma_wynagrodzen
FROM ksiegowosc.wynagrodzenia
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenia.id_premii = ksiegowosc.premia.id_premii
GROUP BY ksiegowosc.pensja.stanowisko;

--Wyznacz liczbę premii przyznanych dla pracowników danego stanowiska
SELECT
    ksiegowosc.pensja.stanowisko,
    COUNT(ksiegowosc.premia.id_premii) AS liczba_premii
FROM ksiegowosc.wynagrodzenia
LEFT JOIN ksiegowosc.pensja ON ksiegowosc.wynagrodzenia.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia ON ksiegowosc.wynagrodzenia.id_premii = ksiegowosc.premia.id_premii
GROUP BY ksiegowosc.pensja.stanowisko;

--Usuń wszystkich pracowników mających pensję mniejszą niż 1200 zł
DELETE FROM ksiegowosc.wynagrodzenia
WHERE id_pensji IN 
	(SELECT id_pensji
    FROM ksiegowosc.pensja
    WHERE kwota < 1200);
