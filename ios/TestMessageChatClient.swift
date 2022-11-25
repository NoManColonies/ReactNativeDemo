//
//  TestMessageChatClient.swift
//  ReactNativeDemo
//
//  Created by nullBrainz on 20/10/2565 BE.
//

import Foundation
import GRPC

class TestMessageChatClient {
  init(host: String, port: NSNumber) {
    self.host = host
    self.port = port
  }
  
  var host: String
  var port: NSNumber
  var route: GRPCAsyncBidirectionalStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>?
  
  func makeChatRPCCall(callback: @escaping (_ message: TestMessage_ResponseMessage) -> ()) async throws -> Void {
    if let _ = self.route {
      throw ClientError.ClientAlreadyExist
    }
    
    let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
    defer {
      try? group.syncShutdownGracefully()
    }
    
    let channel = try GRPCChannelPool.with(
      target: .host(host, port: Int(truncating: port)),
      transportSecurity: .plaintext,
      eventLoopGroup: group
    )

    let testMessageClient = TestMessage_TestMessageServiceAsyncClient(channel: channel)
    
    let route = testMessageClient.makeChatMessageCall()
    
    Task {
      for try await message in route.responseStream {
        callback(message)
      }
      self.route = nil
    }
    self.route = route
//    let route = testMessageClient.makeChatMessageCall()
//
//    do {
//      try await route.requestStream.send(.with {
//        $0.content = "Heyyyyyy"
//      })
//      try await route.requestStream.send(.with {
//        $0.content = "Heyyyyyy"
//      })
//      try await route.requestStream.send(.with {
//        $0.content = "Heyyyyyy"
//      })
////      try await route.requestStream.finish()
//      self.route = route
//    } catch {
//
//    }
  }
  
  func chatMessage(message: TestMessage_TestMessage) async throws -> Void {
    if let route = self.route {
      try await route.requestStream.send(message)
    } else {
      NSLog("chatMessage failed: route not found")
      throw ClientError.InvalidClient
    }
  }
  
  func endChat() async throws -> Void {
    if let route = self.route {
      try await route.requestStream.finish()
    } else {
      NSLog("endChat failed: route not found")
      throw ClientError.InvalidClient
    }
  }
  
  func cancelChat() async throws -> Void {
    if let route = self.route {
      route.cancel()
//      self.route = nil
    } else {
      NSLog("cancelChat failed: route not found")
      throw ClientError.InvalidClient
    }
  }
}
