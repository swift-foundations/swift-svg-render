# ``SVG_Rendering``

@Metadata {
    @DisplayName("SVG Rendering")
    @TitleHeading("Swift Foundations")
}

The `SVG.View` builder and renderer: a `@SVG.Builder` result-builder DSL for
composing SVG element trees in Swift, with `_render(_:into:context:)` writing
the tree directly into a UTF-8 byte buffer rather than through an
intermediate string representation.

## When to use this

Reach for this package when a `swift-svg-standard` element tree needs to be
rendered to actual SVG markup — it is the rendering layer other SVG packages
build on, comparable in role to `swift-html-render` for HTML. Depend on
`swift-svg-standard` alone when only the typed element vocabulary is needed
without rendering; reach for the sibling `swift-svg` package for the
lowercase, SVG-like convenience syntax (`circle(...)`, `rect(...)`) built on
top of this renderer.

## Topics

### Related packages

- [swift-svg-standard](https://github.com/swift-standards/swift-svg-standard) —
  the typed SVG element vocabulary this package renders.
- [swift-svg](https://github.com/swift-foundations/swift-svg) — the
  lowercase element-syntax layer built on this renderer.
- [swift-render-primitives](https://github.com/swift-primitives/swift-render-primitives) —
  the shared rendering-context primitives this package composes.
