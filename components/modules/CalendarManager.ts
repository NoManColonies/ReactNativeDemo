import {NativeModules} from 'react-native';
const {CalendarManager} = NativeModules;

export type TestMessage = {
  content: string;
};

interface CalendarInterface {
  addEvent(
    name: string,
    location: string,
    date: number,
    callback: (message?: TestMessage, error?: Error) => void,
  ): void;
  getConstants: () => {
    DEFAULT_EVENT_NAME: string;
  };
}
export default CalendarManager as CalendarInterface;
