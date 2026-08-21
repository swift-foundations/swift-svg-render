extension SVG {
    public struct Raw: SVG.View {

        let content: String

        public init(_ content: String) {
            self.content = content
        }
    }
}

extension SVG.Raw {

    public static func _render<Buffer: RangeReplaceableCollection>(
        _ svg: Self,
        into buffer: inout Buffer,
        context: inout SVG.Context
    ) where Buffer.Element == UInt8 {
        buffer.append(contentsOf: svg.content.utf8)
    }

    public var body: Never { fatalError("body should not be called") }
}
