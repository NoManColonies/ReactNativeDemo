import React from 'react';
import {Button} from 'react-native';
import TestMessageSender from './modules/TestMessageSender';

const TestMessageStreamButton = () => {
  const onInit = async () => {
    try {
      await TestMessageSender.initializeStreamRPC('127.0.0.1', 50051);
    } catch (e) {
      console.error(e);
    }
  };
  const onStream = async () => {
    try {
      await TestMessageSender.streamMessage('Hello world');
    } catch (e) {
      console.error(e);
    }
  };
  const onEnd = async () => {
    try {
      const response = await TestMessageSender.endStream();
      console.log(response);
    } catch (e) {
      console.error(e);
    }
  };
  const onCancel = async () => {
    try {
      await TestMessageSender.cancelStream();
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <>
      <Button
        title="Click to initialize stream"
        color="#841584"
        onPress={onInit}
      />
      <Button
        title="Click to stream message"
        color="#841584"
        onPress={onStream}
      />
      <Button title="Click to end stream" color="#841584" onPress={onEnd} />
      <Button
        title="Click to cancel stream"
        color="#841584"
        onPress={onCancel}
      />
    </>
  );
};

export default TestMessageStreamButton;
