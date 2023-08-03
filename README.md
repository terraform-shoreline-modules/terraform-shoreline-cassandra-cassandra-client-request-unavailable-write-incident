
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Cassandra client request unavailable write incident.
---

The Cassandra client request unavailable write incident occurs when the software's client application is unable to write data to the Cassandra database. This incident can occur due to various reasons such as network issues, configuration issues, or availability problems with the Cassandra nodes. This incident can cause significant disruptions in the software's functionality and must be resolved quickly to avoid any data loss or downtime.

### Parameters
```shell
# Environment Variables

export KEYSPACE="PLACEHOLDER"

export TABLE="PLACEHOLDER"

export CASSANDRA_CLUSTER_IP_ADDRESS="PLACEHOLDER"

```

## Debug

### Check if Cassandra is running
```shell
systemctl status cassandra
```

### Check if there are any nodes unavailable
```shell
nodetool status
```

### Check if there are any read failures
```shell
nodetool cfstats
```

### Check the disk usage of the nodes
```shell
nodetool tablestats ${KEYSPACE}.${TABLE}
```

### Check if the Cassandra client is installed and running
```shell
which cassandra-cli && cassandra-cli
```

### Check the Cassandra client logs for any errors
```shell
tail -f /var/log/cassandra/system.log
```

### Check the network connection between the client and the Cassandra cluster
```shell
ping ${CASSANDRA_CLUSTER_IP_ADDRESS}
```

### Check if the client is able to connect to the Cassandra cluster
```shell
cqlsh ${CASSANDRA_CLUSTER_IP_ADDRESS}
```

### Check if the client is able to write to the Cassandra cluster
```shell
cqlsh ${CASSANDRA_CLUSTER_IP_ADDRESS} -e "INSERT INTO ${KEYSPACE}.${TABLE} (column1, column2) VALUES ('value1', 'value2')"
```
## Repair

### Check the Cassandra cluster for any nodes that are unavailable or experiencing high load, and take appropriate action to restore them or migrate their workload to other nodes.
```shell

#!/bin/bash

# Define the Cassandra cluster endpoint

CASSANDRA_ENDPOINT="PLACEHOLDER"

# Check the status of all nodes in the cluster

nodetool status $CASSANDRA_ENDPOINT

# Identify any nodes that are experiencing high load or are unavailable

unavailable_nodes=$(nodetool status $CASSANDRA_ENDPOINT | grep -E "DN|^-|^ ")

echo "Unavailable nodes: $unavailable_nodes"

# If there are unavailable nodes, restore them or migrate their workload to other nodes

if [ -n "$unavailable_nodes" ]; then

    # Restore the nodes

    nodetool repair $CASSANDRA_ENDPOINT

    # Migrate the workload to other nodes

    nodetool cleanup $CASSANDRA_ENDPOINT

fi

# Verify that the cluster is fully functional

nodetool describecluster $CASSANDRA_ENDPOINT


```