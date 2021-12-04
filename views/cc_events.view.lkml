view: cc_events {
  derived_table: {
    sql: SELECT
          events."CITY"  AS "events.city",
          events."COUNTRY"  AS "events.country",
          COUNT(*) AS "events.count"
      FROM "PUBLIC"."EVENTS"
           AS events
      WHERE (((( events."CREATED_AT"  )) >= TO_TIMESTAMP('2010-02-03')))
      GROUP BY
          1,
          2
      ORDER BY
          3 DESC
      FETCH NEXT 500 ROWS ONLY
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: events_city {
    type: string
    sql: ${TABLE}."events.city" ;;
  }

  dimension: events_country {
    type: string
    sql: ${TABLE}."events.country" ;;
  }

  dimension: events_count {
    type: number
    sql: ${TABLE}."events.count" ;;
  }

  set: detail {
    fields: [events_city, events_country, events_count]
  }
}
