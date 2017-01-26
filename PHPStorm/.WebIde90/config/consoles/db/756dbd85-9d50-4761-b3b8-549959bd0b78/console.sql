SELECT DISTINCT
  NULL AS container_id,
  packages.content,
  NULL AS price
FROM packages
UNION
SELECT DISTINCT
  prices.container_id,
  prices.content,
  prices.price
FROM prices
ORDER BY content;