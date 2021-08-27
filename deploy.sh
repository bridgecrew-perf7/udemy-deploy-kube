#!/bin/sh

docker build -t wicochandra/udemy-multi-client:$GIT_SHA -t wicochandra/udemy-multi-client:latest -f ./client/Dockerfile ./client
docker build -t wicochandra/udemy-multi-server:$GIT_SHA -t wicochandra/udemy-multi-server:latest -f ./server/Dockerfile ./server
docker build -t wicochandra/udemy-multi-worker:$GIT_SHA -t wicochandra/udemy-multi-worker:latest -f ./worker/Dockerfile ./worker

docker push wicochandra/udemy-multi-client:latest
docker push wicochandra/udemy-multi-server:latest
docker push wicochandra/udemy-multi-worker:latest

docker push wicochandra/udemy-multi-client:$GIT_SHA
docker push wicochandra/udemy-multi-server:$GIT_SHA
docker push wicochandra/udemy-multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=wicochandra/udemy-multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=wicochandra/udemy-multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=wicochandra/udemy-multi-worker:$GIT_SHA
