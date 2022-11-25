//
//  TestMessageStreamClient.swift
//  ReactNativeDemo
//
//  Created by nullBrainz on 19/10/2565 BE.
//

import Foundation
import GRPC

enum ClientError: Error {
  case InvalidClient
  case ClientAlreadyExist
}

class TestMessageStreamClient {
  init(host: String, port: NSNumber) {
    self.host = host
    self.port = port
    
//    Task {
//      do {
//        try await self.makeStreamingRPCCall()
//      } catch {
//        NSLog("client creation failed: %@", error.localizedDescription)
//      }
//    }
  }
  
  var host: String
  var port: NSNumber
  var route: GRPCAsyncClientStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>?
  
  func makeStreamingRPCCall() async throws -> Void {
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
    
//    self.route = testMessageClient.makeStreamMessageCall()
    let route = testMessageClient.makeStreamMessageCall()

    do {
      try await route.requestStream.send(.with {
        $0.content = "Heyyyyyy"
      })
      try await route.requestStream.send(.with {
        $0.content = "Heyyyyyy"
      })
      try await route.requestStream.send(.with {
        $0.content = "Heyyyyyy"
      })
//      try await route.requestStream.finish()
      self.route = route
    } catch {

    }
  }
  
  func streamMessage(message: TestMessage_TestMessage) async throws -> Void {
    if let route = self.route {
      try await route.requestStream.send(message)
    } else {
      NSLog("streamMessage failed: route not found")
      throw ClientError.InvalidClient
    }
  }
  
  func endStream() async throws -> TestMessage_ResponseMessage {
    if let route = self.route {
      try await route.requestStream.finish()
      let response = try await route.response
      self.route = nil
      return response
    } else {
      NSLog("endStream failed: route not found")
      throw ClientError.InvalidClient
    }
  }
  
  func cancelStream() async throws -> Void {
    if let route = self.route {
      route.cancel()
      self.route = nil
    } else {
      NSLog("cancelStream failed: route not found")
      throw ClientError.InvalidClient
    }
  }
}
