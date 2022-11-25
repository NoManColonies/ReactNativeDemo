//
//  TestMessageSenderModule.m
//  ReactNativeDemo
//
//  Created by nullBrainz on 18/10/2565 BE.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(TestMessageSender, RCTEventEmitter)

RCT_EXTERN_METHOD(sendMessage:(NSString *)host
                  port:(nonnull NSNumber *)port
                  content:(NSString *)content
                  callback:(RCTResponseSenderBlock) callback)

RCT_EXTERN_METHOD(initializeStreamRPC:(NSString *)host
                  port:(nonnull NSNumber *)port
                  resolver:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(streamMessage:(NSString *)message
                  resolver:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(endStream:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(cancelStream:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(initializeChatRPC:(NSString *)host
                  port:(nonnull NSNumber *)port
                  resolver:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(chatMessage:(NSString *)message
                  resolver:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(endChat:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

RCT_EXTERN_METHOD(cancelChat:(RCTPromiseResolveBlock) resolve
                  rejecter:(RCTPromiseRejectBlock) reject)

@end
