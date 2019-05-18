SHELL := /usr/bin/env bash
ssh-key:
	test ! -f ~/.ssh/teamcity.pub && ssh-keygen -t rsa -C 'teamcity' -P '' -f ~/.ssh/teamcity && chmod 400 ~/.ssh/teamcity.pub

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply

auto-apply:
	terraform apply -auto-approve

refresh:
	terraform refresh
