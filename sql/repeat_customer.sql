WITH rfm_base AS (
  SELECT
    "CustomerID",
    NOW() - MAX("InvoiceDate") AS recency,
    COUNT(DISTINCT "InvoiceNo") AS frequency,
    SUM("Quantity" * "UnitPrice") AS monetary
  FROM public.ecommerce_data_cleaned
  GROUP BY "CustomerID"
),
rfm_scores AS (
  SELECT *,
    NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency) AS f_score,
    NTILE(5) OVER (ORDER BY monetary) AS m_score
  FROM rfm_base
),
rfm_segments AS (
  SELECT *,
    r_score + f_score + m_score AS rfm_total,
    CASE
      WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champion'
      WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal'
      WHEN r_score >= 3 AND m_score >= 3 THEN 'Potential'
      WHEN f_score >= 3 AND m_score >= 3 THEN 'Need Attention'
      ELSE 'Require Activation'
    END AS segment
  FROM rfm_scores
),

purchase_dates AS (
  SELECT
    "CustomerID",
    "InvoiceDate",
    ROW_NUMBER() OVER (PARTITION BY "CustomerID" ORDER BY "InvoiceDate") AS order_rank
  FROM public.ecommerce_data_cleaned
),

first_two_orders AS (
  SELECT *
  FROM purchase_dates
  WHERE order_rank <= 2
),

pivoted_orders AS (
  SELECT
    "CustomerID",
    MAX(CASE WHEN order_rank = 1 THEN "InvoiceDate" END) AS first_order_date,
    MAX(CASE WHEN order_rank = 2 THEN "InvoiceDate" END) AS second_order_date
  FROM first_two_orders
  GROUP BY "CustomerID"
),

repeat_flag AS (
  SELECT *,
    CASE
      WHEN second_order_date IS NOT NULL
           AND second_order_date - first_order_date <= INTERVAL '30 days'
      THEN 1
      ELSE 0
    END AS is_repeat_buyer
  FROM pivoted_orders
)

SELECT
  s.*,
  r.is_repeat_buyer
FROM rfm_segments s
LEFT JOIN repeat_flag r ON s."CustomerID" = r."CustomerID";

