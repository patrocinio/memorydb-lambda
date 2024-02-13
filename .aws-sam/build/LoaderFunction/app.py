import time
import json
import os
from redis.cluster import RedisCluster

def lambda_handler(event, context):

    host = os.environ['MEMORYDB_HOST']
    print ("host: ", host)

    cluster = RedisCluster(
        host=host,
        port=6379,
        ssl=True,
        decode_responses=True,
    )
    
# Run for 4 minutes
    for iter in range(1, 5*60):
        cluster.set("key", "value")
        value = cluster.get("key")
        time.sleep(1)
    