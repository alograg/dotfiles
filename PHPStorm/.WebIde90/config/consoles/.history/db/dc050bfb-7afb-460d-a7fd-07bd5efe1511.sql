SELECT DISTINCT zp_ciudad
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCTROW zp_ciudad, zp_municipio
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT ROW zp_ciudad, zp_municipio
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_ciudad, zp_municipio
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_ciudad, zp_municipio, zp_estado
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_ciudad, zp_municipio, zp_estado
FROM zipcode
WHERE zp_municipio LIKE '%tala%'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_ciudad, zp_municipio, zp_estado
FROM zipcode
WHERE zp_estado='Jalisco'
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_ciudad, zp_municipio, zp_estado
FROM zipcode
WHERE zp_estado IN ('Jalisco','Guanajuato')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  zp_estado,
  zp_municipio,
  count(DISTINCT zp_ciudad) AS ciudades
FROM (
       SELECT DISTINCT
         zp_ciudad,
         zp_municipio,
         zp_estado
       FROM zipcode
       WHERE zp_estado IN ('Jalisco', 'Guanajuato')) AS tmp
GROUP BY zp_estado, zp_municipio
;-- -. . -..- - / . -. - .-. -.--
SELECT
  zp_estado,
  zp_municipio,
  count(DISTINCT zp_ciudad) AS ciudades
FROM (
       SELECT DISTINCT
         zp_ciudad,
         zp_municipio,
         zp_estado
       FROM zipcode
       WHERE zp_estado IN ('Jalisco', 'Guanajuato')) AS tmp
GROUP BY zp_estado, zp_municipio
HAVING ciudades >1
;-- -. . -..- - / . -. - .-. -.--
SELECT
  zp_estado,
  zp_municipio,
  count(DISTINCT zp_ciudad) AS ciudades, 
  GROUP_CONCAT(DISTINCT zp_ciudad)
FROM (
       SELECT DISTINCT
         zp_ciudad,
         zp_municipio,
         zp_estado
       FROM zipcode
       WHERE zp_estado IN ('Jalisco', 'Guanajuato')) AS tmp
GROUP BY zp_estado, zp_municipio
HAVING ciudades >1
;-- -. . -..- - / . -. - .-. -.--
SELECT
  zp_estado,
  zp_ciudad,
  count(DISTINCT zp_municipio) AS ciudades,
  GROUP_CONCAT(DISTINCT zp_municipio)
FROM (
       SELECT DISTINCT
         zp_ciudad,
         zp_municipio,
         zp_estado
       FROM zipcode
       WHERE zp_estado IN ('Jalisco', 'Guanajuato')) AS tmp
GROUP BY zp_estado, zp_municipio
HAVING ciudades >1
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT
  zp_ciudad,
  zp_municipio,
  zp_estado
FROM zipcode
WHERE zp_estado IN ('Jalisco', 'Guanajuato')
;-- -. . -..- - / . -. - .-. -.--
SELECT
  zp_municipio,
  count(DISTINCT zp_estado) AS ciudades,
  GROUP_CONCAT(DISTINCT zp_estado)
FROM (
       SELECT DISTINCT
         zp_ciudad,
         zp_municipio,
         zp_estado
       FROM zipcode) AS tmp
GROUP BY zp_municipio
HAVING ciudades >1
;-- -. . -..- - / . -. - .-. -.--
SELECT DISTINCT zp_tipo_asentamiento
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento LIKE 'GUADALAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento soundslike 'GUADALAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento like 'GUADáLAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento word 'GUADáLAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento REGEXP 'GUAD*LAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento REGEXP 'GUAD.LAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento MATCH 'GUAD.LAJARA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento MATCH 'GUAD.*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE
  zp_asentamiento REGEXP '/GUAD.*/i'
;-- -. . -..- - / . -. - .-. -.--
SELECT soundex(zp_asentamiento), * FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT sqlite_version()
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUADALA'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUADALA*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB '*GUAD'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUAD'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUAD?'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUAD*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUA*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento LIKE 'GUA*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento LIKE 'GUA%'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento GLOB 'GUAD%'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento LIKE 'GUAD%'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento REGEXP '\w*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento REGEX '\w*'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento REGEXP '/.*/'
;-- -. . -..- - / . -. - .-. -.--
SELECT * FROM zipcode
WHERE zp_asentamiento LIKE 'GUADA%'
;-- -. . -..- - / . -. - .-. -.--
SELECT *
FROM zipcode
;-- -. . -..- - / . -. - .-. -.--
SELECT zp_estado, zp_municipio
FROM zipcode
GROUP BY zp_estado, zp_municipio
;-- -. . -..- - / . -. - .-. -.--
SELECT state, zp_estado, zp_municipio
FROM zipcode
  LEFT JOIN states ON zp_estado=state
GROUP BY zp_estado, zp_municipio
;-- -. . -..- - / . -. - .-. -.--
SELECT postal, zp_municipio
FROM zipcode
  LEFT JOIN states ON zp_estado=state
GROUP BY zp_estado, zp_municipio
;-- -. . -..- - / . -. - .-. -.--
SELECT postal, zp_municipio, random()
FROM zipcode
  LEFT JOIN states ON zp_estado=state
GROUP BY zp_estado, zp_municipio