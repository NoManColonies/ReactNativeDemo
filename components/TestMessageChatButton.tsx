import React, {useEffect} from 'react';
import {Button, NativeAppEventEmitter} from 'react-native';
import TestMessageSender, {TestMessage} from './modules/TestMessageSender';

const TestMessageChatButton = () => {
  useEffect(() => {
    NativeAppEventEmitter.addListener('onChat', (message: TestMessage) => {
      console.log('message: ', message);
    });
  }, []);

  const onInit = async () => {
    try {
      await TestMessageSender.initializeChatRPC('127.0.0.1', 50051);
    } catch (e) {
      console.error(e);
    }
  };
  const onChat = async () => {
    try {
      await TestMessageSender.chatMessage('Hello world');
    } catch (e) {
      console.error(e);
    }
  };
  const onEnd = async () => {
    try {
      await TestMessageSender.endChat();
    } catch (e) {
      console.error(e);
    }
  };
  const onCancel = async () => {
    try {
      await TestMessageSender.cancelChat();
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <>
      <Button
        title="Click to initialize chat"
        color="#841584"
        onPress={onInit}
      />
      <Button title="Click to chat message" color="#841584" onPress={onChat} />
      <Button title="Click to end chat" color="#841584" onPress={onEnd} />
      <Button title="Click to cancel chat" color="#841584" onPress={onCancel} />
    </>
  );
};

export default TestMessageChatButton;
