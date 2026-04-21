//
//  Project.swift
//  Manifests
//
//  Created by jiho9 on 4/21/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let name = "Core"

let project = Project(
    name: name,
    organizationName: Environment.workspaceName,
    options: .options(automaticSchemesOptions: .disabled),
    settings: .settings(
        base: .baseSettings,
        configurations: [
            .debug(name: "Debug"),
            .release(name: "Beta"),
            .release(name: "Release")
        ]
    ),
    targets: [
        .createTarget(
            name: name,
            type: .dynamicFramework,
            dependencies: []
        )
    ],
    schemes: [
        .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release)
        )
    ]
)
