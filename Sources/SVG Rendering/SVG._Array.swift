//
//  SVG._Array.swift
//  swift-svg-rendering
//

extension Array: SVG.View where Element: SVG.View {
    public var body: Never { fatalError("body should not be called") }

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ svg: Self,
        into buffer: inout Buffer,
        context: inout SVG.Context
    ) where Buffer.Element == UInt8 {
        for element in svg {
            Element._render(element, into: &buffer, context: &context)
        }
    }
}
