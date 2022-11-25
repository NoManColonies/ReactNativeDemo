import {NativeModules} from 'react-native';
const {TestMessageSender} = NativeModules;

export type TestMessage = {
  content: string;
};

interface TestMessageSenderInterface {
  sendMessage(
    host: string,
    port: number,
    content: string,
    callback: (message?: TestMessage, error?: Error) => void,
  ): void;
  initializeStreamRPC(host: string, port: number): Promise<void>;
  streamMessage(message: string): Promise<void>;
  endStream(): Promise<TestMessage>;
  cancelStream(): Promise<void>;
  initializeChatRPC(host: string, port: number): Promise<void>;
  chatMessage(message: string): Promise<void>;
  endChat(): Promise<void>;
  cancelChat(): Promise<void>;
}
export default TestMessageSender as TestMessageSenderInterface;
