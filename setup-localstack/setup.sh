#!/bin/bash

set -e

echo "Zipando Lambda callback"
cd /tmp/lambdas/callback
zip -r /tmp/callback-lambda.zip .

echo "Criando Lambda"
awslocal lambda create-function \
  --function-name callback-lambda \
  --runtime nodejs18.x \
  --handler index.handler \
  --zip-file fileb:///tmp/callback-lambda.zip \
  --role arn:aws:iam::000000000000:role/lambda-role

echo "Zipando Lambda post-callback"
cd /tmp/lambdas/post-callback
zip -r /tmp/post-callback-lambda.zip .


awslocal lambda create-function \
  --function-name post-callback-lambda \
  --runtime nodejs18.x \
  --handler index.handler \
  --zip-file fileb:///tmp/post-callback-lambda.zip \
  --role arn:aws:iam::000000000000:role/lambda-role

echo "Criando Step Function"
awslocal stepfunctions create-state-machine \
  --name MinhaCallbackStepFunction \
  --role-arn arn:aws:iam::000000000000:role/stepfunctions-role \
  --definition file:///etc/localstack/init/ready.d/state-machine-definition.json

