#!/usr/bin/env bash


docker build -t dzontak/multi-client:latest -t dzontak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dzontak/multi-server:latest -t dzontak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dzontak/multi-worker:latest -t dzontak/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dzontak/multi-client:latest
docker push dzontak/multi-server:latest
docker push dzontak/multi-worker:latest

docker push dzontak/multi-client:$SHA
docker push dzontak/multi-server:$SHA
docker push dzontak/multi-worker:$SHA

kubectl apply -f ./k8s

kubeclt set image deployments/server-deployment server=dzontak/multi-server:$SHA
kubeclt set image deployments/client-deployment client=dzontak/multi-client:$SHA
kubeclt set image deployments/worker-deployment worker=dzontak/multi-worker:$SHA




