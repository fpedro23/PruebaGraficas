//
//  ViewController.m
//  PruebaGraficas
//
//  Created by Pedro Contreras Nava on 02/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "ViewController.h"
#import <ShinobiCharts/ShinobiCharts.h>


@interface ViewController () <SChartDatasource>

@end

@implementation ViewController
@synthesize _chart;
@synthesize _diccionario;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _diccionario = @{@"Broccoli" : @5.65, @"Carrots" : @12.6, @"Mushrooms" : @8.4, @"Okra" : @0.6};
    
    
    //Create the display area

    
    // Create the chart
    CGFloat margin = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? 20.0 : 30.0;

    _chart = [[ShinobiChart alloc] initWithFrame:CGRectInset(CGRectMake(0, 450, 768, 600),margin,margin)];
    _chart.title = @"Resumen";
    _chart.autoresizingMask =  ~UIViewAutoresizingNone;
    _chart.BackgroundColor = [UIColor clearColor];
    _chart.PlotAreaBackgroundColor = [UIColor clearColor];
    _chart.CanvasAreaBackgroundColor = [UIColor clearColor];
    
    _chart.BorderColor = [UIColor clearColor];
    
    _chart.PlotAreaBorderColor = [UIColor clearColor];
    _chart.PlotAreaBorderThickness = 0.f;

    // add a pair of axes
    SChartCategoryAxis *xAxis = [[SChartCategoryAxis alloc] init];
    xAxis.style.interSeriesPadding = @0;
    xAxis.enableGesturePanning = YES;
    xAxis.enableGestureZooming = YES;

    xAxis.allowPanningOutOfDefaultRange =YES   ;
    _chart.xAxis = xAxis;
    
    SChartAxis *yAxis = [[SChartNumberAxis alloc] init];
    yAxis.title = @"Inversion (MDP)";
    yAxis.rangePaddingHigh = @1.0;
    yAxis.enableGestureZooming = YES;
    yAxis.enableGesturePanning = YES;
    [yAxis setRangeWithMinimum:@0.5 andMaximum:@15];
    _chart.yAxis = yAxis;
    

    _chart.datasource = self;
    [self.view addSubview:_chart];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SChartDatasource methods

- (NSInteger)numberOfSeriesInSChart:(ShinobiChart *)chart {
    return 1;
}

-(SChartSeries *)sChart:(ShinobiChart *)chart seriesAtIndex:(NSInteger)index {
    SChartColumnSeries *columnSeries = [SChartColumnSeries new];
    columnSeries.selectionMode = SChartSelectionPoint;
    columnSeries.animationEnabled = YES;
    SChartAnimation *animation = [SChartAnimation televisionAnimation];

    columnSeries.entryAnimation = animation;
    
    return columnSeries;
}

- (NSInteger)sChart:(ShinobiChart *)chart numberOfDataPointsForSeriesAtIndex:(NSInteger)seriesIndex {
    return _diccionario.allKeys.count;
}

- (id<SChartData>)sChart:(ShinobiChart *)chart dataPointAtIndex:(NSInteger)dataIndex forSeriesAtIndex:(NSInteger)seriesIndex {
    SChartDataPoint *datapoint = [[SChartDataPoint alloc] init];
    NSString* key = _diccionario.allKeys[dataIndex];
    datapoint.xValue = key;
    datapoint.yValue = _diccionario[key];
    return datapoint;
}

@end
