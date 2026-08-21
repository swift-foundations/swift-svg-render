extension StringProtocol {

    public init(
        _ svg: some SVG.View,
        configuration: SVG.Context.Configuration? = nil
    ) {
        let bytes = ContiguousArray(svg, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}

extension StringProtocol {

    @inlinable
    public init<T: SVG.View>(
        _ view: T,
        configuration: SVG.Context.Configuration? = nil
    ) async {
        let bytes = await [UInt8](view, configuration: configuration)
        self = Self(decoding: bytes, as: UTF8.self)
    }
}
