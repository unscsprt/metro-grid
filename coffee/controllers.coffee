'use strict'

metroApp = angular.module('metroApp', [])

metroApp.controller('StationListCtrl', ($scope, $http) ->
    $http.jsonp('http://api.wmata.com/StationPrediction.svc/json/GetPrediction/All?api_key=kfgpmgvfgacx98de9q3xazww&callback=JSON_CALLBACK').success (data, status) ->
        stations = {}

        for train in data['Trains']
            # get location, line, and min of current train
            location = train['LocationName']
            line = train['Line']
            min = train['Min']

            # add current train's station to stations dict if not already
            if not (location of stations)
                stations[location] = {}

            # add cur line to cur train's station in station's dict
            if not (line of stations[location])
                stations[location][line] = {}

            # add cur train's destination and time
            stations[location][line][train['DestinationName']] = min

        console.log stations
        $scope.stations = stations

    $scope.bla = "stuff"
)