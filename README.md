# hamikdash-frontend

I set the minSdkVersion to 21 (instead of 19)  in C:\runtimes\flutter\packages\flutter_tools\gradle\src\main\groovy\flutter.groovy, in order to avoid https://developer.android.com/build/multidex during compilation and debugging integratin tests:

rest of the sdks are:
compileSdkVersion = 34
targetSdkVersion = 33

explanation is here https://developer.android.com/guide/topics/manifest/uses-sdk-element

