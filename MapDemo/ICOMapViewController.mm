//
//  ICOViewController.m
//  MapDemo
//
//  Created by Sean on 3/1/13.
//  Copyright (c) 2013 ICOCHINA. All rights reserved.
//

#import "ICOMapViewController.h"

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface ICOMapViewController ()
-(void)autoTimer;
@end

@implementation ICOMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     polyline = nil;
    count = 1;
    coors[0].latitude = 0;
    coors[0].longitude= 0;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    cartview = nil;
    start_annotation = [[BMKPointAnnotation alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}


#pragma -mark define

-(void)autoTimer{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(autoTimerFunctionAction:) userInfo:nil repeats:YES];
    
}

-(void)autoTimerFunctionAction:(NSTimer*)timer{
    
    if (polyline!= nil) {
        [_mapView removeOverlay:polyline];
    }
    
    if (start_annotation!=nil) {
        [_mapView removeAnnotation:start_annotation];
    }
    
    
    if (count >= 1 && count<= 10) {
        coors[count].latitude = coors[count-1].latitude + (arc4random()%100)/10000.0 +0.0001;
        coors[count].longitude = coors[count-1].longitude+ (arc4random()%100)/10000.0 +0.0001;
        
//        
        BMKCoordinateRegion region;
        region.center = coors[count-1];
        region.span.latitudeDelta  = 0.02;
        region.span.longitudeDelta = 0.02;
        _mapView.region   = region;
        
        
        start_annotation.coordinate = coors[count];
        start_annotation.title = @"当前所在位置";
        [_mapView addAnnotation:start_annotation];
        count ++ ;
        
    }else if (count > 10){
        count = 1;
    }
    
    NSLog(@"count : %d    %f   %f",count ,coors[count].latitude ,coors[count].longitude);
    
    
    
    polyline = [BMKPolyline polylineWithCoordinates:coors count:count];
    [_mapView addOverlay:polyline];
    
    
    
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        //		NSLog ( @"%@" ,s);
		return s;
	}
	return nil ;
}



#pragma -mark BMKMapViewDelegate

/**
 *地图区域即将改变时会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    
    //   BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate  = coors[count];
    
    
    cartview = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
    
    if (cartview == nil) {
        
        cartview = [[BMKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"start_node"];
        cartview.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_bus.png"]];
        cartview.centerOffset = CGPointMake(0, -(cartview.frame.size.height * 0.5));
        //        cartview.canShowCallout = TRUE;
    }
    cartview.annotation  =annotation;
    
    return cartview;
    //    static NSString *AnnotationViewID = @"annotationViewID";
    //
    //    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
    //        BMKPinAnnotationView *pin = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    //         NSLog(@"%@",annotation);
    //
    //        pin.annotation = annotation;
    //
    //        if (pin == nil)
    //        {
    //            pin = [[[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    //        }
    //        pin.draggable = NO;
    //        pin.animatesDrop = YES;
    //        pin.pinColor = BMKPinAnnotationColorRed;
    //        pin.canShowCallout = YES;
    //         return pin;
    //    }
    //    if (annotation != nil) {
    //
    //           BMKAnnotationView *pin = (BMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    //             pin.annotation = annotation;
    //               if (pin == nil)
    //             {
    //                 pin = [[[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID] autorelease];
    //             }
    //pin.draggable = NO;
    //  return pin;
    //
    //    }
    return nil;
}

/**
 *当mapView新添加annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 新添加的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    
}

/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    
    
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(BMKMapView *)mapView
{
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(BMKMapView *)mapView
{
}

/**
 *用户位置更新后，会调用此函数
 *@param mapView 地图View
 *@param userLocation 新的用户位置
 */
- (void)mapView:(BMKMapView *)mapView didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    static int t_count = 1;
   	if (userLocation != nil) {
        BMKCoordinateRegion region;
        region.center.latitude  = userLocation.location.coordinate.latitude+ t_count/500.0;
        region.center.longitude = userLocation.location.coordinate.longitude +t_count/500.0;
        region.span.latitudeDelta  = 0.02;
        region.span.longitudeDelta = 0.02;
        _mapView.region   = region;
        _mapView.showsUserLocation = NO;
        
        
        [_mapView setCenterCoordinate:region.center];
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
        annotation.coordinate = userLocation.location.coordinate;
        annotation.title = @"起点";
        [_mapView addAnnotation:annotation];
        count ++ ;
        NSLog(@"%f %f",  region.center.latitude ,    region.center.longitude);
        
        
        count = 1;
        coors[0].latitude= region.center.latitude;
        coors[0].longitude =  region.center.longitude;
        //
        [self autoTimer];
        
        
 	}
    
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(BMKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
}

/**
 *拖动annotation view时view的状态变化，ios3.2以后支持
 *@param mapView 地图View
 *@param view annotation view
 *@param newState 新状态
 *@param oldState 旧状态
 */
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    
    
}


/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view
{
    //    for (UIView*  temp_view in mapView.subviews) {
    //        if ([temp_view  isKindOfClass:[BMKPolylineView Class]]) {
    //            [mapView removeOverlay:temp_view];
    //        }
    //    }
    NSLog(@"泡泡 被点击了，嘿嘿");
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [[UIColor purpleColor] colorWithAlphaComponent:1];
        polylineView.lineWidth = 5.0;
        
        return polylineView;
    }
    return nil;
}

/**
 *当mapView新添加overlay views时，调用此接口
 *@param mapView 地图View
 *@param overlayViews 新添加的overlay views
 */
- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews{
    
}
@end
