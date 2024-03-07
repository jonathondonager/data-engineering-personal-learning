import dlt
from dlt.sources.helpers import requests
import itertools
import pyarrow as pa
from pyarrow.parquet import ParquetFile


def make_lists(services = ["yellow"],years = ["2020"]):

    months = list(month for month in range(1, 13))

    request_urls = []
    object_keys = []

    for service, year, month in itertools.product(services, years, months):
        month = f"{month:02d}"
        file_name = f"{service}_tripdata_{year}-{month}.parquet"
        request_url = f"https://d37ci6vzurychx.cloudfront.net/trip-data/{file_name}"
        object_key = f"{service}/{year}/{service}_tripdata_{year}_{month}.parquet"

        request_urls.append(request_url)
        object_keys.append(object_key)

    
    return request_urls, object_keys

print(make_lists())
request_urls, object_keys = make_lists()

@dlt.source
def taxi_data_source():
    return taxi_data_resource()


@dlt.resource(write_disposition="replace")
def taxi_data_resource(request_urls = request_urls, object_keys = object_keys):

    # check if authentication headers look fine


    # make an api call here
    response = requests.get(request_urls[1])
    response.raise_for_status()
    yield response.parquet()

    # test data for loading validation, delete it once you yield actual data
    # test_data = [{"id": 0}, {"id": 1}]
    # yield test_data


if __name__ == "__main__":
    # configure the pipeline with your destination details
    pipeline = dlt.pipeline(
        pipeline_name='taxi_data', destination='filesystem', dataset_name=object_keys[1]
    )

    # print credentials by running the resource
    data = list(taxi_data_resource())

    # print the data yielded from resource
    print(data)
    exit()

    # run the pipeline with your parameters
    load_info = pipeline.run(taxi_data_source())

    # pretty print the information on data that was loaded
    print(load_info)
