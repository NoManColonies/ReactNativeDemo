import React from 'react';
import {Button} from 'react-native';
import CalendarManager from './modules/CalendarManager';
import CalendarModule from './modules/CalendarModule';

const NewModuleButton = () => {
  const onPress = async () => {
    try {
      const eventId = await CalendarModule.createCalendarEvent(
        'Party',
        'Some where',
      );
      console.log(`Created a new event with id ${eventId}`);
      CalendarManager.addEvent(
        'test event',
        'test location',
        new Date().valueOf(),
        (message, error) => {
          if (error) {
            console.error(error);
          } else {
            console.log(message);
          }
        },
      );
      console.log(CalendarManager.getConstants());
    } catch (e) {
      console.error(e);
    }
  };

  return (
    <Button
      title="Click to invoke your native module!"
      color="#841584"
      onPress={onPress}
    />
  );
};

export default NewModuleButton;
