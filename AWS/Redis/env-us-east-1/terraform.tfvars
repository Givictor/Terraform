vpc_id = "<vpc-id>"
subnet_ids = "<subnet-1>,<subnet-2>,<subnet-3>"
az = "us-west-2a,us-west-2b,us-west-2c"


region="us-west-2"
cluster_mode=true
environment = "<env>"

shared-svc-test=true

redis-cluster-config={
    node_type="cache.r6g.large"
    port=6379
    parameter_group_name= "default.redis7.cluster.on"
    automatic_failover_enabled=true
    replica=0
    shard=1 
    transit_encryption_enabled=true
    at_rest_encryption_enabled=true
    kms_key_id="<kms-redis-key>"
    apply_immediately=true
    multi_az_enabled=false
 }

redis-cluster-config-test={
    node_type="cache.t4g.medium"
    port=6379
    parameter_group_name= "default.redis7.cluster.on"
    automatic_failover_enabled=true
    replica=0
    shard=1 
    transit_encryption_enabled=true
    at_rest_encryption_enabled=true
    kms_key_id="<kms-redis-key>"
    apply_immediately=true
    multi_az_enabled=false
    snapshot_retention_limit="7"
 }
 

sg_rules = [
{
    cidr_blocks = "<cidr>"
    from_port = 6379
    to_port = 6379
    type = "ingress"
    protocol = "tcp"
},
{
    cidr_blocks = "<cidr>"
    from_port = 6379
    to_port = 6379
    type = "ingress"
    protocol = "tcp"
},
{
    cidr_blocks = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
    type = "egress"
    protocol = "tcp"
    self = false
}
]


test_sg_rules = [
{
    cidr_blocks = "<cidr>"
    from_port = 6379
    to_port = 6379
    type = "ingress"
    protocol = "tcp"
},
{
    cidr_blocks = "<cidr>"
    from_port = 6379
    to_port = 6379
    type = "ingress"
    protocol = "tcp"
},
{
    cidr_blocks = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
    type = "egress"
    protocol = "tcp"
    self = false
}
]


src_sg_rules = [
{
    source_security_group_id = "<sg-id>"
    from_port = 6379
    to_port = 6379
    type = "ingress"
    protocol = "tcp"
}
]
