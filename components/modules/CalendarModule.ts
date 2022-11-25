import {NativeModules} from 'react-native';
const {CalendarModule} = NativeModules;

interface CalendarInterface {
  createCalendarEvent(
    name: string,
    location: string,
    // callback: (error: Error | null, eventId: number) => void,
  ): Promise<number>;
  getConstants: () => {
    DEFAULT_EVENT_NAME: string;
  };
}
export default CalendarModule as CalendarInterface;
