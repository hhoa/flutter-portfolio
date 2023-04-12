enum RemoteConfigEnum {
  myName,
}

extension RemoteConfigExt on RemoteConfigEnum {
  String get key {
    switch (this) {
      case RemoteConfigEnum.myName:
        return 'my_name';
    }
  }
}
