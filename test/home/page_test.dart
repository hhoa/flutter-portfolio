import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_web/enum/remote_config.dart';
import 'package:flutter_app_web/screens/home/sections/my_appbar/view/page.dart';
import 'package:flutter_app_web/screens/home/sections/my_appbar/view/view.dart';
import 'package:flutter_app_web/screens/home/sections/my_contact.dart';
import 'package:flutter_app_web/screens/home/sections/my_experience.dart';
import 'package:flutter_app_web/screens/home/sections/my_profile.dart';
import 'package:flutter_app_web/screens/home/sections/my_projects/view/page.dart';
import 'package:flutter_app_web/screens/home/sections/my_projects/widgets/project_image_description.dart';
import 'package:flutter_app_web/screens/home/view/page.dart';
import 'package:flutter_app_web/widgets/normal_text.dart';
import 'package:flutter_app_web/widgets/special_name.dart';
import 'package:flutter_app_web/widgets/timeline_experience.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../mock_app.dart';

void main() {
  testWidgets('can render', (WidgetTester tester) async {
    await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
          child: HomePage(),
        )));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);

    expect(find.byType(MyAppBar), findsOneWidget);

    await tester.dragUntilVisible(
      find.byType(MyProfile),
      find.byType(ScrollablePositionedList),
      const Offset(0, -200),
    );
    expect(find.byType(MyProfile), findsOneWidget);

    await tester.dragUntilVisible(
      find.byType(MyExperience),
      find.byType(ScrollablePositionedList),
      const Offset(0, -100),
    );
    expect(find.byType(MyExperience), findsOneWidget);

    await tester.dragUntilVisible(
      find.byType(MyProjects),
      find.byType(ScrollablePositionedList),
      const Offset(0, -100),
    );
    expect(find.byType(MyProjects), findsOneWidget);

    await tester.dragUntilVisible(
      find.byType(MyContact),
      find.byType(ScrollablePositionedList),
      const Offset(0, -100),
    );
    expect(find.byType(MyContact), findsOneWidget);
  });

  group('My AppBar', () {
    testWidgets('Web view', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      expect(find.byType(MyAppBarWeb), findsOneWidget);
      expect(find.byType(NormalText), findsNWidgets(4));
      expect(find.byType(SpecialTextName), findsOneWidget);
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is Container &&
              widget.key == const Key('container-appbar-web')) {
            return (widget.decoration as BoxDecoration).boxShadow == null;
          } else {
            return false;
          }
        }),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is NormalText && widget.text == 'Home') {
            return widget.isChosen;
          } else {
            return false;
          }
        }),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is NormalText) {
            return !widget.isChosen;
          } else {
            return false;
          }
        }),
        findsNWidgets(3),
      );

      await tester.tap(find.byKey(const Key('normalText-Work')));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.byType(MyProfile), findsNothing);
      expect(find.byType(MyExperience), findsOneWidget);
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is Container &&
              widget.key == const Key('container-appbar-web')) {
            return (widget.decoration as BoxDecoration).boxShadow != null;
          } else {
            return false;
          }
        }),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('normalText-Projects')));
      await tester.pumpAndSettle();
      expect(find.byType(MyProjects), findsOneWidget);

      await tester.tap(find.byKey(const Key('normalText-Contact')));
      await tester.pumpAndSettle();
      expect(find.byType(MyContact), findsOneWidget);
    });

    testWidgets('Mobile view', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;

      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      expect(find.byType(MyAppBarMobile), findsOneWidget);
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is Container &&
              widget.key == const Key('container-appbar-mobile')) {
            return (widget.decoration as BoxDecoration).boxShadow == null;
          } else {
            return false;
          }
        }),
        findsOneWidget,
      );

      expect(find.byType(NormalText), findsNothing);
      await tester.tap(find.byKey(const Key('appbar-icon-menu')));
      await tester.pumpAndSettle();
      expect(find.byType(NormalText), findsNWidgets(4));

      await tester.tap(find.byKey(const Key('appbar-icon-close')));
      await tester.pumpAndSettle();
      expect(find.byType(NormalText), findsNothing);

      await tester.tap(find.byKey(const Key('appbar-icon-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('normalText-Work')));
      await tester.pumpAndSettle(const Duration(milliseconds: 500));
      expect(find.byType(MyProfile), findsNothing);
      expect(find.byType(MyExperience), findsOneWidget);
      expect(
        find.byWidgetPredicate((Widget widget) {
          if (widget is Container &&
              widget.key == const Key('container-appbar-mobile')) {
            return (widget.decoration as BoxDecoration).boxShadow != null;
          } else {
            return false;
          }
        }),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('appbar-icon-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('normalText-Projects')));
      await tester.pumpAndSettle();
      expect(find.byType(MyProjects), findsOneWidget);

      await tester.tap(find.byKey(const Key('appbar-icon-menu')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('normalText-Contact')));
      await tester.pumpAndSettle();
      expect(find.byType(MyContact), findsOneWidget);
    });
  });

  group('My Profile', () {
    testWidgets('can render', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      expect(find.byType(MyProfile), findsOneWidget);
      expect(
          find.byKey(
            const Key('profile-downloadcv'),
          ),
          findsOneWidget);
      await tester.tap(find.byKey(const Key('profile-downloadcv')));
      await tester.pumpAndSettle();
    });
  });

  group('My Experience', () {
    testWidgets('can render default', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.byType(MyExperience),
        find.byType(ScrollablePositionedList),
        const Offset(0, -100),
      );
      expect(find.byType(MyExperience), findsOneWidget);
      expect(find.byType(TimelineExperience), findsWidgets);
      expect(find.byType(TimelineTile), findsWidgets);
    });

    testWidgets('can render custom config', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MockApp(
            customMap: {
              RemoteConfigEnum.experience.key:
                  '[{"company":"Be Group","description":"Be is a Vietnamese tech company which is the CONNECTORS between customers and service providers. At Be Group, I have been building Cake - a digital bank that helps users to quickly create a banking account for some fundamental needs such as transferring money, managing cards or paying bills, etc.","time":"09/2020 - Present","logo":"https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/be_logo.png?alt=media&token=e2817fc7-d4fc-4ecf-85a2-cef294ddd017"}]',
            },
            child: const HomePage(),
          )));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.byType(MyExperience),
        find.byType(ScrollablePositionedList),
        const Offset(0, -100),
      );
      expect(find.byType(MyExperience), findsOneWidget);
      expect(find.byType(TimelineExperience), findsOneWidget);
      expect(find.byType(TimelineTile), findsOneWidget);
    });
  });

  group('My Contact', () {
    testWidgets('can render', (WidgetTester tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.byType(MyContact),
        find.byType(ScrollablePositionedList),
        const Offset(0, -100),
      );
      expect(find.byType(MyContact), findsOneWidget);
      expect(find.byType(ContactIcon), findsNWidgets(4));

      await tester.tap(find.byType(ContactIcon).first, warnIfMissed: false);
      await tester.pumpAndSettle();
    });
  });

  group('My Projects', () {
    testWidgets('can render web', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(1280, 800);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.byType(MyProjects),
        find.byType(ScrollablePositionedList),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MyProjects), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(ProjectImageDescription), findsWidgets);
      expect(find.byType(MouseRegion), findsWidgets);
      expect(find.byType(BackdropFilter), findsWidgets);

      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      addTearDown(gesture.removePointer);
      await tester.pump();
      final bizImage = find.byWidgetPredicate((Widget widget) =>
          widget is CachedNetworkImage &&
          widget.imageUrl ==
              'https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ninja_biz_screen.PNG?alt=media&token=86a69483-636f-42a6-8c1f-ff29e444f8f5');
      await gesture.moveTo(tester.getCenter(bizImage));
      await tester.pumpAndSettle();
      expect(find.text('Ninja Biz App - Help shippers to manage their orders'),
          findsOneWidget);

      await tester.tap(find.text('More info'));
      await tester.pumpAndSettle();
    });

    testWidgets('can render mobile', (WidgetTester tester) async {
      tester.binding.window.physicalSizeTestValue = const Size(400, 600);
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      await mockNetworkImagesFor(() => tester.pumpWidget(const MockApp(
            child: HomePage(),
          )));
      await tester.pumpAndSettle();

      await tester.dragUntilVisible(
        find.byType(MyProjects),
        find.byType(ScrollablePositionedList),
        const Offset(0, -100),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MyProjects), findsOneWidget);
      expect(find.byType(PageView), findsOneWidget);
      expect(find.byType(ProjectImageDescription), findsWidgets);
      expect(find.byType(BackdropFilter), findsWidgets);

      final bizImage = find.byWidgetPredicate((Widget widget) =>
          widget is CachedNetworkImage &&
          widget.imageUrl ==
              'https://firebasestorage.googleapis.com/v0/b/flutter-portfolio-e116e.appspot.com/o/ninja_biz_screen.PNG?alt=media&token=86a69483-636f-42a6-8c1f-ff29e444f8f5');
      await tester.tap(bizImage);
      await tester.pumpAndSettle();
      expect(find.text('Ninja Biz App - Help shippers to manage their orders'),
          findsOneWidget);

      await tester.tap(find.text('More info'));
      await tester.pumpAndSettle();
    });
  });
}
