# run deployment files
kubectl apply -f mysql-deployment.yml
kubectl apply -f mysql-service.yml

kubectl apply -f app-deployment.yml
kubectl apply -f app-service.yml




# list the deployments
sleep 10
kubectl get deployments

# list the cluster ip
minikube ip