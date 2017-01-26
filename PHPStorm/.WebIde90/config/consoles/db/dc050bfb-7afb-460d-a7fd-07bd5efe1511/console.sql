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
HAVING ciudades > 1;

SELECT DISTINCT zp_tipo_asentamiento
FROM zipcode;

SELECT state, postal
FROM states;

SELECT postal, zp_municipio, random()
FROM zipcode
  LEFT JOIN states ON zp_estado=state
GROUP BY zp_estado, zp_municipio
