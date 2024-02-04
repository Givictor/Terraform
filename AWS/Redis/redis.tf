resource "aws_elasticache_replication_group" "redis" {
  count=var.cluster_mode==true ? 1:0
  replication_group_id          = "${var.environment}-${var.tags.name}"
  replication_group_description = "${var.environment}-${var.tags.name}"
  node_type                     = var.redis-cluster-config.node_type
  port                          = var.redis-cluster-config.port
  parameter_group_name          = var.redis-cluster-config.parameter_group_name
  automatic_failover_enabled    = var.redis-cluster-config.automatic_failover_enabled
  transit_encryption_enabled = var.redis-cluster-config.transit_encryption_enabled
  at_rest_encryption_enabled = var.redis-cluster-config.at_rest_encryption_enabled
  kms_key_id = var.redis-cluster-config.kms_key_id
  multi_az_enabled=var.redis-cluster-config.multi_az_enabled
  apply_immediately=var.redis-cluster-config.apply_immediately
  subnet_group_name = aws_elasticache_subnet_group.redis-subnet.name
  security_group_ids=[aws_security_group.redis_sg.id]
  snapshot_retention_limit =  var.redis-standlone-config.snapshot_retention_limit
  tags={
      Name="${var.environment}-${var.tags.name}"
  }
  cluster_mode {
    replicas_per_node_group = var.redis-cluster-config.replica
    num_node_groups         = var.redis-cluster-config.shard
  }
  log_delivery_configuration {
        destination      = "Redis-logs"
        destination_type = "cloudwatch-logs"
        log_format       = "text"
        log_type         = "slow-log"
        }
}

resource "aws_elasticache_replication_group" "shared_svc_test_redis" {
  count=var.shared-svc-test==true ? 1:0
  replication_group_id          = "test-${var.environment}-${var.tags.name}"
  replication_group_description = "test-${var.environment}-${var.tags.name}"
  node_type                     = var.redis-cluster-config-test.node_type
  port                          = var.redis-cluster-config-test.port
  parameter_group_name          = var.redis-cluster-config-test.parameter_group_name
  automatic_failover_enabled    = var.redis-cluster-config-test.automatic_failover_enabled
  transit_encryption_enabled = var.redis-cluster-config-test.transit_encryption_enabled
  at_rest_encryption_enabled = var.redis-cluster-config-test.at_rest_encryption_enabled
  kms_key_id = var.redis-cluster-config-test.kms_key_id
  multi_az_enabled=var.redis-cluster-config-test.multi_az_enabled
  apply_immediately=var.redis-cluster-config-test.apply_immediately
  subnet_group_name = aws_elasticache_subnet_group.redis-subnet.name
  security_group_ids=[aws_security_group.test_redis_sg.0.id]
  snapshot_retention_limit =  var.redis-cluster-config-test.snapshot_retention_limit
  tags={
      Name="test-${var.environment}-${var.tags.name}"
  }
  cluster_mode {
    replicas_per_node_group = var.redis-cluster-config-test.replica
    num_node_groups         = var.redis-cluster-config-test.shard
  }
}


resource "aws_elasticache_replication_group" "redis-standalone" {
  count=var.cluster_mode==true ? 0:1
  replication_group_id          = "${var.environment}-${var.tags.name}"
  replication_group_description = "${var.environment}-${var.tags.name}"
  node_type                     = var.redis-standlone-config.node_type
  port                          = var.redis-standlone-config.port
  parameter_group_name          = var.redis-standlone-config.parameter_group_name
  number_cache_clusters         = var.redis-standlone-config.shard
  transit_encryption_enabled = var.redis-standlone-config.transit_encryption_enabled
  at_rest_encryption_enabled = var.redis-standlone-config.at_rest_encryption_enabled
  kms_key_id = var.redis-standlone-config.kms_key_id
  multi_az_enabled=var.redis-standlone-config.multi_az_enabled
  apply_immediately=var.redis-standlone-config.apply_immediately
  subnet_group_name = aws_elasticache_subnet_group.redis-subnet.name
  security_group_ids=[aws_security_group.redis_sg.id,var.default_sgs]
  snapshot_retention_limit =  var.redis-standlone-config.snapshot_retention_limit
  tags={
      Name="${var.environment}-${var.tags.name}"
  }

}

