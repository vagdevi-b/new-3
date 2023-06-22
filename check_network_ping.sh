CONTAINER_1="nginx-cont"
CONTAINER_2="mysql_cont"
NETWORK="task-3_my-networkk"

# Check if both containers are in the same network
if docker network inspect -f '{{range .Containers}}{{.Name}}{{end}}' $NETWORK | grep -q "$CONTAINER_1" && 
   docker network inspect -f '{{range .Containers}}{{.Name}}{{end}}' $NETWORK | grep -q "$CONTAINER_2"; then
    echo "Both containers are in the same network."
else
    echo "Containers are not in the same network."
    exit 1
fi

# Check ping from Container 1 to Container 2
if docker exec $CONTAINER_1 ping -c 1 $CONTAINER_2 >/dev/null; then
  echo "Ping from $CONTAINER_1 to $CONTAINER_2 is successful."
else
  echo "Ping from $CONTAINER_1 to $CONTAINER_2 failed."
  exit 1
fi

# Check ping from Container 2 to Container 1
if docker exec $CONTAINER_2 ping -c 1 $CONTAINER_1 >/dev/null; then
  echo "Ping from $CONTAINER_2 to $CONTAINER_1 is successful."
else
  echo "Ping from $CONTAINER_2 to $CONTAINER_1 failed."
  exit 1
fi

