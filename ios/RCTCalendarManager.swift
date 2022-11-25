//
//  RCTCalendarManager.swift
//  ReactNativeDemo
//
//  Created by nullBrainz on 17/10/2565 BE.
//

import Foundation
import GRPC

let port = 50051

@objc(RCTCalendarManager)
class RCTCalendarManager: NSObject {
  func makeRPCCall() async throws -> TestMessage_ResponseMessage {
    let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    defer {
      try? group.syncShutdownGracefully()
    }
    
    let channel = try GRPCChannelPool.with(
      target: .host("127.0.0.1", port: port),
      transportSecurity: .plaintext,
      eventLoopGroup: group
    )

    let testMessageClient = TestMessage_TestMessageServiceAsyncClient(channel: channel)
    
    var message = TestMessage_TestMessage()
    message.content = "Hello world"
    
    return try await testMessageClient.sendMessage(message)
  }

  @objc(addEvent:location:date:callback:)
  func addEvent(_ name: String, location: String, date: NSNumber, callback: @escaping (NSObject) -> ()) -> Void {
    Task {
      do {
        let message = try await makeRPCCall()
        
        NSLog("CalendarManager: %@", message.content)
        callback([message.content, nil] as NSObject)
      } catch {
        callback([nil, error.localizedDescription] as NSObject)
      }
    }
  }

  @objc
  func constantsToExport() -> [String: Any]! {
    return ["someKey": "someValue"]
  }
}
