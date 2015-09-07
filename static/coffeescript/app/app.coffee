window.jQuery = require 'jquery'
window._ = require 'lodash'
require 'angular'
require 'angular-animate'
require 'angular-ui-router'
require 'angular-bootstrap'

window.PARTIALS_URL = '/partials/'
window.AJAX_API_URL = '/ajax/'


window.Homepage = angular.module('Homepage', ['ui.router', 'ngAnimate', 'ui.bootstrap'])

require './animations/slide.coffee'
require './animations/jsfade.coffee'

require './controllers/general.coffee'

Homepage.controller 'ApplicationController', ($scope, $rootScope, $timeout, $http, $interval) ->
  $rootScope.messages = {}
  $rootScope.addNotification = (message) ->
    id = Math.random()
    $rootScope.messages[id] = message
    $timeout () ->
      delete $rootScope.messages[id]
    , 3000

  $rootScope.curtain = true

  $rootScope.renderedTypedText = ''

  $rootScope.typeCommand = (text, typeSpeed) ->
    if not typeSpeed
      typeSpeed = 35
    if not text
      return
    $rootScope.renderedTypedText = ''
    arr = text.split('');
    intervalId = $interval(() ->
      if arr.length <= 0
        $interval.cancel(intervalId)
        $rootScope.$broadcast 'command typed', text
      else
        $rootScope.renderedTypedText += arr.shift()
    , typeSpeed);


  $scope.init = () ->
    $rootScope.curtain = false

  $scope.init()

Homepage.factory 'MessageInterceptor', MessageInterceptor = ($rootScope, $window) ->
  processData = (response) ->
    if response != null and response != undefined and response.data
      if response.data.message
        $rootScope.addNotification response.data.message
      if response.data.url
        $window.location.href = response.data.url
    return response
  return {
  response: (response) ->
    return processData response
  responseError: (response) ->
    return processData response
  }

Homepage.config ($httpProvider, $stateProvider, $urlRouterProvider) ->
  $httpProvider.interceptors.push MessageInterceptor
  $urlRouterProvider.when '/', '/index'
  $urlRouterProvider.when '', '/index'
  $urlRouterProvider.otherwise '/index'
  $stateProvider.state('page', {
    url: '/page/:name'
    templateUrl: "#{PARTIALS_URL}/page"
    controller: 'PageController'
    resolve: {
      pageSource: ($stateParams, $http) ->
        $http.get "#{AJAX_API_URL}pages/#{$stateParams.id}"
    }
  }).state('portfolio', {
    url: '/portfolio'
    templateUrl: "#{PARTIALS_URL}/portfolio"
    controller: 'PortfolioController'

  })

