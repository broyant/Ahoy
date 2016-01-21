//
//  OTRConstants.h
//  Off the Record
//
//  Created by David Chiles on 6/28/12.
//  Copyright (c) 2012 Chris Ballinger. All rights reserved.
//
//  This file is part of ChatSecure.
//
//  ChatSecure is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  ChatSecure is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with ChatSecure.  If not, see <http://www.gnu.org/licenses/>.
#import "OTRConstants.h"

NSString *const kOTRProtocolLoginSuccess                   = @"LoginSuccessNotification";
NSString *const kOTRProtocolLoginFail                      = @"LoginFailedNotification";
NSString *const kOTRProtocolLoginFailErrorKey              = @"ProtocolLoginFailErrorKey";
NSString *const kOTRProtocolLoginFailSSLStatusKey          = @"kOTRProtocolLoginFailSSLStatusKey";
NSString *const kOTRProtocolLoginFailHostnameKey           = @"kOTRProtocolLoginFailHostnameKey";
NSString *const kOTRProtocolLoginFailSSLCertificateDataKey = @"kOTRProtocolLoginFailSSLCertificateData";
NSString *const kOTRNotificationErrorKey                   = @"kOTRNotificationErrorKey";
NSString *const kOTRProtocolLoginUserInitiated             = @"kOTRProtocolLoginUserInitiated";

NSString *const kOTRGoogleTalkDomain = @"talk.google.com";
NSString *const kOTRProtocolTypeXMPP = @"xmpp";
NSString *const kOTRProtocolTypeAIM  = @"prpl-oscar";

NSString *const kOTRNotificationAccountNameKey   = @"kOTRNotificationAccountNameKey";
NSString *const kOTRNotificationUserNameKey      = @"kOTRNotificationUserNameKey";
NSString *const kOTRNotificationProtocolKey      = @"kOTRNotificationProtocolKey";
NSString *const kOTRNotificationBuddyUniqueIdKey = @"kOTRNotificationBuddyUniqueIdKey";

NSString *const kOTRXMPPResource = @"chatsecure";

NSString *const kOTRFeedbackEmail = @"support@chatsecure.org";

//NSString *const kOTRServiceName            = @"org.chatsecure.ChatSecure";
//NSString *const kOTRCertificateServiceName = @"org.chatsecure.ChatSecure.Certificate";

NSString *const kOTRSettingKeyFontSize                 = @"kOTRSettingKeyFontSize";
NSString *const kOTRSettingKeyDeleteOnDisconnect       = @"kOTRSettingKeyDeleteOnDisconnect";
NSString *const kOTRSettingKeyOpportunisticOtr         = @"kOTRSettingKeyOpportunisticOtr";
NSString *const kOTRSettingKeyShowDisconnectionWarning = @"kOTRSettingKeyShowDisconnectionWarning";
NSString *const kOTRSettingUserAgreedToEULA            = @"kOTRSettingUserAgreedToEULA";
NSString *const kOTRSettingAccountsKey                 = @"kOTRSettingAccountsKey";
NSString *const kOTRSettingKeyLanguage                 = @"userSelectedSetting";
NSString *const kOTRSettingsValueUpdatedNotification = @"kOTRSettingsValueUpdatedNotification";


NSString *const kOTRAppVersionKey     = @"kOTRAppVersionKey";
NSString *const OTRActivityTypeQRCode = @"OTRActivityTypeQRCode";

NSString *const OTRArchiverKey = @"OTRArchiverKey";

NSString *const GOOGLE_APP_ID    = @"719137339288.apps.googleusercontent.com";
NSString *const GOOGLE_APP_SCOPE = @"https://www.googleapis.com/auth/googletalk";

NSString *const kOTRErrorDomain = @"com.chatsecure";


NSString *const OTRFailedRemoteNotificationRegistration = @"OTRFailedRemoteNotificationRegistration";
NSString *const OTRSuccessfulRemoteNotificationRegistration = @"OTRSuccessfulRemoteNotificationRegistration";


NSString *const AHYYapDatabasePassphraseAccountName = @"AHYYapDatabasePassphraseAccountName";
//NSString *const OTRYapDatabaseName = @"OTRChatYap.sqlite";
NSString *const kAHYServiceName            = @"com.ahoy.com.chat";
NSString *const kAHYCertificateServiceName = @"com.ahoy.com.chat.Certificate";

//NSUserDefaults
NSString *const kOTRDeletedFacebookKey = @"kOTRDeletedFacebookKey";

//Chatview
CGFloat const kOTRSentDateFontSize            = 13;
CGFloat const kOTRDeliveredFontSize           = 13;
CGFloat const kOTRMessageFontSize             = 16;
CGFloat const kOTRMessageSentDateLabelHeight  = kOTRSentDateFontSize + 7;
CGFloat const kOTRMessageDeliveredLabelHeight = kOTRDeliveredFontSize + 7;

NSUInteger const kOTRMinimumPassphraseLength = 8;
NSUInteger const kOTRMaximumPassphraseLength = 64;

#pragma mark - Msg Type
NSString *const kNOTIF_TEXT_MSG = @"NOTIF_TEXT_MSG";
NSString *const kNOTIF_IMAGE_MSG = @"NOTIF_IMAGE_MSG";
NSString *const kNOTIF_VIDEO_MSG = @"NOTIF_VIDEO_MSG";
NSString *const kNOTIF_VOICE_MSG = @"NOTFI_VOICE_MSG";
NSString *const kNOTIF_EMOTICON_MSG = @"NOTFI_EMOTICON_MSG";

NSString *const kNOTIF_SYS_MSG = @"NOTIF_SYS_MSG";
NSString *const kNOTIF_FRIEND_MSG = @"NOTIF_FRIEND_MSG";
NSString *const kNOTIF_ROOM_MSG = @"NOTIF_ROOM_MSG";
NSString *const kNOTIF_CHANNEL_MSG = @"NOTIF_CHANNEL_MSG";
NSString *const kNOTIF_GROUP_MSG = @"NOTIF_GROUP_MSG";
NSString *const kNOTIF_CHAT_MSG = @"NOTIF_CHAT_MSG";
NSString *const kNOTIF_FREECALL_MSG = @"NOTIF_FREECALL_MSG";
NSString *const kNOTIF_LOCATION_MSG = @"NOTIF_LOCATION_MSG";

