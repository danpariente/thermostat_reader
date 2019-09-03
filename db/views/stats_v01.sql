SELECT
  thermostat_id as thermostat_id,
  'temperature' as stats_type,
  AVG(temperature) as average,
  MAX(temperature) as maximum,
  MIN(temperature) as minimum
FROM "readings"
INNER JOIN "thermostats" ON "thermostats"."id" = "readings"."thermostat_id"
GROUP BY "readings"."thermostat_id"

UNION

SELECT
  thermostat_id as thermostat_id,
  'humidity' as stats_type,
  AVG(humidity) as average,
  MAX(humidity) as maximum,
  MIN(humidity) as minimum
FROM "readings"
INNER JOIN "thermostats" ON "thermostats"."id" = "readings"."thermostat_id"
GROUP BY "readings"."thermostat_id"

UNION

SELECT
  thermostat_id as thermostat_id,
  'battery_charge' as stats_type,
  AVG(battery_charge) as average,
  MAX(battery_charge) as maximum,
  MIN(battery_charge) as minimum
 FROM "readings"
 INNER JOIN "thermostats" ON "thermostats"."id" = "readings"."thermostat_id"
 GROUP BY "readings"."thermostat_id"
