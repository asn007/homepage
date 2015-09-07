PageController = ($scope, $rootScope, pageSource) ->
  $scope.contentVisible = false
  $scope.page = pageSource.data
  $rootScope.$on 'command typed', (evt, args) ->
    if args == $scope.page.command
      $scope.contentVisible = true
  $rootScope.typeCommand $scope.page.command

Homepage.controller('PageController', ['$scope', '$rootScope', 'pageSource', PageController])