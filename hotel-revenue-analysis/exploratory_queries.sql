/* ============================================================
   ANÁLISE DE RECEITA POR MÊS E TIPO DE HOTEL
   MONTHLY REVENUE BY HOTEL TYPE

   Objetivo:
   Avaliar a distribuição da receita bruta ao longo dos meses
   separando por tipo de hotel.

   Goal:
   Analyze gross revenue distribution across months
   segmented by hotel type.
   ============================================================ */

SELECT 
    hotel_type,
    arrival_month_number,
    SUM(gross_revenue) AS gross_revenue   -- Receita bruta mensal | Monthly gross revenue
FROM dbo.fact_hotel_reservations
GROUP BY arrival_month_number, hotel_type
ORDER BY arrival_month_number, hotel_type;



/* ============================================================
   ADR MÉDIO POR MÊS
   AVERAGE DAILY RATE BY MONTH

   Objetivo:
   Identificar padrões sazonais de precificação ao longo do ano.

   Goal:
   Identify seasonal pricing patterns throughout the year.
   ============================================================ */

SELECT 
    arrival_month_number,
    AVG(adr) AS avgadr                    -- ADR médio mensal | Monthly average ADR
FROM dbo.fact_hotel_reservations
GROUP BY arrival_month_number
ORDER BY arrival_month_number;



/* ============================================================
   TAXA DE CANCELAMENTO POR MÊS
   CANCELLATION RATE BY MONTH

   Objetivo:
   Avaliar como o cancelamento varia ao longo dos meses.

   Goal:
   Evaluate how cancellations vary across months.
   ============================================================ */

SELECT 
    arrival_month_number,
    SUM(is_canceled) * 1.0 / COUNT(is_canceled) AS cancelrate -- Taxa de cancelamento | Cancellation rate
FROM dbo.fact_hotel_reservations
GROUP BY arrival_month_number
ORDER BY arrival_month_number;

/* ============================================================
   ANÁLISE POR PAÍS
   COUNTRY-LEVEL ANALYSIS

   Objetivo:
   Analisar o volume total de reservas, cancelamentos e
   distribuição por tipo de hotel e segmento de mercado.

   Goal:
   Analyze total bookings, cancellations, and distribution
   by hotel type and market segment.
   ============================================================ */

