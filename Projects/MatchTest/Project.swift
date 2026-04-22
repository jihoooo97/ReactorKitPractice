//
//  Project.swift
//  Manifests
//
//  Created by jiho9 on 4/21/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let name = Environment.workspaceName

let project = Project(
    name: name,
    organizationName: Environment.workspaceName,
    options: .options(automaticSchemesOptions: .disabled),
    settings: .settings(
        base: .baseSettings.setCodeSignManual().setProvisioning(),
        configurations: Configuration.appConfiguration
    ),
    targets: [
        .createTarget(
            name: name,
            type: .app,
            infoPlist: .extendingDefault(with: Project.defaultInfoPlist),
            hasResource: true,
            dependencies: [
                .Module.Data.project,
                .Module.Feature.project
            ]
        )
    ],
    schemes: [
        .createScheme(name: name, configuration: .release),
        .createScheme(name: name, configuration: .beta),
        .createScheme(name: name, configuration: .debug)
    ]
)
