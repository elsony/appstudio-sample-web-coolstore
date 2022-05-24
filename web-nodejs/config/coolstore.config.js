const { ContextExclusionPlugin } = require("webpack");

var config = {
    API_ENDPOINT: process.env.URL_PREFIX + process.env.OPENSHIFT_BUILD_NAMESPACE,
    SECURE_API_ENDPOINT: 'secure-' + process.env.URL_PREFIX + process.env.SECURE_COOLSTORE_GW_SERVICE,
    SSO_ENABLED: process.env.SSO_URL ? true : false
};

if (process.env.DEVWORKSPACE_ID != null) {
    config.API_ENDPOINT = process.env.DEVWORKSPACE_ID + '-2'
} else if (process.env.COOLSTORE_GW_ENDPOINT != null) {
    config.API_ENDPOINT = process.env.COOLSTORE_GW_ENDPOINT;
} else if (process.env.COOLSTORE_GW_SERVICE != null) {
    config.API_ENDPOINT = process.env.COOLSTORE_GW_SERVICE + '-' + process.env.OPENSHIFT_BUILD_NAMESPACE;
}


if (process.env.SECURE_COOLSTORE_GW_ENDPOINT != null) {
    config.SECURE_API_ENDPOINT = process.env.SECURE_COOLSTORE_GW_ENDPOINT;
} else if (process.env.SECURE_COOLSTORE_GW_SERVICE != null) {
    config.SECURE_API_ENDPOINT = process.env.SECURE_COOLSTORE_GW_SERVICE + '-' + process.env.OPENSHIFT_BUILD_NAMESPACE;
}
module.exports = config;
