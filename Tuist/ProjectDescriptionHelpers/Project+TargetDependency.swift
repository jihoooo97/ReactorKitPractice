//
//  Project+TargetDependency.swift
//  MatchTestManifests
//
//  Created by jiho9 on 4/21/26.
//

import ProjectDescription

public extension TargetDependency {
    
    enum Module {
        case Core
        case Data
        case Domain
        case Feature
        
        public var project: TargetDependency {
            .project(target: "\(self)", path: .relativeToRoot("Projects/\(self)"))
        }
    }
    
    
    enum Library {
        public static let Moya = TargetDependency.external(name: "Moya")
        public static let CombineMoya = TargetDependency.external(name: "CombineMoya")
        
        public static let GoogleSignIn = TargetDependency.external(name: "GoogleSignIn")
        public static let GoogleMobileAds = TargetDependency.external(name: "GoogleMobileAds")
        
        public static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
        public static let FirebaseCore = TargetDependency.external(name: "FirebaseCore")
        public static let FirebaseCrashtics = TargetDependency.external(name: "FirebaseCrashtics")
        public static let FirebaseFireStore = TargetDependency.external(name: "FirebaseFireStore")
        public static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
    }
    
}
