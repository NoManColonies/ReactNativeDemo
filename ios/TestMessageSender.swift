//
//  TestMessageSender.swift
//  ReactNativeDemo
//
//  Created by nullBrainz on 18/10/2565 BE.
//

import Foundation
import GRPC

@objc(TestMessageSender)
class TestMessageSender : RCTEventEmitter {
  override func supportedEvents() -> [String]! {
    return ["onMessage", "onChat", "onEvent"]
  }
  
  override func constantsToExport() -> [AnyHashable : Any]! {
    return [:]
  }
  
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
  
  var streamClient: TestMessageStreamClient?
  var chatClient: TestMessageChatClient?
  
  func makeSendMessageRPCCall(_ host: String, port: NSNumber, content: String) async throws -> TestMessage_ResponseMessage {
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
    
    let message: TestMessage_TestMessage = .with {
      $0.content = content
    }
    
    return try await testMessageClient.sendMessage(message)
  }
  
  @objc(sendMessage:port:content:callback:)
  func sendMessage(_ host: String, port: NSNumber, content: String, callback: @escaping (NSObject) -> ()) -> Void {
    Task {
      do {
        let response = try await makeSendMessageRPCCall(host, port: port, content: content)
        sendEvent(withName: "onMessage", body: ["content": response.content])
        callback([["content": response.content], nil] as NSObject)
      } catch {
        callback([nil, error.localizedDescription] as NSObject)
      }
    }
  }
  
  func initStreamClient(host: String, port: NSNumber) async throws -> Void {
    if let client = self.streamClient {
      try await client.makeStreamingRPCCall()
    } else {
      self.streamClient = TestMessageStreamClient(host: host, port: port)
      try await self.streamClient?.makeStreamingRPCCall()
    }
  }
  
  @objc(initializeStreamRPC:port:resolver:rejecter:)
  func initializeStreamRPC(_ host: String,
                           port: NSNumber,
                           resolve: @escaping RCTPromiseResolveBlock,
                           reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        try await initStreamClient(host: host, port: port)
        resolve([])
      } catch {
        reject("E_INIT",
               "Failed to initialize stream RPC: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(streamMessage:resolver:rejecter:)
  func streamMessage(message: String,
                     resolve: @escaping RCTPromiseResolveBlock,
                     reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.streamClient {
          try await client.streamMessage(message: .with {
            $0.content = message
          })
          resolve([])
        } else {
          reject("E_CLIENT",
                 "Failed to send stream message: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_MESSAGE",
               "Failed to send stream message: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(endStream:rejecter:)
  func endStream(resolve: @escaping RCTPromiseResolveBlock,
                 reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.streamClient {
          let response = try await client.endStream()
          resolve([["content": response.content]])
        } else {
          reject("E_CLIENT",
                 "Failed to end stream: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_END",
               "Failed to end stream: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(cancelStream:rejecter:)
  func cancelStream(resolve: @escaping RCTPromiseResolveBlock,
                    reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.streamClient {
          try await client.cancelStream()
          resolve([])
        } else {
          reject("E_CLIENT",
                 "Failed to cancel stream: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_CANCEL",
               "Failed to cancel stream: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  func chatCallback(message: TestMessage_ResponseMessage) -> Void {
    NSLog("sending event")
    sendEvent(withName: "onChat", body: [["content": message.content]])
  }
  
  func initChatClient(host: String, port: NSNumber) async throws -> Void {
    if let client = self.chatClient {
      try await client.makeChatRPCCall(callback: chatCallback)
    } else {
      self.chatClient = TestMessageChatClient(host: host, port: port)
      try await self.chatClient?.makeChatRPCCall(callback: chatCallback)
    }
  }
  
  @objc(initializeChatRPC:port:resolver:rejecter:)
  func initializeChatRPC(_ host: String,
                           port: NSNumber,
                           resolve: @escaping RCTPromiseResolveBlock,
                           reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        try await initChatClient(host: host, port: port)
        resolve([])
      } catch {
        reject("E_INIT",
               "Failed to initialize chat RPC: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(chatMessage:resolver:rejecter:)
  func chatMessage(message: String,
                     resolve: @escaping RCTPromiseResolveBlock,
                     reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.chatClient {
          try await client.chatMessage(message: .with {
            $0.content = message
          })
          resolve([])
        } else {
          reject("E_CLIENT",
                 "Failed to send chat message: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_CHAT",
               "Failed to send chat message: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(endChat:rejecter:)
  func endChat(resolve: @escaping RCTPromiseResolveBlock,
                 reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.chatClient {
          try await client.endChat()
          resolve([])
        } else {
          reject("E_CLIENT",
                 "Failed to end chat: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_END",
               "Failed to end chat: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
  
  @objc(cancelChat:rejecter:)
  func cancelChat(resolve: @escaping RCTPromiseResolveBlock,
                    reject: @escaping RCTPromiseRejectBlock) -> Void {
    Task {
      do {
        if let client = self.chatClient {
          try await client.cancelChat()
          resolve([])
        } else {
          reject("E_CLIENT",
                 "Failed to cancel chat: client is uninitialized",
                 NSError(domain: "", code: 200))
        }
      } catch {
        reject("E_CANCEL",
               "Failed to cancel chat: \(error.localizedDescription)",
               NSError(domain: "", code: 200))
      }
    }
  }
}
