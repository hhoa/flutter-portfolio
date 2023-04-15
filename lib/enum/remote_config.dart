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
  listAppBarTitleText,
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
      case RemoteConfigEnum.listAppBarTitleText:
        return 'list_appbar_title_text';
    }
  }

  dynamic get defaultValue {
    switch (this) {
      case RemoteConfigEnum.myNameText:
        return 'Hhoa.';
      case RemoteConfigEnum.linkCV:
        return 'https://drive.google.com/file/d/1aW4LMf1fT0udpMw5wNyAYQmQm3-youCY/view?usp=drivesdk';
      case RemoteConfigEnum.followMe:
        return '[{"icon":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ic_facebook.png?alt=media&token=a7f0e59a-bc9a-4ef8-8386-1bdf42df55c5","link":"https://www.facebook.com/hoangkhahoa"},{"icon":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ic_skype.png?alt=media&token=fb66850b-6b11-4ef5-822b-ee88a956628f","link":"https://join.skype.com/invite/n8I2LGeAlRnC"},{"icon":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ic_linkedin.png?alt=media&token=a2f2df1d-5c3c-43da-ae30-15a058b6a128","link":"https://www.linkedin.com/in/hoa-hoang-35944012b/"},{"icon":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ic_github.png?alt=media&token=b91265a6-e820-44bb-a52a-ebb1160d5f93","link":"https://github.com/hhoa"}]';
      case RemoteConfigEnum.experience:
        return '[{"company":"Fram^","description":"The only Swedish-Vietnamese IT company listed on prestigious NASDAQ stock exchange. At Fram^, I work as a contractor for NinjaVan to help them build Flutter Design System for the company and Dash Mobile app which is called Ninja Biz app on store to help shipper manage their orders.","time":"07/2021 - Present","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/fram_logo.png?alt=media&token=1a062bc9-a23c-4f7e-aba7-63f6b54ae380"},{"company":"Be Group","description":"Be is a Vietnamese tech company which is the CONNECTORS between customers and service providers. At Be Group, I have been building Cake - a digital bank that helps users to quickly create a banking account for some fundamental needs such as transferring money, managing cards or paying bills, etc.","time":"09/2020 - 07/2021","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/be_logo.png?alt=media&token=e2817fc7-d4fc-4ecf-85a2-cef294ddd017"},{"company":"Sendo","description":"Sendo is one of the leading e-commerce in Vietnam. At sendo, I built high quality landing pages such as Flash Sale and Daily Deal to integrate with Buyer app.","time":"05/2019 - 09/2020","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/sendo_logo.png?alt=media&token=7737a352-bd02-4f93-9a61-ad5659202df7"},{"company":"AIOZ","description":"AIOZ is a Singapore-based company. At AIOZ, I built mobile app that integrating cutting-edge technology like Computer Vision and Machine Learning to help resolve problems.","time":"01/2018 - 05/2019","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/aioz_logo.png?alt=media&token=8dcd5c97-e927-414d-9ed0-326584c0ac45"},{"company":"Robert BOSCH Vietnam","description":"The Bosch Group is a leading global supplier of technology and services. At Bosch, I worked with German customer to build software tool that log their work.","time":"07/2017 - 12/2017","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/bosch_logo.jpeg?alt=media&token=ed0194bb-d1b2-431a-88a5-d6c6bd449567"}]';
      case RemoteConfigEnum.project:
        return '[{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/flashsale_screen.jpeg?alt=media&token=4c812259-5cad-45d6-bdcf-82346eed0fa7","description":"Flash Sale - Hot deal in short time","link":"https://www.sendo.vn/flash-sale/"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/dailydeal_screen.jpeg?alt=media&token=08e5fcd3-d0a3-48a6-a6dc-2893b3459844","description":"Daily Deal - Hot deal in day","link":"https://www.sendo.vn/su-kien/deal-soc-moi-ngay"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/lmx_screen.jpeg?alt=media&token=53290916-10e6-41b2-869d-eb3eebfb4337","description":"Lac Mua Xu game running at Sendo","link":"http://sendo.onelink.me/dihK/c1fa8733"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/luckysale_screen.jpeg?alt=media&token=eb3c5a24-6f30-442f-8f79-6908cd4425bb","description":"Vong Quay Bay Gia game at Sendo","link":"https://sendo.onelink.me/Udvq/2f39c673"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/gos_screen.png?alt=media&token=13315b31-890a-4624-b34e-1e83969aa91c","description":"Game hub based on Songs with various artists and songs","link":"https://apps.apple.com/vn/app/game-of-songs-music-games/id1492267122?l=vi"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/cake_home_screen.PNG?alt=media&token=309b6b4c-9700-4a5f-a64b-5ae564b67b8d","description":"Cake - Digital Banking built with Flutter","link":"https://cake.vn/"},{"image":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ninja_biz_screen.PNG?alt=media&token=86a69483-636f-42a6-8c1f-ff29e444f8f5","description":"Ninja Biz App - Help shippers to manage their orders","link":"https://www.ninjavan.co/vi-vn/services/app-campaign"}]';
      case RemoteConfigEnum.nameTitleText:
        return 'I\'m Hoa Hoang';
      case RemoteConfigEnum.myselfIntroductionText:
        return 'I\'m a passionate Mobile Developer in HCMC';
      case RemoteConfigEnum.downloadCvText:
        return 'Download CV';
      case RemoteConfigEnum.recentProjectsText:
        return 'Recent Projects';
      case RemoteConfigEnum.moreInfoText:
        return 'More info';
      case RemoteConfigEnum.workExperienceText:
        return 'Work Experience';
      case RemoteConfigEnum.followMeText:
        return 'FOLLOW ME';
      case RemoteConfigEnum.listAppBarTitleText:
        return 'Home,Work,Projects,Contact';
    }
  }
}
