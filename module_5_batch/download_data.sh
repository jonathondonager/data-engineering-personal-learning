set -e

TAXI_TYPE=$1 #"yellow"
YEAR=$2 #2020

URL_PREFIX="https://d37ci6vzurychx.cloudfront.net/trip-data"

for MONTH in {1..12}; do
    FMONTH=`printf "%02d" ${MONTH}`
    URL=${URL_PREFIX}/${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet
    
    LOCAL_PREFIX="data/raw/${TAXI_TYPE}/${YEAR}/${FMONTH}"
    LOCAL_FILE=${TAXI_TYPE}_tripdata_${YEAR}-${FMONTH}.parquet
    LOCAL_PATH=${LOCAL_PREFIX}/${LOCAL_FILE}

    echo "Downloading ${URL} to ${LOCAL_PATH}"

    mkdir -p ${LOCAL_PREFIX}
    wget ${URL} -O ${LOCAL_PATH}

done

# mkdir data/zones/
# wget https://d37ci6vzurychx.cloudfront.net/misc/taxi_zone_lookup.csv -O data/zones/taxi_zone_lookup.csv

# ./download_data.sh green 2020   
# ./download_data.sh green 2021   
# ./download_data.sh green 2022   
# ./download_data.sh yellow 2020   
# ./download_data.sh yellow 2021   
# ./download_data.sh yellow 2022   
