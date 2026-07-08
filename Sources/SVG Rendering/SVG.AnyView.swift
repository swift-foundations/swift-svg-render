//
//  SVG.AnyView.swift
//  swift-svg-renderable
//
//  Created by Coen ten Thije Boonkkamp on 26/11/2025.
//

// swiftlint:disable no_any_protocol_existential
// reason: AnyView is SVG's type-erasure wrapper — its stored `base` and
// both initializers must accept any conforming SVG.View at the call site;
// `some SVG.View` would fix a single concrete type and defeat the eraser.
/// Type-erased SVG element that can hold any SVG content.
extension SVG {
    public struct AnyView: SVG.View {
        let base: any SVG.View

        public init(_ base: any SVG.View) {
            self.base = base
        }
    }
}

extension SVG.AnyView {
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ svg: SVG.AnyView,
        into buffer: inout Buffer,
        context: inout SVG.Context
    ) where Buffer.Element == UInt8 {
        func render<T: SVG.View>(_ element: T) {
            T._render(element, into: &buffer, context: &context)
        }
        render(svg.base)
    }

    public var body: Never { fatalError("body should not be called") }
}

extension SVG.AnyView {
    public init(_ closure: () -> any SVG.View) {
        self = .init(closure())
    }
}
// swiftlint:enable no_any_protocol_existential
