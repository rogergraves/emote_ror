   function renderBarChart(config){
        var categories = [];
        var data = [];
        for (var key in config) {
            var currentCfg = config[key];
            var obj = {y: parseInt(currentCfg.value), color: colors[currentCfg.color], name: currentCfg.name}
            data.push(obj);
            categories.push(currentCfg.name.toUpperCase());
        }

        var chart = new Highcharts.Chart({
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
                         document.getElementById('see_all_comments').style.visibility = 'visible';
                         renderPieChart(configPie);
                         doAjax({
                             data: {name: cfg.name},
                             url: '/survey_results/verbatims.json',
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
    }

   function renderPieChart(pieConfig){
        var pieData = [];

        var intTotalResponsesCount = 0;
        for (var key in pieConfig){
            var val = pieConfig[key];
            var obj = {name: intensity[key], y: parseInt(val), color: pieColors[key]};
            intTotalResponsesCount+= parseInt(val);
            if (obj.name) pieData.push(obj);
        }

        var pieChart = new Highcharts.Chart({
              exporting: {enabled: false},
              credits: {enabled: false},
              chart: {
                 renderTo: 'pieChart',
                 plotBackgroundColor: null,
                 plotBorderWidth: null,
                 plotShadow: false
              },
              legend: {layout: 'vertical'},
           //legend: {enabled: false},
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
                             $('#emotionLabel').html(strCategoryLabel + this.config.name);
                             document.getElementById('see_all_comments').style.visibility = 'visible';
                             doAjax({
                                 url: '/survey_results/verbatims.json',
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
   }

   function filterVerbatim(text){
        document.getElementById('see_all_comments').style.visibility = 'visible';
        doAjax({
             url: '/survey_results/verbatims.json',
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
   }

   /**
     * @param config.data - data to be sent to server
     * @param config.successCallback - function to call on success
     * @param config.errorCallback - function to call on failure
     */
   function doAjax(config){
       var strAjaxUrl = '/survey_results/verbatims.json';

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
   }