SELECT 
    country,

    COUNT(is_canceled) AS total,                 -- Total de reservas | Total bookings
    SUM(is_canceled) AS canceled,                -- Total de cancelamentos | Total cancellations

    -- Reservas não canceladas por tipo de hotel
    -- Non-canceled bookings by hotel type
    SUM(CASE WHEN hotel_type = 'City Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS city_hotel,
    SUM(CASE WHEN hotel_type = 'Resort Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS resort,

    -- Reservas não canceladas por segmento de mercado
    -- Non-canceled bookings by market segment
    SUM(CASE WHEN market_segment = 'Online TA' AND is_canceled = 0 THEN 1 ELSE 0 END) AS online_ta,
    SUM(CASE WHEN market_segment = 'Offline TA/TO' THEN 1 ELSE 0 END) AS offline_ta_to,
    SUM(CASE WHEN market_segment = 'Direct' AND is_canceled = 0 THEN 1 ELSE 0 END) AS direct,
    SUM(CASE WHEN market_segment = 'Corporate' AND is_canceled = 0 THEN 1 ELSE 0 END) AS corporate,
    SUM(CASE WHEN market_segment = 'Groups' AND is_canceled = 0 THEN 1 ELSE 0 END) AS groups,
    SUM(CASE WHEN market_segment = 'Complementary' AND is_canceled = 0 THEN 1 ELSE 0 END) AS complementary,
    SUM(CASE WHEN market_segment = 'Aviation' AND is_canceled = 0 THEN 1 ELSE 0 END) AS aviation,
    SUM(CASE WHEN market_segment = 'Undefined' AND is_canceled = 0 THEN 1 ELSE 0 END) AS undefined

FROM dbo.fact_hotel_reservations 
GROUP BY country
ORDER BY total DESC;



/* ============================================================
   RANKING DE PAÍSES POR CANCELAMENTO
   COUNTRY RANKING BY CANCELLATIONS

   Objetivo:
   Identificar países com maior número absoluto de cancelamentos.

   Goal:
   Identify countries with the highest absolute number of cancellations.
   ============================================================ */

SELECT 
    country
FROM dbo.fact_hotel_reservations
GROUP BY country
ORDER BY SUM(is_canceled) DESC;



/* ============================================================
   ANÁLISE POR SEGMENTO DE MERCADO
   MARKET SEGMENT ANALYSIS

   Objetivo:
   Avaliar volume de reservas, taxa de cancelamento e
   desempenho por tipo de hotel.

   Goal:
   Evaluate booking volume, cancellation rate, and
   performance by hotel type.
   ============================================================ */

SELECT 
    market_segment,

    COUNT(is_canceled) AS total,                                -- Total de reservas | Total bookings
    (SUM(is_canceled) * 1.0 / COUNT(is_canceled)) * 100 AS canceled, -- Taxa de cancelamento (%) | Cancellation rate (%)

    -- Reservas não canceladas por tipo de hotel
    -- Non-canceled bookings by hotel type
    SUM(CASE WHEN hotel_type = 'City Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS city_hotel,
    SUM(CASE WHEN hotel_type = 'Resort Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS resort

FROM dbo.fact_hotel_reservations
GROUP BY market_segment
ORDER BY total DESC;



/* ============================================================
   ANÁLISE POR TIPO DE CLIENTE
   CUSTOMER TYPE ANALYSIS

   Objetivo:
   Entender o comportamento de reservas e cancelamentos
   por perfil de cliente.

   Goal:
   Understand booking and cancellation behavior
   by customer profile.
   ============================================================ */

SELECT 
    customer_type,

    COUNT(is_canceled) AS total,                                -- Total de reservas | Total bookings
    (SUM(is_canceled) * 1.0 / COUNT(is_canceled)) * 100 AS canceled, -- Taxa de cancelamento (%) | Cancellation rate (%)

    -- Reservas não canceladas por tipo de hotel
    -- Non-canceled bookings by hotel type
    SUM(CASE WHEN hotel_type = 'City Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS city_hotel,
    SUM(CASE WHEN hotel_type = 'Resort Hotel' AND is_canceled = 0 THEN 1 ELSE 0 END) AS resort

FROM dbo.fact_hotel_reservations
GROUP BY customer_type
ORDER BY total DESC;
/* ============================================================
   TAXA DE CANCELAMENTO POR FAIXA DE LEAD TIME
   CANCELLATION RATE BY LEAD TIME BANDS

   Objetivo:
   Agrupar o lead time em faixas para facilitar a visualização
   do impacto da antecedência na taxa de cancelamento.

   Goal:
   Group lead time into ranges to improve visualization of how
   booking anticipation impacts cancellation rates.
   ============================================================ */

SELECT
    CASE
        WHEN lead_time BETWEEN 0 AND 50 THEN '0–50'
        WHEN lead_time BETWEEN 51 AND 100 THEN '51–100'
        WHEN lead_time BETWEEN 101 AND 150 THEN '101–150'
        WHEN lead_time BETWEEN 151 AND 200 THEN '151–200'
        WHEN lead_time BETWEEN 201 AND 300 THEN '201–300'
        WHEN lead_time BETWEEN 301 AND 400 THEN '301–400'
        WHEN lead_time BETWEEN 401 AND 500 THEN '401–500'
        WHEN lead_time BETWEEN 501 AND 600 THEN '501–600'
        WHEN lead_time BETWEEN 601 AND 700 THEN '601–700'
        WHEN lead_time BETWEEN 701 AND 800 THEN '701–800'
        ELSE '800+'
    END AS lead_time_range,

    COUNT(*) AS total_bookings,                               -- Total de reservas | Total bookings
    SUM(is_canceled) AS canceled_bookings,                    -- Cancelamentos | Cancellations
    SUM(is_canceled) * 1.0 / COUNT(*) AS cancel_rate          -- Taxa de cancelamento | Cancellation rate

FROM dbo.fact_hotel_reservations
GROUP BY
    CASE
        WHEN lead_time BETWEEN 0 AND 50 THEN '0–50'
        WHEN lead_time BETWEEN 51 AND 100 THEN '51–100'
        WHEN lead_time BETWEEN 101 AND 150 THEN '101–150'
        WHEN lead_time BETWEEN 151 AND 200 THEN '151–200'
        WHEN lead_time BETWEEN 201 AND 300 THEN '201–300'
        WHEN lead_time BETWEEN 301 AND 400 THEN '301–400'
        WHEN lead_time BETWEEN 401 AND 500 THEN '401–500'
        WHEN lead_time BETWEEN 501 AND 600 THEN '501–600'
        WHEN lead_time BETWEEN 601 AND 700 THEN '601–700'
        WHEN lead_time BETWEEN 701 AND 800 THEN '701–800'
        ELSE '800+'
    END
ORDER BY
    MIN(lead_time);
/* ============================================================
   RESERVAS E TAXA DE CANCELAMENTO POR MÊS E TIPO DE HOTEL
   BOOKINGS AND CANCELLATION RATE BY MONTH AND HOTEL TYPE
   ============================================================ */

SELECT 
    arrival_month_number,                                      -- Mês de chegada | Arrival month
    hotel_type,                                                 -- Tipo de hotel | Hotel type
    COUNT(*) AS total_reservations,                             -- Total de reservas | Total bookings
    SUM(is_canceled) * 1.0 / COUNT(*) AS cancel_rate           -- Taxa de cancelamento | Cancellation rate

FROM dbo.fact_hotel_reservations
GROUP BY 
    arrival_month_number,
    hotel_type
ORDER BY 
    arrival_month_number,
    hotel_type;

