import React from 'react';
import {NavigationContainer} from '@react-navigation/native';
import {createNativeStackNavigator} from '@react-navigation/native-stack';
import TestPage from './test';
import {Provider} from 'react-redux';
import {store} from '../stores';

export type RootStack = {
  TestPage: undefined;
};

const Stack = createNativeStackNavigator<RootStack>();

export default function App() {
  return (
    <Provider store={store}>
      <NavigationContainer>
        <Stack.Navigator initialRouteName="TestPage">
          <Stack.Screen name="TestPage" component={TestPage} />
        </Stack.Navigator>
      </NavigationContainer>
    </Provider>
  );
}
