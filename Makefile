
all: provisioning package deploy

provisioning: remote-resources/lamb1-role-arn
remote-resources/lamb1-role-arn:
	aws iam delete-role --role-name lamb1
	aws iam create-role --role-name lamb1 --assume-role-policy-document file://lamb1.json --query "Role.Arn" --output text > remote-resources/lamb1-role-arn

package:
	cd src && zip -r ../simple-package.zip simple.js

deploy: provisioning
	aws lambda create-function \
		--function-name SimpleLambda \
		--role `cat remote-resources/lamb1-role-arn` \
		--runtime nodejs6.10 \
		--handler simple.handler \
		--zip-file fileb://simple-package.zip \
		--query "FunctionArn" \
		--output text

invoke:
	aws lambda invoke \
		--invocation-type RequestResponse \
		--function-name SimpleLambda \
		--region eu-west-1 \
		--log-type Tail \
		--payload '{"key1":"value1", "key2":"value2", "key3":"value3"}' \
		out.json

.PHONY: provisioning remote-resources package deploy



