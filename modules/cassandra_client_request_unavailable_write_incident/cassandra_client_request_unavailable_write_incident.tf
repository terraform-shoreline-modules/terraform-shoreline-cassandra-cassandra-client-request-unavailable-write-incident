resource "shoreline_notebook" "cassandra_client_request_unavailable_write_incident" {
  name       = "cassandra_client_request_unavailable_write_incident"
  data       = file("${path.module}/data/cassandra_client_request_unavailable_write_incident.json")
  depends_on = [shoreline_action.invoke_cassandra_cluster_check]
}

resource "shoreline_file" "cassandra_cluster_check" {
  name             = "cassandra_cluster_check"
  input_file       = "${path.module}/data/cassandra_cluster_check.sh"
  md5              = filemd5("${path.module}/data/cassandra_cluster_check.sh")
  description      = "Check the Cassandra cluster for any nodes that are unavailable or experiencing high load, and take appropriate action to restore them or migrate their workload to other nodes."
  destination_path = "/agent/scripts/cassandra_cluster_check.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cassandra_cluster_check" {
  name        = "invoke_cassandra_cluster_check"
  description = "Check the Cassandra cluster for any nodes that are unavailable or experiencing high load, and take appropriate action to restore them or migrate their workload to other nodes."
  command     = "`chmod +x /agent/scripts/cassandra_cluster_check.sh && /agent/scripts/cassandra_cluster_check.sh`"
  params      = []
  file_deps   = ["cassandra_cluster_check"]
  enabled     = true
  depends_on  = [shoreline_file.cassandra_cluster_check]
}

