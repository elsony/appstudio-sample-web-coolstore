##########################
#  Deploy all components #
##########################

PROJECT_NAME=$1

echo "creating namespace: ${PROJECT_NAME}"
oc new-project $PROJECT_NAME

PROJECT_DIR=`dirname $0`

if [[ $DEVWORKSPACE_NAMESPACE == "che-che" ]]; then
    PROJECT_DIR=${PROJECTS_SOURCE}/web-coolstore
    odo preference set ConsentTelemetry false --force &> /dev/null
fi

echo "deploying catalog component"
cd $PROJECT_DIR/catalog-spring-boot && ./deploy.sh $PROJECT_NAME

echo "deploying inventory component"
cd $PROJECT_DIR/inventory-quarkus && ./deploy.sh $PROJECT_NAME

echo "deploying gateway component"
cd $PROJECT_DIR/gateway-vertx && ./deploy.sh $PROJECT_NAME

echo "deploying web-ui component"
cd $PROJECT_DIR/web-nodejs && ./deploy.sh $PROJECT_NAME
