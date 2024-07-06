# Nodejs Hello World Application Deployment using GitOps

## Tools & Technology Used:
- Docker
- DockerHub
- ArgoCD
- Helm
- Kustomize
- Terraform
- Minikube
- GitHub Actions
- Nodejs

## For Creating similar Architecture follow the below steps

### Below are the article/document Links to install the required tools
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Docker](https://docs.docker.com/engine/install/)
- [ArgoCD](https://argo-cd.readthedocs.io/en/stable/cli_installation/)
- [Helm](https://helm.sh/docs/intro/install/)
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Flinux%2Fx86-64%2Fstable%2Fbinary+download)

### Steps to Setup the project

- **Clone the repo**
```bash
git clone https://github.com/sanket363/nodejs-helloWorldApp-on-K8s.git
```
The repository contains the GitHub Actions which build and push the docker image to DockerHub. For the repo to build and push the image to the DockerHub. Add secrets for your repo follow [this article](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions) to create the secrets for the actions.

Below are the two secrets you need to create
```DOCKER_PASSWORD``` ```DOCKER_USER``` with specific values for it that is your dockerhub repo and [access token](https://docs.docker.com/security/for-developers/access-tokens/) for the same.

- **For building image and running it using docker can follow the below commands**
```bash
docker build -t nodejs-app:<version> .
```
```bash
docker run -d -p 3000:3000 nodejs-app:<version>
```

- Start the minikube cluster
```bash
minikube start
```

- Navigate to Terraform Folder

Run below Commands for setting up the argocd and image-updater using terraform
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

- Forwarding the argocd port to access over the localhost 8080 port
```bash
kubectl -n argocd port-forward svc/argocd-server -n argocd 8080:443
```

- Now navigate to nodejs-app folder and apply the application.yaml file
```bash
kubectl apply -f application.yaml -n stagging
```

Once applied you will need to apply the svc file as for this application to be navigated over local system navigate to nodejs-app/my-app-base and apply the svc file

```bash
kubectl apply -f service.yaml -n stagging
```

Now navigate to node ip address and the nodeport of the running svc of the application

## Working of the Project

**Once you commit your changes to GitHub, the GitHub Actions workflow will be triggered. This workflow automates the following steps**:

Docker Image Creation:

- The workflow builds a new Docker image from your application's source code.

Docker Image Push:

- The newly built Docker image is then pushed to DockerHub, your container image repository.

Continuous Deployment with ArgoCD:

- ArgoCD, an open-source GitOps continuous delivery tool, detects the new image available on DockerHub.

Kubernetes Deployment:

- Upon detecting the new image, ArgoCD updates the running application in your Kubernetes (minikube) cluster by pulling the latest image.
- The application is then seamlessly restarted with the new image, ensuring your Kubernetes cluster always runs the most recent version of your application.
- This automated process ensures efficient and consistent updates to your application, reducing manual intervention and minimizing the risk of deployment errors.

## Implementation

![image](https://github.com/sanket363/nodejs-helloWorldApp-on-K8s/assets/98816965/932beb75-728c-4abf-959d-442e8961741d)

![image](https://github.com/sanket363/nodejs-helloWorldApp-on-K8s/assets/98816965/8d0ab8e1-ec09-4681-8848-81732fb7416d)

![image](https://github.com/sanket363/nodejs-helloWorldApp-on-K8s/assets/98816965/21a12a3a-1935-47d0-88ea-fb6c94d04558)

![image](https://github.com/sanket363/nodejs-helloWorldApp-on-K8s/assets/98816965/a8044aa3-f986-4284-bffd-6915ff9dab12)
