docker build -t arorakshitij2/multi-client:latest -t arorakshitij2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t arorakshitij2/multi-server:latest -t arorakshitij2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t arorakshitij2/multi-worker:latest -t arorakshitij2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push arorakshitij2/multi-client:latest
docker push arorakshitij2/multi-server:latest
docker push arorakshitij2/multi-worker:latest

docker push arorakshitij2/multi-client:$SHA
docker push arorakshitij2/multi-server:$SHA
docker push arorakshitij2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=arorakshitij2/multi-server:$SHA
kubectl set image deployments/client-deployment client=arorakshitij2/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=arorakshitij2/multi-worker:$SHA