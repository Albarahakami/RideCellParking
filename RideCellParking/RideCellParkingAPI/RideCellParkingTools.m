//
//  RideCellParkingTools.m
//  RideCellParking
//
//  Created by Albara Hakami on 5/4/16.
//  Copyright © 2016 RideCell. All rights reserved.
//

#import "RideCellParkingTools.h"
#import "UIImageView+WebCache.h"

@implementation RideCellParkingTools


+ (void) setButtonImage:(__weak UIButton*)btn withURLString:(NSString*)url placeholderImage:(UIImage*)placeholderImage {
    
    
    [btn.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image) {
            [btn setImage:image forState:UIControlStateNormal];
            [btn setImage:image forState:UIControlStateHighlighted];
            [btn setImage:image forState:UIControlStateSelected];
        }
        
    }];
    
}


+ (void) setImage:(__weak UIImageView*)imageView
    withURLString:(NSString*)url
 placeholderImage:(UIImage*)placeholderImage {
    
    //__block __strong THCircularProgressView *prog;
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image)
            [imageView setImage:image];
        
    }];
    
}


+ (void) setImage:(__weak UIImageView*)imageView
    withURLString:(NSString*)url
 placeholderImage:(UIImage*)placeholderImage
          toLayer:(__weak CALayer *)layer {
    
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage options:SDWebImageContinueInBackground completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(image) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [imageView setImage:image];
                imageView.alpha = 1.0;
                [layer addSublayer:imageView.layer];
                
            });
            
        }
        
    }];
    
}


+ (void) roundImage:(UIImageView*)imageView {
    
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.borderWidth = 0.0f;
    //imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
}


+ (NSString*) timeStampFromString:(NSString*)string {
    
    NSDate* date1 = [NSDate date];
    //2013-11-07 21:33:14
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(0)]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSArray *datetimeArray = [string componentsSeparatedByString:@"T"];
    
    NSDate* date2 = [[NSDate alloc] init];
    if(datetimeArray.count > 1)
        date2 = [df dateFromString:[NSString stringWithFormat:@"%@ %@", datetimeArray[0], datetimeArray[1]]];
    else
        date2 = [df dateFromString:string];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    
    if(distanceBetweenDates < 60)
        return [NSString stringWithFormat:@"%is", (int)floorf(distanceBetweenDates)];
    else if(distanceBetweenDates < 60*60)
        return [NSString stringWithFormat:@"%im", (int)floorf(distanceBetweenDates/60)];
    else if(distanceBetweenDates < 60*60*24)
        return [NSString stringWithFormat:@"%ih", (int)floorf(distanceBetweenDates/(60*60))];
    else if(distanceBetweenDates/(60*60*24) < 7)
        return [NSString stringWithFormat:@"%id", (int)floorf(distanceBetweenDates/(60*60*24))];
    else
        return [NSString stringWithFormat:@"%iw", (int)floorf(distanceBetweenDates/(60*60*24*7))];
}


+ (NSString*) timeStampDescFromString:(NSString*)string {
    
    NSDate* date1 = [NSDate date];
    //2013-11-07 21:33:14
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:(0)]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSArray *datetimeArray = [string componentsSeparatedByString:@"T"];
    
    NSDate* date2 = [[NSDate alloc] init];
    if(datetimeArray.count > 1)
        date2 = [df dateFromString:[NSString stringWithFormat:@"%@ %@", datetimeArray[0], datetimeArray[1]]];
    else
        date2 = [df dateFromString:string];
    NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
    
    if(distanceBetweenDates < 60)
        return [NSString stringWithFormat:@"%i seconds ago", (int)floorf(distanceBetweenDates)];
    else if(distanceBetweenDates < 60*60)
        return [NSString stringWithFormat:@"%i minutes ago", (int)floorf(distanceBetweenDates/60)];
    else if(distanceBetweenDates < 60*60*24)
        return [NSString stringWithFormat:@"%i hours ago", (int)floorf(distanceBetweenDates/(60*60))];
    else if(distanceBetweenDates/(60*60*24) < 7)
        return [NSString stringWithFormat:@"%i days ago", (int)floorf(distanceBetweenDates/(60*60*24))];
    else
        return [NSString stringWithFormat:@"%i weeks ago", (int)floorf(distanceBetweenDates/(60*60*24*7))];
}


+ (NSString*) getDate:(NSString*)string {
    
    
    NSArray *datetimeArray = [string componentsSeparatedByString:@"T"];
    
    if(datetimeArray.count > 1)
        
        return datetimeArray[0];
    else {
        
        NSArray *datetimeArray2 = [string componentsSeparatedByString:@" "];
        return datetimeArray2[0];
        
    }
    
}


@end
