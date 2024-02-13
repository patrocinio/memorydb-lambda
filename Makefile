build:
	sam build

deploy: get_memorydb_host get_securitygroup_id get_subnet
	sam deploy --parameter-overrides MemoryDBHost=$(MEMORYDB_HOST) SecurityGroupId=$(SECURITYGROUP_ID) Subnet=$(SUBNET)

GET_MEMORYDB_HOST=$(shell aws memorydb describe-clusters --cluster-name memorydb-cluster | jq -r '.Clusters[0].ClusterEndpoint.Address')
SET_MEMORYDB_HOST=$(eval MEMORYDB_HOST=$(GET_MEMORYDB_HOST))

get_memorydb_host: 
	$(SET_MEMORYDB_HOST)
	echo endpoint: $(MEMORYDB_HOST)

GET_SECURITYGROUP_ID=$(shell aws ec2 describe-security-groups --filters Name=vpc-id,Values=$(VPC_ID) | jq -r '.SecurityGroups[0].GroupId')
SET_SECURITYGROUP_ID=$(eval SECURITYGROUP_ID=$(GET_SECURITYGROUP_ID))

get_securitygroup_id: get_vpc_id
	$(SET_SECURITYGROUP_ID)
	echo Security Group ID: $(SECURITYGROUP_ID)

GET_SUBNET=$(shell aws ec2 describe-subnets --filters Name=vpc-id,Values=$(VPC_ID) | jq -r '.Subnets[0].SubnetId')
SET_SUBNET=$(eval SUBNET=$(GET_SUBNET))

get_subnet: get_vpc_id
	$(SET_SUBNET)
	echo Subnet: $(SUBNET)

GET_VPC_ID=$(shell aws ec2 describe-vpcs --filters Name=tag:Name,Values=memorydb-vpc | jq -r '.Vpcs[0].VpcId')
SET_VPC_ID=$(eval VPC_ID=$(GET_VPC_ID))

get_vpc_id: 
	$(SET_VPC_ID)
	echo VPC ID: $(VPC_ID)

