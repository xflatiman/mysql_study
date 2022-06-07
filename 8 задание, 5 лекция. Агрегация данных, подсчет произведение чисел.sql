USE shop;

SELECT id FROM catalogs;

SELECT LN(1 * 2 * 3), LN(1) + LN(2) + LN(3);

SELECT EXP(LN(1 * 2 * 3 * 4 * 5)), EXP(LN(1) + LN(2) + LN(3) + LN(4) + LN(5));

SELECT LN(id) FROM catalogs;

SELECT SUM(LN(id)) FROM catalogs;

SELECT EXP(SUM(LN(id))) FROM catalogs;
