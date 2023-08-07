
                Revolve Solutions SQL Assessment
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
Questions:

1. Which manufacturers planes had most no of flights? And how many flights?
----------------------------------------------------------------------------
  
  Query:  SELECT planes.manufacturer, COUNT(*) AS num_flights
			FROM flights
			JOIN planes ON flights.tailnum = planes.tailnum
			GROUP BY planes.manufacturer
			ORDER BY num_flights DESC
			LIMIT 1;
			
  Answer:  manufacturer|num_flights|
           ------------+-----------+
           BOEING      |       1103|
 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

2. Which manufacturers planes had most no of flying hours? And how many hours?
-------------------------------------------------------------------------------

  Query:  SELECT planes.manufacturer, SUM(flights.air_time) AS total_flying_hours
			FROM flights
			JOIN planes ON flights.tailnum = planes.tailnum
			GROUP BY planes.manufacturer
			ORDER BY total_flying_hours DESC
			LIMIT 1;
			SELECT planes.manufacturer, SUM(flights.air_time) AS total_flying_hours

  Answer:  manufacturer|total_flying_hours|
           ------------+------------------+
           BOEING      |          236463.0|
  
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

3. Which plane flew the most number of hours? And how many hours?
-----------------------------------------------------------------

  Query:  SELECT planes.manufacturer, SUM(flights.air_time) AS total_flying_hours
			FROM flights
			JOIN planes ON flights.tailnum = planes.tailnum
			GROUP BY planes.manufacturer
			ORDER BY total_flying_hours DESC
			LIMIT 1;
			SELECT planes.manufacturer, SUM(flights.air_time) AS total_flying_hours

  Answer:  tailnum|manufacturer|model  |total_flying_hours|
           -------+------------+-------+------------------+
           N727TW |BOEING      |757-231|              2019|

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

4. Which destination had most delay in flights?
----------------------------------------------

  Query: SELECT dest, SUM(CAST(arr_delay AS INTEGER)) AS total_delay
           FROM flights
		   GROUP BY dest
		   ORDER BY total_delay DESC
		   LIMIT 1;

  Answer:  dest|total_delay|
           ----+-----------+
           DFW |       1618|

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

5. Which manufactures planes had covered most distance? And how much distance?
------------------------------------------------------------------------------

  Query: SELECT manufacturer, SUM(distance) AS total_distance
			FROM planes
			INNER JOIN flights ON planes.tailnum = flights.tailnum
			GROUP BY manufacturer
			ORDER BY total_distance DESC
			LIMIT 5;
			
  Answer:   manufacturer    |total_distance|
			----------------+--------------+
			BOEING          |       1644180|
			AIRBUS          |        960573|
			AIRBUS INDUSTRIE|        552390|
			EMBRAER         |        443227|
			BOMBARDIER INC  |        142797|

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

6. Which airport had most flights on weekends?
----------------------------------------------

 Query: SELECT airport, COUNT(*) AS weekend_flights
		FROM (
			SELECT origin AS airport
			FROM flights
			WHERE strftime('%w', year || '-' || substr('00' || month, -2) || '-' || substr('00' || day, -2)) IN ('0', '6')
			UNION ALL
			SELECT dest AS airport
			FROM flights
			WHERE strftime('%w', year || '-' || substr('00' || month, -2) || '-' || substr('00' || day, -2)) IN ('0', '6')
			) AS weekend_airports
		GROUP BY airport
		ORDER BY weekend_flights DESC
		LIMIT 1;
			
  Answer:
            airport|weekend_flights|
            -------+---------------+
            JFK    |            325|