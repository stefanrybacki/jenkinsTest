#!/bin/bash
set -e
aws configure set aws_secret_access_key $AWS_ID_PSW 
aws configure set aws_access_key_id $AWS_ID_USR 
aws configure set default.region eu-west-1 
aws configure set default.output json 

# check aws
echo "Checking AWS setup"
aws s3 ls s3://roland-develop-limbus-medtec-test-filebucket



