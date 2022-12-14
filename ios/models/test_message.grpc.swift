//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: test_message.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import GRPC
import NIO
import NIOConcurrencyHelpers
import SwiftProtobuf


/// Usage: instantiate `TestMessage_TestMessageServiceClient`, then call methods of this protocol to make API calls.
public protocol TestMessage_TestMessageServiceClientProtocol: GRPCClient {
  var serviceName: String { get }
  var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? { get }

  func sendMessage(
    _ request: TestMessage_TestMessage,
    callOptions: CallOptions?
  ) -> UnaryCall<TestMessage_TestMessage, TestMessage_ResponseMessage>

  func streamMessage(
    callOptions: CallOptions?
  ) -> ClientStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>

  func eventMessage(
    _ request: TestMessage_EventConfigRequest,
    callOptions: CallOptions?,
    handler: @escaping (TestMessage_ResponseMessage) -> Void
  ) -> ServerStreamingCall<TestMessage_EventConfigRequest, TestMessage_ResponseMessage>

  func chatMessage(
    callOptions: CallOptions?,
    handler: @escaping (TestMessage_ResponseMessage) -> Void
  ) -> BidirectionalStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>
}

extension TestMessage_TestMessageServiceClientProtocol {
  public var serviceName: String {
    return "test_message.TestMessageService"
  }

