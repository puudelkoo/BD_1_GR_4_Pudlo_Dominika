CREATE SCHEMA rozliczenia

CREATE TABLE rozliczenia.pracownicy (
id_pracownika VARCHAR NOT NULL, 
imie TEXT NOT NULL, 
nazwisko TEXT NOT NULL,
adres VARCHAR NOT NULL, 
telefon  VARCHAR NOT NULL 
);

CREATE TABLE rozliczenia.godziny (
id_godziny SERIAL PRIMARY KEY,
data DATE NOT NULL,
liczba_godzin INT NOT NULL,
id_pracownika character varying NOT NULL
);

CREATE TABLE rozliczenia.pensje (
id_pensja VARCHAR PRIMARY KEY NOT NULL,
stanowisko TEXT NOT NULL,
KWOTA FLOAT NOT NULL,
id_premii VARCHAR	
);

CREATE TABLE rozliczenia.premie(
id_premii VARCHAR PRIMARY KEY NOT NULL,
rodzaj TEXT NOT NULL,
kwota FLOAT	NOT NULL
);

ALTER TABLE rozliczenia.pensje
ADD FOREIGN KEY (id_premii)
REFERENCES rozliczenia.premie(id_premii);

ALTER TABLE rozliczenia.godziny
ADD FOREIGN KEY (id_pracownika)
REFERENCES rozliczenia.pracownicy(id_pracownika);

INSERT INTO rozliczenia.pracownicy (id_pracownika, imie, nazwisko, adres, telefon)
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




INSERT INTO rozliczenia.godziny (id_godziny, data, liczba_godzin, id_pracownika) VALUES
(1, '2023-11-01', 8, '123'),
(2, '2023-11-01', 7, '456'),
(3, '2023-11-02', 8, '789'),
(4, '2023-11-02', 6, '012'),
(5, '2023-11-03', 9, '345'),
(6, '2023-11-03', 7, '678'),
(7, '2023-11-04', 8, '901'),
(8, '2023-11-04', 9, '234'),
(9, '2023-11-05', 8, '567'),
(10, '2023-11-05', 7, '890');

INSERT INTO rozliczenia.premie (id_premii, rodzaj, kwota)
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

INSERT INTO rozliczenia.pensje (id_pensja, stanowisko, kwota, id_premii)
VALUES
(1, 'Stanowisko_A', 2500, 1),
(2, 'Stanowisko_B', 2800, 2),
(3, 'Stanowisko_C', 3000, 3),
(4, 'Stanowisko_D', 3200, 4),
(5, 'Stanowisko_E', 2700, 5),
(6, 'Stanowisko_F', 3100, 6),
(7, 'Stanowisko_G', 2600, 7),
(8, 'Stanowisko_H', 2900, 8),
(9, 'Stanowisko_I', 3300, 9),
(10, 'Stanowisko_J', 2700, 10);

SELECT nazwisko, adres FROM rozliczenia.pracownicy;

SELECT 
    TO_CHAR(data, 'Day') AS NazwaDniaTygodnia,
    TO_CHAR(data, 'Month') AS NazwaMiesiaca
FROM 
    rozliczenia.godziny;

			
ALTER TABLE rozliczenia.pensje ADD COLUMN kwota_netto INT;
UPDATE rozliczenia.pensje
SET kwota_netto = ROUND(kwota * 0.75);		
ALTER TABLE rozliczenia.pensje RENAME COLUMN kwota TO kwota_brutto;
