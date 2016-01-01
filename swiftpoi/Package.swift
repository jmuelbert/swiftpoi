//
//  Package.swift
//  swiftpoi
//
//  Created by Jürgen Mülbert on 27.12.15.
//  Copyright © 2015 Jürgen Mülbert. All rights reserved.
//

#if os(linux)
import PackageDescription

    
let package = Package(
    name: "swiftpoi",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/jmuelbert/swiftpoi.git",
            majorVersion: 1),
    ]
)
#endif