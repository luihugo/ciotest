import Foundation
import UserNotifications
import CioMessagingPushFCM
import CioTracking

@objc
public class MyAppNotificationServicePushHandler : NSObject {

  public override init() {}

  @objc(didReceive:withContentHandler:)
  public func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {

    // You may choose to configure the SDK here
    // Update region to .EU for your EU-based workspace
    CustomerIO.initialize(siteId: "1a8e9757fd8aad69f3ff", apiKey: "c58d31f9ece3acbc3a8b", region: .US) { config in
        config.autoTrackDeviceAttributes = true
        config.logLevel = .info
    }
    MessagingPush.shared.didReceive(request, withContentHandler: contentHandler)
  }

  @objc(serviceExtensionTimeWillExpire)
  public func serviceExtensionTimeWillExpire() {
    MessagingPush.shared.serviceExtensionTimeWillExpire()
  }
}
