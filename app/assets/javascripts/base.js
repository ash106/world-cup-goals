var myApp = angular.module('myApp', []);
myApp.controller('MainCtrl', function($scope, $http){
  $http.get('goals.json').success(function(data){
    $scope.data = data;
  }).error(function(err){
    throw err;
  });
});
myApp.directive('barChart', function(){
  function link(scope, element, attr){
    el = element[0]
    var width = 500
    var height = 20
    var svg = d3.select(el).append('svg')
      .attr({width: width, height: height})
      .style('border', '1px solid black');

    // the inner progress bar `<rect>`
    var rect = svg.append('rect').style('fill', 'blue');

    scope.$watch('games', function(games){
      if(!scope.data){
        rect.attr({x: 0, y: 0, width: 0, height: height });
      } else {
        rect.attr({x: 0, y: 0, width: width * scope.data.goals[2010][games-1] / 145, height: height });
        console.log(scope.data.goals[2010][games-1]);
      }
    });
    scope.$watch('data', function(data){
      console.log(data);
    }, true);
  }
  return {
    link: link,
    restrict: 'E',
    scope: { data: '=', games: '='}
  };
});
