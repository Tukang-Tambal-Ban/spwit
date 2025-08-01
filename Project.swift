import ProjectDescription

let baseAppBundleId: String = Environment.bundleId.getString(default: "com.ada.il")
let appName: String = "spwit"

func bundleId(for target: String) -> String {
    return "\(baseAppBundleId).\(target)"
}

let project = Project(
    name: appName,
    targets: [
        .target(
            name: appName,
            destinations: .iOS,
            product: .app,
            bundleId: bundleId(for: appName),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "UILaunchScreen": [
                        "UIImageName": "LaunchScreen"
                    ],
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName":
                                        "$(PRODUCT_MODULE_NAME).SceneDelegate",
                                        // "UISceneStoryboardFile": "Main"
                                ]
                            ]
                        ],
                    ]
                ]
            ),
            sources: ["spwit/Sources/**"],
            resources: ["spwit/Resources/**"],
            // "spwit/Sources/**/*.storyboard", "spwit/Sources/**/*.xib",
            dependencies: [
                .external(name: "Alamofire")
            ]
        ),
        .target(
            name: "\(appName)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: bundleId(for: "\(appName)Tests"),
            infoPlist: .default,
            // sources: ["spwit/Tests/**"],
            resources: [],
            dependencies: [.target(name: appName)]
        ),
    ]
)
