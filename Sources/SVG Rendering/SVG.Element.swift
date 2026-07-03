//
//  SVG.Element.swift
//  swift-svg-rendering
//

import ASCII_Primitives
import Dictionary_Ordered_Primitives

extension SVG {
    /// Represents an SVG element with a tag, attributes, and optional content.
    public struct Element<Content: SVG.View>: SVG.View {
        /// The SVG tag name (e.g., "circle", "rect", "path").
        let tag: String

        /// The optional content contained within this element.
        @SVG.Builder public let content: Content?

        /// Creates a new SVG element with the specified tag and content.
        public init(tag: String, @SVG.Builder content: () -> Content? = { Never?.none }) {
            self.tag = tag
            self.content = content()
        }

        /// Renders this SVG element into the provided buffer.
        public static func _render<Buffer: RangeReplaceableCollection>(
            _ svg: Self,
            into buffer: inout Buffer,
            context: inout SVG.Context
        ) where Buffer.Element == UInt8 {
            // Add newline and indentation (skip leading newline at root level)
            if !context.currentIndentation.isEmpty {
                buffer.append(contentsOf: context.configuration.newline)
            }
            buffer.append(contentsOf: context.currentIndentation)

            // Write opening tag
            buffer.append(ASCII.Character.Graphic.lessThanSign)
            buffer.append(contentsOf: svg.tag.utf8)

            // Add attributes from context (set via method chaining like .fill(), .cx(), etc.)
            context.attributes.forEach { name, value in
                buffer.append(ASCII.SPACE.sp)
                buffer.append(contentsOf: name.utf8)
                if !value.isEmpty {
                    buffer.append(ASCII.Character.Graphic.equalsSign)
                    buffer.append(ASCII.Character.Graphic.quotationMark)

                    // Single-pass: iterate directly over UTF-8 view, escape as needed
                    for byte in value.utf8 {
                        switch byte {
                        case ASCII.Character.Graphic.quotationMark:
                            buffer.append(contentsOf: [UInt8].svg.doubleQuotationMark)

                        case ASCII.Character.Graphic.apostrophe:
                            buffer.append(contentsOf: [UInt8].svg.apostrophe)

                        case ASCII.Character.Graphic.ampersand:
                            buffer.append(contentsOf: [UInt8].svg.ampersand)

                        case ASCII.Character.Graphic.lessThanSign:
                            buffer.append(contentsOf: [UInt8].svg.lessThan)

                        case ASCII.Character.Graphic.greaterThanSign:
                            buffer.append(contentsOf: [UInt8].svg.greaterThan)

                        default:
                            buffer.append(byte)
                        }
                    }

                    buffer.append(ASCII.Character.Graphic.quotationMark)
                }
            }
            buffer.append(ASCII.Character.Graphic.greaterThanSign)

            // Render content if present
            if let content = svg.content {
                let oldAttributes = context.attributes
                let oldIndentation = context.currentIndentation
                defer {
                    context.attributes = oldAttributes
                    context.currentIndentation = oldIndentation
                }
                context.attributes.removeAll()
                context.currentIndentation += context.configuration.indentation
                Content._render(content, into: &buffer, context: &context)
            }

            // Add closing tag (SVG elements are not void/self-closing in the HTML sense)
            buffer.append(contentsOf: context.configuration.newline)
            buffer.append(contentsOf: context.currentIndentation)
            buffer.append(ASCII.Character.Graphic.lessThanSign)
            buffer.append(ASCII.Character.Graphic.slant)
            buffer.append(contentsOf: svg.tag.utf8)
            buffer.append(ASCII.Character.Graphic.greaterThanSign)
        }

        /// This type uses direct rendering and doesn't have a body.
        public var body: Never {
            fatalError("body should not be called")
        }
    }
}

extension SVG.Element: Sendable where Content: Sendable {}

// MARK: - SVG Escape Sequences

extension [UInt8] {
    /// SVG-specific escape sequences for attribute values.
    public enum svg {
        /// The escaped representation of a double quotation mark (`"`).
        public static let doubleQuotationMark: [UInt8] = [
            ASCII.Character.Graphic.ampersand, ASCII.Character.Graphic.q, ASCII.Character.Graphic.u,
            ASCII.Character.Graphic.o, ASCII.Character.Graphic.t, ASCII.Character.Graphic.semicolon,
        ]

        /// The escaped representation of an apostrophe (`'`).
        public static let apostrophe: [UInt8] = [
            ASCII.Character.Graphic.ampersand, ASCII.Character.Graphic.a, ASCII.Character.Graphic.p,
            ASCII.Character.Graphic.o, ASCII.Character.Graphic.s, ASCII.Character.Graphic.semicolon,
        ]

        /// The escaped representation of an ampersand (`&`).
        public static let ampersand: [UInt8] = [
            ASCII.Character.Graphic.ampersand, ASCII.Character.Graphic.a, ASCII.Character.Graphic.m,
            ASCII.Character.Graphic.p, ASCII.Character.Graphic.semicolon,
        ]

        /// The escaped representation of a less-than sign (`<`).
        public static let lessThan: [UInt8] = [
            ASCII.Character.Graphic.ampersand, ASCII.Character.Graphic.l, ASCII.Character.Graphic.t,
            ASCII.Character.Graphic.semicolon,
        ]

        /// The escaped representation of a greater-than sign (`>`).
        public static let greaterThan: [UInt8] = [
            ASCII.Character.Graphic.ampersand, ASCII.Character.Graphic.g, ASCII.Character.Graphic.t,
            ASCII.Character.Graphic.semicolon,
        ]
    }
}
