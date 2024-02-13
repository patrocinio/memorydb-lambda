build:
	sam build

deploy: get_endpoint
	sam deploy --parameter-overrides MemoryDBEndpoint=$(MEMORYDB_ENDPOINT)


GET_MEMORYDB_ENDPOINT=$(shell aws memorydb describe-clusters --cluster-name memorydb-cluster | jq -r '.Clusters[0].ClusterEndpoint.Address')
SET_MEMORYDB_ENDPOINT=$(eval MEMORYDB_ENDPOINT=$(GET_MEMORYDB_ENDPOINT):6379)

get_endpoint: 
	$(SET_MEMORYDB_ENDPOINT)
	echo Loader ID: $(MEMORYDB_ENDPOINT)

setup:
	pip install redis
