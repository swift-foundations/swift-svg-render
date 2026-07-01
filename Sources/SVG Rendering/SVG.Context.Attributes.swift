//
//  SVG.Context.Attributes.swift
//  swift-svg-render
//

public import Dictionary_Primitives
public import Dictionary_Ordered_Primitives
public import Shared_Primitive
public import Hash_Indexed_Primitive
public import Hash_Primitives
public import Column_Primitives
public import Buffer_Linear_Primitive

extension SVG.Context {
    /// The ordered set of attributes applied to the next element: a value-semantic
    /// (copy-on-write) insertion-ordered `String` → `String` map.
    ///
    /// Carried on the dictionary-primitives `Shared` column, so it stays `Copyable`
    /// and `Sendable` — the rendering value tree holds it by value, and the box
    /// detaches on the first mutation of a shared copy.
    public typealias Attributes = Dictionary<
        Shared<Hash.Entry<String, String>, Hash.Indexed<Column.Heap<Hash.Entry<String, String>>>>
    >.Ordered
}
