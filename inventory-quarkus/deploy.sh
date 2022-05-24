##############################
#  Deploy inventory-quarkus  #
##############################

# CONTEXT_FOLDER=/projects/workshop/inventory-quarkus
DIRECTORY=`dirname $0`
PROJECT_NAME=$1

cd ${DIRECTORY}

odo project set ${PROJECT_NAME} &> /dev/null

DESCRIBE_COMPONENT=`odo component describe inventory`

if [[ $DESCRIBE_COMPONENT != *"inventory-quarkus"* ]]; then
    # not an odo component
    odo create inventory --app coolstore
fi

odo push

echo "Inventory Quarkus Deployed"