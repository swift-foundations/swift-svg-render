//
//  Never+SVG.swift
//  swift-svg-rendering
//

extension Never: SVG.View {
    @inlinable
    public static func _render<Buffer: RangeReplaceableCollection>(
        _ markup: Self,
        into buffer: inout Buffer,
        context: inout SVG.Context
    ) where Buffer.Element == UInt8 {}
}
