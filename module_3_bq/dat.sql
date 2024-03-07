DROP TABLE IF EXISTS `big-bliss-411815.ny_taxi.yellow_tripdata_2020`;
-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `big-bliss-411815.ny_taxi.yellow_tripdata_2020`
(
  VendorID INTEGER,
  tpep_pickup_datetime TIMESTAMP,
  tpep_dropoff_datetime TIMESTAMP,
  passenger_count FLOAT,
  trip_distance FLOAT,
  RatecodeID FLOAT,
  store_and_fwd_flag STRING,
  PULocationID INTEGER,
  DOLocationID INTEGER,
  payment_type INTEGER,
  fare_amount FLOAT,
  extra FLOAT,
  mta_tax FLOAT,
  tip_amount FLOAT,
  tolls_amount FLOAT,
  improvement_surcharge FLOAT,
  total_amount FLOAT,
  congestion_surcharge FLOAT,
  airport_fee INTEGER
)
OPTIONS (
  format = 'parquet',
  uris = [
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_01.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_02.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_03.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_04.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_05.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_06.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_07.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_08.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_09.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_10.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_11.parquet',
    'gs://mage-zoomcamp-pd2669/yellow/2020/yellow_tripdata_2020_12.parquet'
    ]
);