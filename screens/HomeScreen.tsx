
import { CustomerIO } from 'customerio-reactnative';
import * as React from 'react';
import { View, Text } from 'react-native';

function HomeScreen() {
    CustomerIO.identify("person@example.com", {"first_name": "Dana"})
  return (
    <View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
      <Text>Home Screen</Text>
    </View>
  );
}
export default HomeScreen