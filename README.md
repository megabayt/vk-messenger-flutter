# vk_messenger_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Before start
Put android/google_maps_api.xml to app/src/main/res/ directory and insert api key for google maps
Copy ios/Runner/google_maps_api.plist.example as google_maps_api.plist and insert api key for google maps

## TODO List

- [x] Show out messages read flag
- [x] Read messages when entering chat
- [x] Long polling
  - [x] Message read
  - [x] Set friends online
- [x] Push notifications
  - [x] Messages
- [ ] Cache requests
- [ ] Rework attachments (remove separate page)
- [ ] Max attachments
- [ ] add access_key to attachments
https://firebase.flutter.dev/docs/installation/android
https://firebase.flutter.dev/docs/installation/ios
## Firebase CM for push notifications
Put your google_services.json file to android/app/ directory
Put your GoogleService-Info.plist file to ios/Runner/ directory

