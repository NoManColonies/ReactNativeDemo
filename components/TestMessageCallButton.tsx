import React from 'react';
import {Button} from 'react-native';
import TestMessageSender from './modules/TestMessageSender';

const TestMessageCallButton = () => {
  const onPress = async () => {
    try {
      TestMessageSender.sendMessage(
        '127.0.0.1',
        50051,
        'Hello world',
        (response, error) => {
          if (error) {
            console.error(error);
          } else {
            console.log(response);
          }
        },
      );
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <Button
      title="Click to call test message service"
      color="#841584"
      onPress={onPress}
    />
  );
};

export default TestMessageCallButton;
