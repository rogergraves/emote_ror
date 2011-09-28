   emote = {};
   emote.scorecard = (function() {
      // Private members.

      var colors = {'green': '#689839', 'red': '#ca3437', white: '#FFFFFF', grey: '#CCCCCC'};
	   var intensity = {pp: 'enthusiasts', mn: 'indifferent', pn:'detractors'};
	   var pieColors = {pp: '#0db5d4', mn: '#cccccc', pn: '#eeae01'};

      var verbatimUrl = '/survey_results/verbatims.json';
      var chartsUrl = '/survey_results/charts.json';

      var barChartConfig = {};
      var pieChartConfig = {};

      var barChart = null;
      var pieChart = null;

      // a flag to track if a pie chart has ever been clicked
      var pieSectorClicked = false;

      function initBarChart (){
            var categories = [];
            var data = [];
            for (var key in barChartConfig) {
               var currentCfg = barChartConfig[key];
               var obj = {y: parseInt(currentCfg.value), color: colors[currentCfg.color], name: currentCfg.name}
               data.push(obj);
               categories.push(currentCfg.name.toUpperCase());
            }

            barChart = new Highcharts.Chart({
            credits: {enabled: false},
            exporting: {enabled: false},
            chart: {
            renderTo: 'barChart',
            type: 'column',
            height: 280,
            width: 640
            },
            title: {text: ''},
            xAxis: {
            categories: categories,
            labels: {
               rotation: -90,
               align: 'right',
               style: {font: 'normal 11px Verdana, sans-serif'}
            }
            },
            yAxis: {
            min: 0,
            gridLineColor: '',
            title: {text: '' },
            labels: {enabled: false}
            },

            plotOptions: {
                column: {
                   shadow: false,
                   cursor: 'pointer',
                   point: {
                      events: {
                         click: function() {
                            var cfg = this.config;
                            $('#emotionLabel').html(strEmotionLabel + cfg.name);
                            setVisible("see_all_comments", true);
                            emote.scorecard.redrawPieChart();
                            
                            emote.scorecard.doAjax({
                                data: {name: cfg.name},
                                url: verbatimUrl,
                                successCallback: function (response, textStatus) {
                                var data = jQuery.parseJSON(response);
                                loadComments(data);
                             },
                                errorCallback: function(request, textStatus, errorThrown){
                                 console.log(errorThrown);
                                 throw new Error('error fetching verbatims for a pointer');
                             }
                            });
                         }
                      }
                   }
                }
            },
            legend: {enabled: false},
            tooltip: {
            enabled: false
            },
            series: [{
               pointWidth: 30,
               name: '',
               data: data,
               dataLabels: {
                  enabled: true,
                  color: '#000000',
                  align: 'right',
                  x: -10,
                  y: -5,
                  formatter: function() {
                      return this.y;
                   },
                  style: {font: 'normal 10px Verdana, sans-serif'}
                }
               }]
            });
            return barChart;
         }

      function initPieChart (){
        var pieData = [];

        var intTotalResponsesCount = 0;
        for (var key in pieChartConfig){
            var val = pieChartConfig[key];
            var obj = {name: intensity[key], y: parseInt(val), color: pieColors[key]};
            intTotalResponsesCount+= parseInt(val);
            if (obj.name) pieData.push(obj);
        }

         pieChart = new Highcharts.Chart({
              exporting: {enabled: false},
              credits: {enabled: false},
              chart: {
                 renderTo: 'pieChart',
                 plotBackgroundColor: null,
                 plotBorderWidth: null,
                 plotShadow: false
              },
              legend: {layout: 'vertical'},
              title: {text: ''},
              tooltip: {
                 formatter: function() {
                    var pct = this.y/intTotalResponsesCount * 100;
                    return '<b>'+ this.point.name +'</b>: '+ this.y +' responses (' + pct.toFixed(2) + '%)';

                 }
              },
              plotOptions: {
                 pie: {
                    size: 180,
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {enabled: false},
                    showInLegend: true,
                    point: {
                       events: {
                          click: function() {
                             emote.scorecard.setPieSectorClicked(true);

                             $('#emotionLabel').html(strCategoryLabel + this.config.name);
                             setVisible("see_all_comments", true);
                             emote.scorecard.doAjax({
                                 url: verbatimUrl,
                                 data: {subset: this.config.name},
                                 successCallback: function (response, textStatus) {
                                  var data = jQuery.parseJSON(response);
                                  loadComments(data);
                               },
                               errorCallback: function(request, textStatus, errorThrown){
                                  throw new Error('error fetching verbatims for a pie');
                                  console.log(errorThrown);
                               }
                             });
                          }
                       }
                    }
                 }
              },
               series: [{
                 type: 'pie',
                 name: 'Barometer',
                 data: pieData
              }]
           });
        var strTotal = "<table style='margin-left:100px;'><tr><td style='font-size:35px; font-weight: bold;'>";
        strTotal += intTotalResponsesCount+"</td><td>&nbsp;&nbsp;&nbsp;</td><td style='vertical-align:middle;'> TOTAL <br/>RESPONSES</td></tr></table>";
        $('#totalResp').html(strTotal);
      return pieChart;
   }

      return { // Public members.
         init: function (cfg){
            barChartConfig = cfg.barChartConfig;
            pieChartConfig = cfg.pieChartConfig;
         },
         getBarChart: function () {
            if (barChart) return barChart;
            return initBarChart();
         },
         getPieChart: function () {
            if (pieChart) return pieChart;
            return initPieChart();
         },
         getPieSectorClicked: function () {
            return pieSectorClicked;
         },
         setPieSectorClicked: function (bool) {
            pieSectorClicked = bool;
         },
         redrawPieChart: function () {
            if (pieSectorClicked){
               initPieChart();
               pieSectorClicked = false;
            }
         },

         redrawBarChart: function () {
            initBarChart();
         },

         /**
                 * @param config.data - data to be sent to server
                 * @param config.successCallback - function to call on success
                 * @param config.errorCallback - function to call on failure
                 */
         doAjax: function (config){
             var strAjaxUrl = verbatimUrl;

             if (!config.data) config.data = {};
             config.data.survey = survey['code'];
             config.data.action_token = '';
             config.data.session = '';
             $.ajax({
                 type: "GET",
                 url: config.url || strAjaxUrl,
                 dataType: "html",
                 data: config.data,
                 cache: false,
                 success: config.successCallback ,
                 error: config.errorCallback
              });
         },
         
         filterVerbatim: function (text){
           document.getElementById('see_all_comments').style.visibility = 'visible';
           emote.scorecard.doAjax({
                url: verbatimUrl,
                data: {filter: $('#txtCommentFilter').val()},
                successCallback: function (response, textStatus) {
                var data = jQuery.parseJSON(response);
                loadComments(data);
              },
                errorCallback: function(request, textStatus, errorThrown){
                 console.log(errorThrown);
                  throw new Error('error filtering verbatims');
              }
            });
         },

         initChartsFromServer: function () {
            emote.scorecard.doAjax({
                url: chartsUrl,
                data: {},
                successCallback: function (response, textStatus) {
                var data = jQuery.parseJSON(response);
                emote.scorecard.init({
                     barChartConfig: data.bars,
                     pieChartConfig: data.pie
                });
                emote.scorecard.redrawPieChart();
                emote.scorecard.redrawBarChart();
              },
                errorCallback: function(request, textStatus, errorThrown){
                 console.log(errorThrown);
                  throw new Error('error loading charts from server');
              }
            });
         }
      };
   })();

   function setVisible (elementID, bShow){
      document.getElementById(elementID).style.visibility = bShow ? 'visible' : 'hidden';
   }