import os
import argparse
import pandas as pd
from sqlalchemy import create_engine
import pyarrow.parquet as pq
from time import time


def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db_name = params.db_name
    table_name = params.table_name
    url = params.url

    file_name = 'output.parquet'

    # os.system(f'wget {url} -O {file_name}')
    os.system(f'curl {url} -o {file_name}')
    print("got the file...")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db_name}')
    # engine.connect()

    pd.read_parquet(file_name).head(0).to_sql(name=table_name, con=engine, if_exists='replace')
    # pd.read_csv(file_name).head(0).to_sql(name=table_name, con=engine, if_exists='replace')
    print('finished download and table creation...')

if __name__=='__main__': 

    parser = argparse.ArgumentParser(description='Ingest parquet file to postgres')

    parser.add_argument('--user', help='username of postgres database')
    parser.add_argument('--password', help='password of postgres database')
    parser.add_argument('--host', help='host of postgres database')
    parser.add_argument('--port', help='port of postgres database')
    parser.add_argument('--db_name', help='postgres database')
    parser.add_argument('--table_name', help='table of postgres database')
    parser.add_argument('--url', help='name of data file')

    args = parser.parse_args()

    main(args)





