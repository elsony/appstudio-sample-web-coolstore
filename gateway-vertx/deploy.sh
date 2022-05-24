##########################
#  Deploy gateway-vertx  #
##########################

DIRECTORY=`dirname $0`
PROJECT_NAME=$1
OPERATORS=$(oc get subscription -n openshift-operators)

cd ${DIRECTORY}

APP_SUFFIX="-coolstore"

if [[ $DEVWORKSPACE_NAMESPACE != "" ]]; then
    APP_SUFFIX=""
fi

odo project set ${PROJECT_NAME} &> /dev/null

DESCRIBE_COMPONENT=`odo component describe gateway`
if [[ $DESCRIBE_COMPONENT != *"gateway-vertx"* ]]; then
    # not an odo component
    odo create gateway --app coolstore
fi

if [ "$OPERATORS" = *"rh-service-binding-operator"* ]; then
    # unlink existing services if exist
    odo unlink catalog &> /dev/null
    odo unlink inventory &> /dev/null

    # link inventory and catalog services
    odo push
    odo link inventory
    odo link catalog
    odo push
else
    # unset existing Envs if exist
    odo config unset --env CATALOG_COOLSTORE_SERVICE_HOST --env CATALOG_COOLSTORE_SERVICE_PORT &> /dev/null
    odo config unset --env INVENTORY_COOLSTORE_SERVICE_HOST --env INVENTORY_COOLSTORE_SERVICE_PORT &> /dev/null

    # set envs to link inventory and catalog services
    CATALOG_HOST=$(oc get svc catalog${APP_SUFFIX} -o jsonpath={.spec.clusterIP})
    CATALOG_PORT=$(oc get svc catalog${APP_SUFFIX} -o jsonpath={.spec.ports[].port})
    INVENTORY_HOST=$(oc get svc inventory${APP_SUFFIX} -o jsonpath={.spec.clusterIP})
    INVENTORY_PORT=$(oc get svc inventory${APP_SUFFIX} -o jsonpath={.spec.ports[].port})

    odo config set --env CATALOG_COOLSTORE_SERVICE_HOST=$CATALOG_HOST --env CATALOG_COOLSTORE_SERVICE_PORT=$CATALOG_PORT
    odo config set --env INVENTORY_COOLSTORE_SERVICE_HOST=$INVENTORY_HOST --env INVENTORY_COOLSTORE_SERVICE_PORT=$INVENTORY_PORT
    
    odo push
fi


echo "Gateway Vertx Deployed"