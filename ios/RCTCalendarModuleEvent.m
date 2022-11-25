//
//  RCTCalendarModuleEvent.m
//  ReactNativeDemo
//
//  Created by nullBrainz on 17/10/2565 BE.
//

#import "RCTCalendarModuleEvent.h"

@implementation RCTCalendarModuleEvent
{
  bool hasListeners;
}

// Will be called when this module's first listener is added.
-(void)startObserving {
    hasListeners = YES;
    // Set up any upstream listeners or background tasks as necessary
}

// Will be called when this module's last listener is removed, or on dealloc.
-(void)stopObserving {
    hasListeners = NO;
    // Remove upstream listeners, stop unnecessary background tasks
}

- (void)calendarEventReminderReceived:(NSNotification *)notification
{
  NSString *eventName = notification.userInfo[@"name"];
  if (hasListeners) { // Only send events if anyone is listening
    [self sendEventWithName:@"EventReminder" body:@{@"name": eventName}];
  }
}

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
@end
