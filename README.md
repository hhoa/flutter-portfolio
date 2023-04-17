# flutter_app_web

A Flutter application to demonstrate my portfolio. It can be run on Web, iOS and Android.

## Table of contents

- [Prerequisites](#prerequisites)
- [Development](#development)
- [Folder structure](#folder-structure)
- [Deployment](#deployment)

## Prerequisites

- If you don't have Flutter setup yet. Please refer to the [Flutter Documentation page](https://docs.flutter.dev/get-started/install) for the setup.

## Development

Please follow these steps in order.

- **Use Flutter version [set in pubspec.yaml](https://github.com/hhoa/flutter-portfolio/blob/feature/flutter-3/pubspec.yaml#L22)**

  ```shell
  cd $(which flutter)/../.. && git checkout X.Y.Z && flutter precache
  ```
  
Then you can clone this project and run

```shell
cd flutter-portfolio;flutter pub get
```

## Folder structure

```txt
assets // contains fonts and images used in this app
lib // library folder
  enum // app enum
  model // data models and classes
  repository // remote config repo
  res // contains colors, contants, fonts and images used across the app
  route // app routes
  screens // app screens
  widgets // reusable widgets
  main.dart // application entry point
test // widget/unit tests located here
```

## Deployment

```shell
flutter build web
firebase init hosting
```

Then follow the steps in terminal. In question `What do you want to use as your public directory?` 
-> use `build/web` instead of `public`

After that we can run this command

```shell
firebase deploy
```