'use strict';

var module = angular.module('app', ['ngRoute']), auth = {
    loggedIn: false,
    ssoEnabled: false,
    logout: function () {
    }
};

module.factory('Auth', function () {
    return auth;
});