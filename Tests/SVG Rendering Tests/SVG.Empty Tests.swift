//
//  SVG.Empty Tests.swift
//  swift-svg-rendering
//

import SVG_Rendering_Test_Support
import Testing

extension SVG.Empty {
    @Suite struct Test {
        @Suite struct Unit {

            @Test
            func `renders to empty bytes`() {
                let empty = SVG.Empty()
                let bytes = [UInt8](empty)
                #expect(bytes.isEmpty)
            }

            @Test
            func `String representation is empty`() {
                let empty = SVG.Empty()
                let string = String(decoding: [UInt8](empty), as: UTF8.self)
                #expect(string.isEmpty)
            }
        }

        @Suite struct EdgeCase {

            @Test
            func `multiple empties compose to empty`() {
                let group = SVG.Group {
                    SVG.Empty()
                    SVG.Empty()
                    SVG.Empty()
                }
                let bytes = [UInt8](group)
                #expect(bytes.isEmpty)
            }
        }
    }
}
