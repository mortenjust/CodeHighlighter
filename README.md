# CodeHighlighter

A SwiftUI view that automatically highlights code syntax using [Highlightr](https://github.com/raspu/Highlightr), which is using [highlight.js](https://highlightjs.org/) as it core, and supports [185 languages and comes with 89 styles](https://highlightjs.org/static/demo/). 

Highlightr renders your syntax colored code as a string, no web views involved. This means your SwiftUI layout behaves like you'd expect it to, automatically reporting its frame, and no embedded scroll views. 

Since we're using `AttributedString`, this package requires macOS 12 or iOS 15.

This package adds

* SwiftUI view for syntax coloring
* Safe selection of themes via enum
* Dark mode detection


## Usage
```swift
CodeTextView("let a = b(\"Here we are\");")

```

## Contributions welcome
* A `CodeTextEditor`, a text editor that lets you edit text with realtime highlighting. Highlightr offers [CodeAttributedString](https://github.com/raspu/Highlightr#codeattributedstring), which is a subclass of `NSTextStorage`, so this could be implemented with a hosted `UI/NSTextView`.    

## License
MIT
