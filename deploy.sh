docker build -t ethnopunk/multi-client:latest -t ethnopunk/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ethnopunk/multi-server:latest -t ethnopunk/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ethnopunk/multi-worker:latest -t ethnopunk/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ethnopunk/multi-client:latest
docker push ethnopunk/multi-server:latest
docker push ethnopunk/multi-worker:latest

docker push ethnopunk/multi-client:$SHA
docker push ethnopunk/multi-server:$SHA
docker push ethnopunk/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ethnopunk/multi-client:$SHA
kubectl set image deployments/server-deployment server=ethnopunk/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=ethnopunk/multi-worker:$SHA