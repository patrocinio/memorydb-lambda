import json
import time
import json
import os

def lambda_handler(event, context):

    endpoint = os.environ['MEMORYDB_ENDPOINT']
    print ("endpoint: ", endpoint)
    
# Run for 4 minutes
#    for iter in range(1, 5*60):
#        res = urllib.request.urlopen(req, timeout=5)
#        print("#", iter, "Status: ", res.status)
#        response = json.loads(res.read())
#        print("Response: ", response)
#        time.sleep(1)
    