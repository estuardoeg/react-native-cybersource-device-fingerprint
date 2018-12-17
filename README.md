
# react-native-cybersource-device-fingerprint

## Getting started

`$ yarn add https://github.com/estuardoeg/react-native-cybersource-device-fingerprint`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-cybersource-device-fingerprint` and add `RNCybersourceDeviceFingerprint.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNCybersourceDeviceFingerprint.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Add pod 'RNCybersourceDeviceFingerprint', :path => '../node_modules/react-native-cybersource-device-fingerprint/ios' to your Podfile
5. Run pod install from ios folder
5. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.estuardoeg.CybersourceDeviceFingerprint.RNCybersourceDeviceFingerprintPackage;` to the imports at the top of the file
  - Add `new RNCybersourceDeviceFingerprintPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-cybersource-device-fingerprint'
  	project(':react-native-cybersource-device-fingerprint').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-cybersource-device-fingerprint/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      implementation project(':react-native-cybersource-device-fingerprint')
  	```


## Usage
```javascript
import RNCybersourceDeviceFingerprint from 'react-native-cybersource-device-fingerprint'


        
// TODO: What to do with the module?
RNCybersourceDeviceFingerprint.getSessionID( deviceFingerprint => {
		console.log('deviceFingerprint', deviceFingerprint)
});
```
  