//
//  SVG.Group Tests.swift
//  swift-svg-rendering
//

import SVG_Rendering_Test_Support
import Testing

// SVG.Group is generic — use parallel namespace [TEST-004]
enum SVGGroupTests {

    static func render(_ view: some SVG.View) -> String {
        String(decoding: [UInt8](view), as: UTF8.self)
    }

    @Suite struct Test {
        @Suite struct Unit {

            @Test
            func `composes children sequentially`() {
                let string = render(SVG.Group {
                    SVG.Text("Hello")
                    SVG.Text(" ")
                    SVG.Text("World")
                })
                #expect(string == "Hello World")
            }

            @Test
            func `single child passes through`() {
                let string = render(SVG.Group {
                    SVG.Text("Only")
                })
                #expect(string == "Only")
            }
        }

        @Suite struct EdgeCase {

            @Test
            func `empty group renders nothing`() {
                let string = render(SVG.Group {
                    SVG.Empty()
                })
                #expect(string.isEmpty)
            }
        }
    }
}
