## model deployment
[Tutorial](https://cloud.google.com/bigquery-ml/docs/export-model-tutorial)
### Steps
- gcloud auth login
- bq --project_id vernal-foundry-375904 extract -m ny_taxi.tip_model gs://taxi_ml_model//tip_model
- mkdir /tmp/model
- gsutil cp -r gs://taxi_ml_model//tip_model /tmp/model
- mkdir -p serving_dir/tip_model/1
- cp -r /tmp/model/tip_model/* serving_dir/tip_model/1
- docker pull tensorflow/serving
- docker run -p 8501:8501 --mount type=bind,source=`pwd`/serving_dir/tip_model,target=/models/tip_model -e MODEL_NAME=tip_model -t tensorflow/serving &
- curl -d '{"instance": [{"passenger_count":1,"trip_distance":12.2,}]} 