//
//  RCTCalendarManager.m
//  ReactNativeDemo
//
//  Created by nullBrainz on 17/10/2565 BE.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RCTCalendarManager, NSObject)

RCT_EXTERN_METHOD(addEvent:(NSString *)name
                  location:(NSString *)location
                  date:(nonnull NSNumber *)date
                  callback:(RCTResponseSenderBlock) callback)

@end
