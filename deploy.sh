#!/usr/bin/env bash

Version="${1:-${SHA}}"

Apps=(
  "client"
  "server"
  "worker"
)

for app in "${Apps[@]}"
do
  docker build \
    -t adminrobert/multi-${app}:latest \
    -t adminrobert/multi-${app}:${Version} \
    -f ./${app}/Dockerfile \
    ./${app}
done

for app in "${Apps[@]}"
do
  docker push adminrobert/multi-${app}:latest
  docker push adminrobert/multi-${app}:${Version}
done

#docker build -t adminrobert/multi-client -f ./client/Dockerfile ./client
#docker build -t adminrobert/multi-server -f ./server/Dockerfile ./server
#docker build -t adminrobert/multi-worker -f ./worker/Dockerfile ./worker

#docker push adminrobert/multi-client
#docker push adminrobert/multi-server
#docker push adminrobert/multi-worker

kubectl apply -f k8s

for app in "${Apps[@]}"
do
  kubectl set image deployments/${app}-deployment ${app}=adminrobert/multi-${app}:${Version}
done
