# Capstone Project

Develop a CI/CD pipeline for microservice application with blue/green deployment and continuous integration with docker and kubernetes clusters.

## Following steps are taken to complete the project:
* Launch a EC2 Instance
  - AMI: Ubuntu Server 18.04 LTS
* Install the dependencies
  - jenkins
  - docker
  - tidy
  - AWS CLI
  - kubectl
  - eksctl
* Install plugins in Jenkins
  - blueocean
  - pipeline aws steps
  - kubernetes
* Build CICD pipeline
  - build docker image and push the image in docker repository
  - build kubernetes clusters

## Pipeline
![](Jenkins_Pipeline.png)
