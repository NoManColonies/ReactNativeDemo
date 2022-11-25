import {NativeStackScreenProps} from '@react-navigation/native-stack';
import React, {useEffect} from 'react';
import {Button, Text, View} from 'react-native';
import {RootStack} from '.';
import CalendarModule from '../components/modules/CalendarModule';
import NewModuleButton from '../components/NewNativeModule';
import TestMessageCallButton from '../components/TestMessageCallButton';
import TestMessageChatButton from '../components/TestMessageChatButton';
import TestMessageStreamButton from '../components/TestMessageStreamButton';
import {useCounter} from '../stores/hooks/counter';

type Props = NativeStackScreenProps<RootStack, 'TestPage'>;

export default function TestPage({}: Props) {
  const [{count}, {useIncrement, useDecrement}] = useCounter();

  useEffect(() => {
    const {DEFAULT_EVENT_NAME} = CalendarModule.getConstants();
    console.log(DEFAULT_EVENT_NAME);
  }, []);

  return (
    <View>
      <Text>{count}</Text>
      <Button onPress={useIncrement} title="increase" />
      <Button onPress={useDecrement} title="decrease" />
      <NewModuleButton />
      <TestMessageCallButton />
      <TestMessageStreamButton />
      <TestMessageChatButton />
    </View>
  );
}
