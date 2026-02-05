/* ============================================================
   PROJETO: Hotel Revenue & Cancellation Analysis
   PROJECT: Hotel Revenue & Cancellation Analysis

   OBJETIVO:
   Consolidar dados históricos de reservas (2018–2020),
   tratar dados temporais e preparar a base para análise no Power BI.

   GOAL:
   Consolidate historical booking data (2018–2020),
   handle temporal data, and prepare the dataset for Power BI analysis.
   ============================================================ */


/* ============================================================
   CONSOLIDAÇÃO DAS TABELAS ANUAIS
   Combina as tabelas de 2018, 2019 e 2020 em uma única base.

   CONSOLIDATION OF YEARLY TABLES
   Combines the 2018, 2019, and 2020 tables into a single dataset.
   ============================================================ */

WITH base_reservations AS (
    SELECT * FROM dbo.[2018$]
    UNION ALL
    SELECT * FROM dbo.[2019$]
    UNION ALL
    SELECT * FROM dbo.[2020$]
)


/* ============================================================
   CRIAÇÃO DA TABELA FATO
   Cada linha representa uma reserva.
   Centraliza métricas, atributos de negócio e tempo.

   FACT TABLE CREATION
   Each row represents a reservation.
   Centralizes metrics, business attributes, and time dimensions.
   ============================================================ */

SELECT

    /* ----------------------------
       DIMENSÕES TEMPORAIS
       TEMPORAL DIMENSIONS
       ---------------------------- */

    br.arrival_date_year  AS arrival_year,            -- Ano de chegada | Arrival year
    br.arrival_date_month AS arrival_month,           -- Mês (texto) | Month (text)
    br.arrival_date_week_number AS arrival_week,      -- Semana do ano | Week of year
    br.arrival_date_day_of_month AS arrival_dayofmonth, -- Dia do mês | Day of month


    /* ----------------------------
       DATA COMPLETA
       Criada para facilitar análises temporais e ordenação correta.

       FULL DATE
       Created to enable proper time analysis and chronological ordering.
       ---------------------------- */

    DATEFROMPARTS(
        br.arrival_date_year,
        CASE br.arrival_date_month
            WHEN 'January'   THEN 1
            WHEN 'February'  THEN 2
            WHEN 'March'     THEN 3
            WHEN 'April'     THEN 4
            WHEN 'May'       THEN 5
            WHEN 'June'      THEN 6
            WHEN 'July'      THEN 7
            WHEN 'August'    THEN 8
            WHEN 'September' THEN 9
            WHEN 'October'   THEN 10
            WHEN 'November'  THEN 11
            WHEN 'December'  THEN 12
        END,
        br.arrival_date_day_of_month
    ) AS arrival_date,


    /* ----------------------------
       NÚMERO DO MÊS
       Usado para ordenação correta em gráficos.

       MONTH NUMBER
       Used for correct sorting in charts.
       ---------------------------- */

    CASE br.arrival_date_month
        WHEN 'January'   THEN 1
        WHEN 'February'  THEN 2
        WHEN 'March'     THEN 3
        WHEN 'April'     THEN 4
        WHEN 'May'       THEN 5
        WHEN 'June'      THEN 6
        WHEN 'July'      THEN 7
        WHEN 'August'    THEN 8
        WHEN 'September' THEN 9
        WHEN 'October'   THEN 10
        WHEN 'November'  THEN 11
        WHEN 'December'  THEN 12
    END AS arrival_month_number,


    /* ----------------------------
       DIMENSÕES DE NEGÓCIO
       BUSINESS DIMENSIONS
       ---------------------------- */

    br.hotel AS hotel_type,                 -- Tipo de hotel | Hotel type
    br.market_segment,                      -- Segmento de mercado | Market segment
    br.distribution_channel,                -- Canal de distribuição | Distribution channel
    br.customer_type,                       -- Tipo de cliente | Customer type
    br.country,                             -- País | Country
    br.meal,                                -- Tipo de refeição | Meal type
    br.deposit_type,                        -- Tipo de depósito | Deposit type


    /* ----------------------------
       ATRIBUTOS DE COMPORTAMENTO
       BEHAVIORAL ATTRIBUTES
       ---------------------------- */

    br.lead_time,                           -- Antecedência da reserva | Lead time
    br.is_repeated_guest,                   -- Cliente recorrente | Repeated guest
    br.previous_cancellations,              -- Cancelamentos anteriores | Previous cancellations
    br.booking_changes,                     -- Alterações na reserva | Booking changes
    br.days_in_waiting_list,                -- Dias em lista de espera | Waiting list days
    br.required_car_parking_spaces,          -- Vagas de estacionamento | Parking spaces
    br.total_of_special_requests,            -- Pedidos especiais | Special requests


    /* ----------------------------
       MÉTRICAS DERIVADAS
       DERIVED METRICS
       ---------------------------- */

    -- Total de noites por reserva | Total nights per booking
    (br.stays_in_week_nights + br.stays_in_weekend_nights) AS total_nights,

    -- Total de hóspedes por reserva | Total guests per booking
    (br.adults + br.children + br.babies) AS total_guests,

    -- Average Daily Rate
    br.adr,

    -- Receita bruta por reserva | Gross revenue per booking
    (br.adr * (br.stays_in_week_nights + br.stays_in_weekend_nights)) 
        AS gross_revenue,


    /* ----------------------------
       DADOS FINANCEIROS AUXILIARES
       SUPPORTING FINANCIAL DATA
       ---------------------------- */

    mc.cost     AS meal_cost,      -- Custo da refeição | Meal cost
    ms.discount AS discount,       -- Desconto por segmento | Segment discount


    /* ----------------------------
       STATUS DA RESERVA
       BOOKING STATUS
       ---------------------------- */

    br.is_canceled                -- 1 = cancelada | canceled | 0 = realizada | not canceled


/*************************************************************
   JOIN COM TABELAS AUXILIARES
   Enriquece a tabela fato com custos e descontos.

    JOIN WITH SUPPORT TABLES
   Enriches the fact table with costs and discounts.
*************************************************************/

INTO fact_hotel_reservations
FROM base_reservations br

LEFT JOIN dbo.meal_cost$ mc
    ON br.meal = mc.meal

LEFT JOIN dbo.market_segment$ ms
    ON br.market_segment = ms.market_segment;


/* ============================================================
   RESULTADO FINAL
   Tabela fato pronta para consumo no Power BI.

   FINAL RESULT
   Fact table ready to be consumed by Power BI.
   ============================================================ */
