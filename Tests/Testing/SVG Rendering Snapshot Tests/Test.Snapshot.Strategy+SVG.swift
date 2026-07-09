//
//  Test.Snapshot.Strategy+SVG.swift
//  swift-svg-rendering
//
//  Snapshot strategy for SVG rendering.
//

import SVG_Rendering
import Test_Snapshot_Primitives

extension Test.Snapshot.Strategy where Value: SVG.View, Format == String {
    static var svg: Self {
        .svg()
    }

    static func svg(
        configuration: SVG.Context.Configuration = .default
    ) -> Self {
        Test.Snapshot.Strategy<String, String>.lines.pullback { value in
            String(value, configuration: configuration)
        }
    }
}