  /// Unary call to SendMessage
  ///
  /// - Parameters:
  ///   - request: Request to send to SendMessage.
  ///   - callOptions: Call options.
  /// - Returns: A `UnaryCall` with futures for the metadata, status and response.
  public func sendMessage(
    _ request: TestMessage_TestMessage,
    callOptions: CallOptions? = nil
  ) -> UnaryCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeUnaryCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  /// Client streaming call to StreamMessage
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata, status and response.
  public func streamMessage(
    callOptions: CallOptions? = nil
  ) -> ClientStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeClientStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.streamMessage.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? []
    )
  }

  /// Server streaming call to EventMessage
  ///
  /// - Parameters:
  ///   - request: Request to send to EventMessage.
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ServerStreamingCall` with futures for the metadata and status.
  public func eventMessage(
    _ request: TestMessage_EventConfigRequest,
    callOptions: CallOptions? = nil,
    handler: @escaping (TestMessage_ResponseMessage) -> Void
  ) -> ServerStreamingCall<TestMessage_EventConfigRequest, TestMessage_ResponseMessage> {
    return self.makeServerStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.eventMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeEventMessageInterceptors() ?? [],
      handler: handler
    )
  }

  /// Bidirectional streaming call to ChatMessage
  ///
  /// Callers should use the `send` method on the returned object to send messages
  /// to the server. The caller should send an `.end` after the final message has been sent.
  ///
  /// - Parameters:
  ///   - callOptions: Call options.
  ///   - handler: A closure called when each response is received from the server.
  /// - Returns: A `ClientStreamingCall` with futures for the metadata and status.
  public func chatMessage(
    callOptions: CallOptions? = nil,
    handler: @escaping (TestMessage_ResponseMessage) -> Void
  ) -> BidirectionalStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeBidirectionalStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.chatMessage.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatMessageInterceptors() ?? [],
      handler: handler
    )
  }
}

#if compiler(>=5.6)
@available(*, deprecated)
extension TestMessage_TestMessageServiceClient: @unchecked Sendable {}
#endif // compiler(>=5.6)

@available(*, deprecated, renamed: "TestMessage_TestMessageServiceNIOClient")
public final class TestMessage_TestMessageServiceClient: TestMessage_TestMessageServiceClientProtocol {
  private let lock = Lock()
  private var _defaultCallOptions: CallOptions
  private var _interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol?
  public let channel: GRPCChannel
  public var defaultCallOptions: CallOptions {
    get { self.lock.withLock { return self._defaultCallOptions } }
    set { self.lock.withLockVoid { self._defaultCallOptions = newValue } }
  }
  public var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? {
    get { self.lock.withLock { return self._interceptors } }
    set { self.lock.withLockVoid { self._interceptors = newValue } }
  }

  /// Creates a client for the test_message.TestMessageService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self._defaultCallOptions = defaultCallOptions
    self._interceptors = interceptors
  }
}

public struct TestMessage_TestMessageServiceNIOClient: TestMessage_TestMessageServiceClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol?

  /// Creates a client for the test_message.TestMessageService service.
  ///
  /// - Parameters:
  ///   - channel: `GRPCChannel` to the service host.
  ///   - defaultCallOptions: Options to use for each service call if the user doesn't provide them.
  ///   - interceptors: A factory providing interceptors for each RPC.
  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#if compiler(>=5.6)
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol TestMessage_TestMessageServiceAsyncClientProtocol: GRPCClient {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? { get }

  func makeSendMessageCall(
    _ request: TestMessage_TestMessage,
    callOptions: CallOptions?
  ) -> GRPCAsyncUnaryCall<TestMessage_TestMessage, TestMessage_ResponseMessage>

  func makeStreamMessageCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncClientStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>

  func makeEventMessageCall(
    _ request: TestMessage_EventConfigRequest,
    callOptions: CallOptions?
  ) -> GRPCAsyncServerStreamingCall<TestMessage_EventConfigRequest, TestMessage_ResponseMessage>

  func makeChatMessageCall(
    callOptions: CallOptions?
  ) -> GRPCAsyncBidirectionalStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage>
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TestMessage_TestMessageServiceAsyncClientProtocol {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return TestMessage_TestMessageServiceClientMetadata.serviceDescriptor
  }

  public var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? {
    return nil
  }

  public func makeSendMessageCall(
    _ request: TestMessage_TestMessage,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncUnaryCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeAsyncUnaryCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  public func makeStreamMessageCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncClientStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeAsyncClientStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.streamMessage.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? []
    )
  }

  public func makeEventMessageCall(
    _ request: TestMessage_EventConfigRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncServerStreamingCall<TestMessage_EventConfigRequest, TestMessage_ResponseMessage> {
    return self.makeAsyncServerStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.eventMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeEventMessageInterceptors() ?? []
    )
  }

  public func makeChatMessageCall(
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncBidirectionalStreamingCall<TestMessage_TestMessage, TestMessage_ResponseMessage> {
    return self.makeAsyncBidirectionalStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.chatMessage.path,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatMessageInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TestMessage_TestMessageServiceAsyncClientProtocol {
  public func sendMessage(
    _ request: TestMessage_TestMessage,
    callOptions: CallOptions? = nil
  ) async throws -> TestMessage_ResponseMessage {
    return try await self.performAsyncUnaryCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.sendMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeSendMessageInterceptors() ?? []
    )
  }

  public func streamMessage<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> TestMessage_ResponseMessage where RequestStream: Sequence, RequestStream.Element == TestMessage_TestMessage {
    return try await self.performAsyncClientStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.streamMessage.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? []
    )
  }

  public func streamMessage<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) async throws -> TestMessage_ResponseMessage where RequestStream: AsyncSequence & Sendable, RequestStream.Element == TestMessage_TestMessage {
    return try await self.performAsyncClientStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.streamMessage.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? []
    )
  }

  public func eventMessage(
    _ request: TestMessage_EventConfigRequest,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<TestMessage_ResponseMessage> {
    return self.performAsyncServerStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.eventMessage.path,
      request: request,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeEventMessageInterceptors() ?? []
    )
  }

  public func chatMessage<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<TestMessage_ResponseMessage> where RequestStream: Sequence, RequestStream.Element == TestMessage_TestMessage {
    return self.performAsyncBidirectionalStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.chatMessage.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatMessageInterceptors() ?? []
    )
  }

  public func chatMessage<RequestStream>(
    _ requests: RequestStream,
    callOptions: CallOptions? = nil
  ) -> GRPCAsyncResponseStream<TestMessage_ResponseMessage> where RequestStream: AsyncSequence & Sendable, RequestStream.Element == TestMessage_TestMessage {
    return self.performAsyncBidirectionalStreamingCall(
      path: TestMessage_TestMessageServiceClientMetadata.Methods.chatMessage.path,
      requests: requests,
      callOptions: callOptions ?? self.defaultCallOptions,
      interceptors: self.interceptors?.makeChatMessageInterceptors() ?? []
    )
  }
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public struct TestMessage_TestMessageServiceAsyncClient: TestMessage_TestMessageServiceAsyncClientProtocol {
  public var channel: GRPCChannel
  public var defaultCallOptions: CallOptions
  public var interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol?

  public init(
    channel: GRPCChannel,
    defaultCallOptions: CallOptions = CallOptions(),
    interceptors: TestMessage_TestMessageServiceClientInterceptorFactoryProtocol? = nil
  ) {
    self.channel = channel
    self.defaultCallOptions = defaultCallOptions
    self.interceptors = interceptors
  }
}

#endif // compiler(>=5.6)

public protocol TestMessage_TestMessageServiceClientInterceptorFactoryProtocol: GRPCSendable {

  /// - Returns: Interceptors to use when invoking 'sendMessage'.
  func makeSendMessageInterceptors() -> [ClientInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when invoking 'streamMessage'.
  func makeStreamMessageInterceptors() -> [ClientInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when invoking 'eventMessage'.
  func makeEventMessageInterceptors() -> [ClientInterceptor<TestMessage_EventConfigRequest, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when invoking 'chatMessage'.
  func makeChatMessageInterceptors() -> [ClientInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]
}

public enum TestMessage_TestMessageServiceClientMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "TestMessageService",
    fullName: "test_message.TestMessageService",
    methods: [
      TestMessage_TestMessageServiceClientMetadata.Methods.sendMessage,
      TestMessage_TestMessageServiceClientMetadata.Methods.streamMessage,
      TestMessage_TestMessageServiceClientMetadata.Methods.eventMessage,
      TestMessage_TestMessageServiceClientMetadata.Methods.chatMessage,
    ]
  )

  public enum Methods {
    public static let sendMessage = GRPCMethodDescriptor(
      name: "SendMessage",
      path: "/test_message.TestMessageService/SendMessage",
      type: GRPCCallType.unary
    )

    public static let streamMessage = GRPCMethodDescriptor(
      name: "StreamMessage",
      path: "/test_message.TestMessageService/StreamMessage",
      type: GRPCCallType.clientStreaming
    )

    public static let eventMessage = GRPCMethodDescriptor(
      name: "EventMessage",
      path: "/test_message.TestMessageService/EventMessage",
      type: GRPCCallType.serverStreaming
    )

    public static let chatMessage = GRPCMethodDescriptor(
      name: "ChatMessage",
      path: "/test_message.TestMessageService/ChatMessage",
      type: GRPCCallType.bidirectionalStreaming
    )
  }
}

/// To build a server, implement a class that conforms to this protocol.
public protocol TestMessage_TestMessageServiceProvider: CallHandlerProvider {
  var interceptors: TestMessage_TestMessageServiceServerInterceptorFactoryProtocol? { get }

  func sendMessage(request: TestMessage_TestMessage, context: StatusOnlyCallContext) -> EventLoopFuture<TestMessage_ResponseMessage>

  func streamMessage(context: UnaryResponseCallContext<TestMessage_ResponseMessage>) -> EventLoopFuture<(StreamEvent<TestMessage_TestMessage>) -> Void>

  func eventMessage(request: TestMessage_EventConfigRequest, context: StreamingResponseCallContext<TestMessage_ResponseMessage>) -> EventLoopFuture<GRPCStatus>

  func chatMessage(context: StreamingResponseCallContext<TestMessage_ResponseMessage>) -> EventLoopFuture<(StreamEvent<TestMessage_TestMessage>) -> Void>
}

extension TestMessage_TestMessageServiceProvider {
  public var serviceName: Substring {
    return TestMessage_TestMessageServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SendMessage":
      return UnaryServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeSendMessageInterceptors() ?? [],
        userFunction: self.sendMessage(request:context:)
      )

    case "StreamMessage":
      return ClientStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? [],
        observerFactory: self.streamMessage(context:)
      )

    case "EventMessage":
      return ServerStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_EventConfigRequest>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeEventMessageInterceptors() ?? [],
        userFunction: self.eventMessage(request:context:)
      )

    case "ChatMessage":
      return BidirectionalStreamingServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeChatMessageInterceptors() ?? [],
        observerFactory: self.chatMessage(context:)
      )

    default:
      return nil
    }
  }
}

#if compiler(>=5.6)

/// To implement a server, implement an object which conforms to this protocol.
@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
public protocol TestMessage_TestMessageServiceAsyncProvider: CallHandlerProvider {
  static var serviceDescriptor: GRPCServiceDescriptor { get }
  var interceptors: TestMessage_TestMessageServiceServerInterceptorFactoryProtocol? { get }

  @Sendable func sendMessage(
    request: TestMessage_TestMessage,
    context: GRPCAsyncServerCallContext
  ) async throws -> TestMessage_ResponseMessage

  @Sendable func streamMessage(
    requestStream: GRPCAsyncRequestStream<TestMessage_TestMessage>,
    context: GRPCAsyncServerCallContext
  ) async throws -> TestMessage_ResponseMessage

  @Sendable func eventMessage(
    request: TestMessage_EventConfigRequest,
    responseStream: GRPCAsyncResponseStreamWriter<TestMessage_ResponseMessage>,
    context: GRPCAsyncServerCallContext
  ) async throws

  @Sendable func chatMessage(
    requestStream: GRPCAsyncRequestStream<TestMessage_TestMessage>,
    responseStream: GRPCAsyncResponseStreamWriter<TestMessage_ResponseMessage>,
    context: GRPCAsyncServerCallContext
  ) async throws
}

@available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
extension TestMessage_TestMessageServiceAsyncProvider {
  public static var serviceDescriptor: GRPCServiceDescriptor {
    return TestMessage_TestMessageServiceServerMetadata.serviceDescriptor
  }

  public var serviceName: Substring {
    return TestMessage_TestMessageServiceServerMetadata.serviceDescriptor.fullName[...]
  }

  public var interceptors: TestMessage_TestMessageServiceServerInterceptorFactoryProtocol? {
    return nil
  }

  public func handle(
    method name: Substring,
    context: CallHandlerContext
  ) -> GRPCServerHandlerProtocol? {
    switch name {
    case "SendMessage":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeSendMessageInterceptors() ?? [],
        wrapping: self.sendMessage(request:context:)
      )

    case "StreamMessage":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeStreamMessageInterceptors() ?? [],
        wrapping: self.streamMessage(requestStream:context:)
      )

    case "EventMessage":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_EventConfigRequest>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeEventMessageInterceptors() ?? [],
        wrapping: self.eventMessage(request:responseStream:context:)
      )

    case "ChatMessage":
      return GRPCAsyncServerHandler(
        context: context,
        requestDeserializer: ProtobufDeserializer<TestMessage_TestMessage>(),
        responseSerializer: ProtobufSerializer<TestMessage_ResponseMessage>(),
        interceptors: self.interceptors?.makeChatMessageInterceptors() ?? [],
        wrapping: self.chatMessage(requestStream:responseStream:context:)
      )

    default:
      return nil
    }
  }
}

#endif // compiler(>=5.6)

public protocol TestMessage_TestMessageServiceServerInterceptorFactoryProtocol {

  /// - Returns: Interceptors to use when handling 'sendMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeSendMessageInterceptors() -> [ServerInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when handling 'streamMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeStreamMessageInterceptors() -> [ServerInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when handling 'eventMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeEventMessageInterceptors() -> [ServerInterceptor<TestMessage_EventConfigRequest, TestMessage_ResponseMessage>]

  /// - Returns: Interceptors to use when handling 'chatMessage'.
  ///   Defaults to calling `self.makeInterceptors()`.
  func makeChatMessageInterceptors() -> [ServerInterceptor<TestMessage_TestMessage, TestMessage_ResponseMessage>]
}

public enum TestMessage_TestMessageServiceServerMetadata {
  public static let serviceDescriptor = GRPCServiceDescriptor(
    name: "TestMessageService",
    fullName: "test_message.TestMessageService",
    methods: [
      TestMessage_TestMessageServiceServerMetadata.Methods.sendMessage,
      TestMessage_TestMessageServiceServerMetadata.Methods.streamMessage,
      TestMessage_TestMessageServiceServerMetadata.Methods.eventMessage,
      TestMessage_TestMessageServiceServerMetadata.Methods.chatMessage,
    ]
  )

  public enum Methods {
    public static let sendMessage = GRPCMethodDescriptor(
      name: "SendMessage",
      path: "/test_message.TestMessageService/SendMessage",
      type: GRPCCallType.unary
    )

    public static let streamMessage = GRPCMethodDescriptor(
      name: "StreamMessage",
      path: "/test_message.TestMessageService/StreamMessage",
      type: GRPCCallType.clientStreaming
    )

    public static let eventMessage = GRPCMethodDescriptor(
      name: "EventMessage",
      path: "/test_message.TestMessageService/EventMessage",
      type: GRPCCallType.serverStreaming
    )

    public static let chatMessage = GRPCMethodDescriptor(
      name: "ChatMessage",
      path: "/test_message.TestMessageService/ChatMessage",
      type: GRPCCallType.bidirectionalStreaming
    )
  }
}
