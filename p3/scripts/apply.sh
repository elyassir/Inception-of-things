kubectl apply -f ../confs/application.yaml


# Port forward to access the application
# kubectl port-forward service/playground-service 8888:8888 -n dev &

# Curl to test the application
# curl http://localhost:8888