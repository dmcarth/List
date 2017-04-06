// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "List",
	targets: [
		Target(name: "List", dependencies: ["liblist"])
	]
)
