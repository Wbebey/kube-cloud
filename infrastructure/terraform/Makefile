# Make file to run easyly things you need

SHELL = /bin/bash

prod-init:
	terraform fmt -write=true -recursive && \
	terraform init -upgrade

prod-plan:
	terraform fmt -write=true -recursive && \
	terraform init && \
	terraform plan -var-file=./secrets/kube-cloud/secrets.tfvars 

prod-apply:
	terraform fmt -write=true -recursive && \
	terraform init && \
	terraform apply -var-file=./secrets/kube-cloud/secrets.tfvars 

.PHONY: prod-init prod-plan prod-apply