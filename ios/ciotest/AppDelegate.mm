
#import <ciotest-Swift.h>
#import <FirebaseCore.h>
#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>

@implementation AppDelegate
MyAppPushNotificationsHandler* pnHandlerObj = [[MyAppPushNotificationsHandler alloc] init];
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"ciotest";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};
  // Configure Firebase
  [FIRApp configure];
  // Set FCM messaging delegate
  [FIRMessaging messaging].delegate = self;

  [pnHandlerObj setupCustomerIOClickHandling:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
  [pnHandlerObj didReceiveRegistrationToken:messaging fcmToken: fcmToken];
}

// Send push notification click events to the Customer.IO SDK for processing
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
  [pnHandlerObj userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

// (Optional) Add the following code to show your push notifications even when your app is in the foreground.
- (void)userNotificationCenter:(UNUserNotificationCenter* )center willPresentNotification:(UNNotification* )notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler {
  completionHandler(UNNotificationPresentationOptionAlert + UNNotificationPresentationOptionSound);
}


- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

/// This method controls whether the `concurrentRoot`feature of React18 is turned on or off.
///
/// @see: https://reactjs.org/blog/2022/03/29/react-v18.html
/// @note: This requires to be rendering on Fabric (i.e. on the New Architecture).
/// @return: `true` if the `concurrentRoot` feature is enabled. Otherwise, it returns `false`.
- (BOOL)concurrentRootEnabled
{
  return true;
}

@end
