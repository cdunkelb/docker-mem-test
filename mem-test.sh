#!/bin/bash
SLEEP_TIME=10

echo '---baseline memory usage, clean up any stack left over---'
docker stack rm test-mem
docker info |grep -i reserve

echo '---deploy stack with limit 2gig reserive 1gig, 10 replicas---'
docker stack deploy -c test-mem-stack.yml test-mem
sleep $SLEEP_TIME
docker service ps test-mem_web
docker info |grep -i reserve
docker stack rm test-mem
docker stack rm test-mem

echo '---deploy stack with 1gig reservation only, 10 replicas---'
echo '---baseline mem ---';docker info |grep -i reserve
docker stack deploy -c test-mem-stack-reserve-only.yml test-mem
sleep $SLEEP_TIME
docker service ps test-mem_web
echo '---post-deploye mem---'; docker info |grep -i reserve
docker stack rm test-mem
docker stack rm test-mem

echo '---deploy stack with 2gig limit only, 10 replicas---'
echo '---baseline mem ---';docker info |grep -i reserve
docker stack deploy -c test-mem-stack-limit-only.yml test-mem
sleep $SLEEP_TIME
docker service ps test-mem_web
echo '---post-deploye mem---'; docker info |grep -i reserve
echo '---cleaning up---'
docker stack rm test-mem
docker stack rm test-mem


