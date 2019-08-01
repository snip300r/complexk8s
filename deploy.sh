docker build -t shafik/complexk8s-client:latest -t shafik/complexk8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t shafik/complexk8s-server:latest -t shafik/complexk8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t shafik/complexk8s-worker:latest -t shafik/complexk8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push shafik/complexk8s-client:latest
docker push shafik/complexk8s-client:$SHA

docker push shafik/complexk8s-server:latest
docker push shafik/complexk8s-server$SHA

docker push shafik/complexk8s-worker:latest
docker push shafik/complexk8s-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shafik/complexk8s-server:$SHA
kubectl set image deployments/client-deployment client=shafik/complexk8s-client:$SHA
kubectl set image deployments/worker-deployment worker=shafik/complexk8s-worker:$SHA
