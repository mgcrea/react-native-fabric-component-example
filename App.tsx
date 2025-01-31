import React from 'react';
import {StyleSheet, View} from 'react-native';
import NativeColorView from './specs/ColorViewNativeComponent';

function App(): React.JSX.Element {
  return (
    <View style={styles.container}>
      {/* <WebView
        sourceURL="https://react.dev/"
        style={styles.webview}
        onScriptLoaded={() => {
          Alert.alert('Page Loaded');
        }}
      /> */}
      <NativeColorView color="#32a852" style={styles.box} />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: 'palegreen',
  },
  webview: {
    width: '100%',
    height: '100%',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});

export default App;
