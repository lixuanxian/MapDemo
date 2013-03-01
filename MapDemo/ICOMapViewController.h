//
//  ICOMapViewController
//  MapDemo
//
//  Created by Sean on 3/1/13.
//  Copyright (c) 2013 ICOCHINA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface ICOMapViewController : UIViewController<BMKMapViewDelegate>
{
    CLLocationCoordinate2D coors[11] ;
    int count  ;
    BMKPolyline* polyline;
    BMKAnnotationView* cartview ;
    BMKPointAnnotation *start_annotation;
}
@property (strong, nonatomic) IBOutlet BMKMapView *mapView;

@end
