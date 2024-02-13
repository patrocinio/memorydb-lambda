build:
	sam build

deploy: get_memorydb_host get_securitygroup_id
	sam deploy --parameter-overrides MemoryDBHost=$(MEMORYDB_HOST) SecurityGroupId=$(SECURITYGROUP_ID)

GET_SECURITYGROUP_ID=$(shell aws ec2 describe-security-groups --group-name default | jq -r '.SecurityGroups[0].GroupId')
SET_SECURITYGROUP_ID=$(eval SECURITYGROUP_ID=$(GET_SECURITYGROUP_ID))

get_securitygroup_id: 
	$(SET_SECURITYGROUP_ID)
	echo Security Group ID: $(SECURITYGROUP_ID)

GET_MEMORYDB_HOST=$(shell aws memorydb describe-clusters --cluster-name memorydb-cluster | jq -r '.Clusters[0].ClusterEndpoint.Address')
SET_MEMORYDB_HOST=$(eval MEMORYDB_HOST=$(GET_MEMORYDB_HOST))

get_memorydb_host: 
	$(SET_MEMORYDB_HOST)
	echo endpoint: $(MEMORYDB_HOST)
