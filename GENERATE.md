```bash
sudo apt update
sudo apt install default-jre

wget https://repo1.maven.org/maven2/org/openapitools/openapi-generator-cli/7.5.0/openapi-generator-cli-7.5.0.jar -O openapi-generator-cli.jar

java -jar openapi-generator-cli.jar generate \
  -i spec/fixtures/v1/openapi.json \
  -g ruby \
  -o ./vendor/v1 \
  --skip-validate-spec \
  --global-property models \
  --additional-properties=moduleName=V1,modelNameSuffix=""
```
