docker build -t shafik/multi-client:latest -t shafik/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t shafik/multi-server:latest -t shafik/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t shafik/multi-worker:latest -t shafik/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shafik/multi-client:latest
docker push shafik/multi-server:latest
docker push shafik/multi-worker:latest

docker push shafik/multi-client:$SHA
docker push shafik/multi-server:$SHA
docker push shafik/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shafik/multi-server:$SHA
kubectl set image deployments/client-deployment client=shafik/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=shafik/multi-worker:$SHA