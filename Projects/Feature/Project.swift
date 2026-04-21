//
//  Project.swift
//  Manifests
//
//  Created by jiho9 on 4/21/26.
//

import ProjectDescription
import ProjectDescriptionHelpers

let name = "Feature"

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
            type: .staticFramework,
            dependencies: [
                .Module.Domain.project
            ]
        ),
        .createTarget(
            name: name + "Tests",
            type: .unitTest,
            dependencies: [.target(name: name)]
        )
    ],
    schemes: [
        .scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(["\(name)Tests"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release)
        )
    ]
)
