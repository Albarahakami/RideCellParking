//
//  RideCellParkingTools.h
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RideCellParkingTools : NSObject


+ (void) setButtonImage:(UIButton*)btn
          withURLString:(NSString*)url
       placeholderImage:(UIImage*)placeholderImage;

+ (void) setImage:(__weak UIImageView*)image
    withURLString:(NSString*)url
 placeholderImage:(UIImage*)placeholderImage;

+ (void) setImage:(__weak UIImageView*)image
    withURLString:(NSString*)url
 placeholderImage:(UIImage*)placeholderImage
 toLayer:(CALayer*)layer;


+ (void) roundImage:(UIImageView*)imageView;

+ (NSString*) timeStampFromString:(NSString*)string;
+ (NSString*) timeStampDescFromString:(NSString*)string;
+ (NSString*) getDate:(NSString*)string;


@end
