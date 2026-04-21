//
//  TargetModule.swift
//  MatchTestManifests
//
//  Created by jiho9 on 4/21/26.
//

public enum TargetModule {
    case app
    case dynamicFramework
    case staticFramework
    case unitTest
    case demo
    
    public var hasFramework: Bool {
        switch self {
        case .dynamicFramework, .staticFramework:
            return true
        default:
            return false
        }
    }
}
