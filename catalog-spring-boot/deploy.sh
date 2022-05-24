##############################
# Deploy catalog-spring-boot #
##############################

DIRECTORY=`dirname $0`
PROJECT_NAME=$1

cd ${DIRECTORY}

odo project set ${PROJECT_NAME} &> /dev/null

DESCRIBE_COMPONENT=`odo component describe catalog`

if [[ $DESCRIBE_COMPONENT != *"catalog-springboot"* ]]; then
    # not an odo component
    odo create catalog --app coolstore
fi

odo push

echo "Catalog Spring-Boot Deployed"
