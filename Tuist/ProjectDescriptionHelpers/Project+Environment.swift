//
//  Project+Environment.swift
//  ProjectDescriptionHelpers
//
//  Created by jiho9 on 3/31/26.
//

import Foundation
import ProjectDescription

// MARK: Environment

public enum ConfigurationType {
    case release
    case beta
    case debug
}

public extension Environment {
    static let workspaceName = "MatchTest"
    static let deploymentTarget = DeploymentTargets.iOS("18.4")
    static let destinations: Destinations = [Destination.iPhone]
    static let bundlePrefix = "com.MatchTest."
    static let teamID = "3LTN66N935"
}

// MARK: SettingsDictionary

public extension SettingsDictionary {
    static let allLoadSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited) -all_load",
            "-Xlinker -interposable"
        ]
    ]
    
    static let baseSettings: Self = [
        "OTHER_LDFLAGS" : [
            "$(inherited)",
            "-ObjC"
        ],
    ]
    
    func setSwiftActiveComplationConditions(_ value: String) -> SettingsDictionary {
        merging(["SWIFT_ACTIVE_COMPILATION_CONDITIONS": SettingValue(stringLiteral: value)])
    }
    
    func setCodeSignManual() -> SettingsDictionary {
        merging(["CODE_SIGN_STYLE": SettingValue(stringLiteral: "Manual")])
            .merging(["DEVELOPMENT_TEAM": SettingValue(stringLiteral: Environment.teamID)])
            .merging(["CODE_SIGN_IDENTITY": SettingValue(stringLiteral: "$(CODE_SIGN_IDENTITY)")])
    }
    
    func setProvisioning() -> SettingsDictionary {
        merging(["PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "$(APP_PROVISIONING_PROFILE)")])
            .merging(["PROVISIONING_PROFILE": SettingValue(stringLiteral: "$(APP_PROVISIONING_PROFILE)")])
    }
}


// MARK: Info.plist

public extension Project {
    static let defaultInfoPlist: [String: Plist.Value] = [
        "CFBundleVersion": .string("$(CURRENT_PROJECT_VERSION)"),
        "CFBundleDisplayName": .string("$(APP_NAME)"),
        "CFBundleIdentifier": .string("$(PRODUCT_BUNDLE_IDENTIFIER)"),
        "PROVISIONING_PROFILE_SPECIFIER": .string("$(PROVISIONING_PROFILE_SPECIFIER)"),
        "UIUserInterfaceStyle": .string("Light"),
        "UIBackgroundModes": .array([
            .string("remote-notification"),
            .string("fetch")
        ]),
        "UIAppFonts": .array([]),
        "UILaunchStoryboardName": .string("LaunchScreen"),
        "UIApplicationSceneManifest": .dictionary([
            "UIApplicationSupportsMultipleScenes": .boolean(false),
            "UISceneConfigurations": .dictionary([:])
        ]),
        "NSAppTransportSecurity": .dictionary([
            "NSAllowsArbitraryLoads": .boolean(true)
        ]),
    ]
}
