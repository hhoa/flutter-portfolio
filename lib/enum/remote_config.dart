enum RemoteConfigEnum {
  myNameText,
  linkCV,
  followMe,
  experience,
  project,
  nameTitleText,
  myselfIntroductionText,
  downloadCvText,
  recentProjectsText,
  moreInfoText,
  workExperienceText,
  followMeText,
}

extension RemoteConfigExt on RemoteConfigEnum {
  String get key {
    switch (this) {
      case RemoteConfigEnum.myNameText:
        return 'my_name_text';
      case RemoteConfigEnum.linkCV:
        return 'link_cv';
      case RemoteConfigEnum.followMe:
        return 'follow_me';
      case RemoteConfigEnum.experience:
        return 'experience';
      case RemoteConfigEnum.project:
        return 'project';
      case RemoteConfigEnum.nameTitleText:
        return 'name_title_text';
      case RemoteConfigEnum.myselfIntroductionText:
        return 'myself_introduction_text';
      case RemoteConfigEnum.downloadCvText:
        return 'download_cv_text';
      case RemoteConfigEnum.recentProjectsText:
        return 'recent_projects_text';
      case RemoteConfigEnum.moreInfoText:
        return 'more_info_text';
      case RemoteConfigEnum.workExperienceText:
        return 'work_experience_text';
      case RemoteConfigEnum.followMeText:
        return 'follow_me_text';
    }
  }
}
