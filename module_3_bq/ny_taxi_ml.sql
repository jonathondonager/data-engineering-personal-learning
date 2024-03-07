-- SELECT THE IMPORTANT COLUMNS
CREATE OR REPLACE TABLE `vernal-foundry-375904.ny_taxi.ml_features` 
(
  passenger_count INT64
  , hour_of_pickup STRING
  , day_of_pickup STRING
  , trip_distance FLOAT64
  , pulocationid STRING
  , dolocationid STRING
  , payment_type STRING
  , fare_amount FLOAT64
  , tolls_amount FLOAT64
  , congestion_surcharge FLOAT64
  , airport_fee FLOAT64
  , tip_amount FLOAT64
)
AS
(
SELECT 
  SAFE_CAST(passenger_count AS INT64)
  , CAST(EXTRACT(HOUR from tpep_pickup_datetime) AS STRING) hour_of_pickup
  , CAST(EXTRACT(DAYOFWEEK from tpep_pickup_datetime) AS STRING) day_of_pickup
  , trip_distance
  , CAST(pulocationid AS STRING)
  , CAST(dolocationid AS STRING)
  , CAST(payment_type AS STRING)
  , fare_amount
  , tolls_amount
  , congestion_surcharge
  , airport_fee
  , tip_amount
FROM `vernal-foundry-375904.ny_taxi.yellow_cab_data`
WHERE fare_amount > 0
);

-- BUILD MODEL
CREATE OR REPLACE MODEL `vernal-foundry-375904.ny_taxi.tip_model`
OPTIONS
  (
    model_type = 'linear_reg'
    , input_label_cols=['tip_amount']
    , DATA_SPLIT_METHOD='AUTO_SPLIT'
  ) 
  AS
  SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
  ;

-- CHECK FEATURES
SELECT * FROM ML.FEATURE_INFO(MODEL `vernal-foundry-375904.ny_taxi.tip_model`)
;

-- EVAL MODEL
SELECT 
  * 
FROM ML.EVALUATE(MODEL `vernal-foundry-375904.ny_taxi.tip_model`
  , ( SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
))
;

-- PREDICT 
SELECT 
  * 
FROM ML.PREDICT(MODEL `vernal-foundry-375904.ny_taxi.tip_model`
  , ( SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
))
;

-- PREDICT AND EXPLAIN
SELECT 
  * 
FROM ML.EXPLAIN_PREDICT(MODEL `vernal-foundry-375904.ny_taxi.tip_model`
  , ( SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
), STRUCT(3 AS top_k_features))
;

--HYPERPARAM TUNE
-- BUILD MODEL
CREATE OR REPLACE MODEL `vernal-foundry-375904.ny_taxi.tip_hyperparam_model`
OPTIONS
  (
    model_type = 'linear_reg'
    , input_label_cols=['tip_amount']
    , DATA_SPLIT_METHOD='AUTO_SPLIT'
    , num_trials=5
    , max_parallel_trials=2
    ,l1_reg=hparam_range(0,20)
    ,l2_reg=hparam_candidates(0,0.1,1,10)
  ) 
AS
SELECT * 
FROM `vernal-foundry-375904.ny_taxi.ml_features` 
WHERE tip_amount IS NOT NULL
;

-- EVAL MODEL
SELECT 
  * 
FROM ML.EVALUATE(MODEL `vernal-foundry-375904.ny_taxi.tip_hyperparam_model`
  , ( SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
))
;

-- PREDICT 
SELECT 
  * 
FROM ML.PREDICT(MODEL `vernal-foundry-375904.ny_taxi.tip_hyperparam_model`
  , ( SELECT * 
  FROM `vernal-foundry-375904.ny_taxi.ml_features` 
  WHERE tip_amount IS NOT NULL
))
;