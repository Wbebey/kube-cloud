# Make file to run easyly things you need

SHELL = /bin/bash

prod-init:
	terraform fmt -write=true -recursive && \
	doppler run --name-transformer tf-var -- terraform init -upgrade

prod-plan:
	terraform fmt -write=true -recursive && \
	doppler run --name-transformer tf-var -- terraform init && \
	doppler run --name-transformer tf-var -- terraform plan 

prod-apply:
	terraform fmt -write=true -recursive && \
	doppler run --name-transformer tf-var -- terraform init && \
	doppler run --name-transformer tf-var -- terraform apply 

.PHONY: prod-init prod-plan prod-apply