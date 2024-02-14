import time
import json
import os
from redis.cluster import RedisCluster
import boto3

cloudWatch = boto3.client('cloudwatch')
ITERATIONS = 1*60

def put_metric(value):
    cloudWatch.put_metric_data(
        MetricData = [
            {
                'MetricName': 'Time to store value in MemoryDB',
                'Unit': 'Count',
                'Value': value
            }
        ],
        Namespace='MemoryDB_metrics'
    )
    

def lambda_handler(event, context):

    host = os.environ['MEMORYDB_HOST']
    print ("host: ", host)

    cluster = RedisCluster(
        host=host,
        port=6379,
        ssl=True,
        decode_responses=True,
    )

# Run for 5 minutes
    for iter in range(1, ITERATIONS):
        before = time.time()
    
        cluster.set("key", "value")
    
        after = time.time()
        put_metric(after-before)
        value = cluster.get("key")
        time.sleep(1)
    