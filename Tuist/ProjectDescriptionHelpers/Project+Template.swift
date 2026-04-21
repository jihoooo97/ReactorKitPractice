//
//  Project+Template.swift
//  MatchTestManifests
//
//  Created by jiho9 on 4/21/26.
//

import Foundation
import ProjectDescription

public extension Target {
    
    static func createTarget(
        name: String,
        type: TargetModule,
        infoPlist: InfoPlist? = .default,
        hasResource: Bool = false,
        dependencies: [TargetDependency] = [],
    ) -> Target {
        let productType: Product = type == .app ? .app
        : type == .dynamicFramework ? .framework : .staticFramework
        let baseSetting: SettingsDictionary = .baseSettings
        
        return .target(
            name: name,
            destinations: [.iPhone],
            product: productType,
            bundleId: Environment.bundlePrefix + name,
            deploymentTargets: Environment.deploymentTarget,
            infoPlist: infoPlist,
            sources: [type == .unitTest ? "Tests/**/*.swift" : "Sources/**/*.swift"],
            resources:  hasResource ? [.glob(pattern: "Resources/**", excluding: [])] : [],
            dependencies: dependencies,
            settings: .settings(
                base: type == .app ? baseSetting.setCodeSignManual() : baseSetting,
                configurations: type == .app
                ? Configuration.appConfiguration
                : Configuration.moduleConfiguration
            )
        )
    }
    
}


public extension Scheme {
    
    static func createScheme(
        name: String,
        configuration: ConfigurationType = .debug,
        hasTest: Bool = false
    ) -> Scheme {
        let testTargets: [TestableTarget] = hasTest ? ["\(name)Tests"] : []
        
        switch configuration {
        case .release:
            return Scheme.scheme(
                name: name + "-Release",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                testAction: .targets(testTargets, configuration: .release),
                runAction: .runAction(configuration: .release),
                archiveAction: .archiveAction(configuration: .release)
            )
        case .beta:
            return Scheme.scheme(
                name: name + "-Beta",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                testAction: .targets(testTargets, configuration: .init(stringLiteral: "Beta")),
                runAction: .runAction(configuration: .init(stringLiteral: "Beta")),
                archiveAction: .archiveAction(configuration: .init(stringLiteral: "Beta"))
            )
        case .debug:
            return Scheme.scheme(
                name: name + "-Debug",
                shared: true,
                buildAction: .buildAction(targets: ["\(name)"]),
                testAction: .targets(testTargets, configuration: .debug),
                runAction: .runAction(configuration: .debug)
            )
        }
    }
    
}

fileprivate extension Configuration {
    
    static let appConfiguration: [Configuration] = [
        .release(
            name: "Release",
            settings: [
                "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: Environment.bundlePrefix + "Release"),
                "PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "match AppStore " + Environment.bundlePrefix + "Release")
            ]
        ),
        .release(
            name: "Beta",
            settings: [
                "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: Environment.bundlePrefix + "Release"),
                "PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "match AppStore " + Environment.bundlePrefix + "Release")
            ]
        ),
        .debug(
            name: "Debug",
            settings: [
                "PRODUCT_BUNDLE_IDENTIFIER": SettingValue(stringLiteral: Environment.bundlePrefix + "Debug"),
                "PROVISIONING_PROFILE_SPECIFIER": SettingValue(stringLiteral: "match Development " + Environment.bundlePrefix + "Debug"),
            ]
        )
    ]
    
    static let moduleConfiguration: [Configuration] = [
        .debug(name: "Debug"),
        .release(name: "Beta"),
        .release(name: "Release")
    ]
    
}
