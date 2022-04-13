//
//  CodeView.swift
//  Auto Code
//
//  Created by Morten Just on 2/11/22.
//

import SwiftUI
import Highlightr


// Themes
// https://highlightjs.org/static/demo/
// https://github.com/raspu/Highlightr


public struct CodeTextView: View {
    
    var code : String = ""
    var language : String = ""
    let showCaret : Bool
    let fontSize : Double
    var caretImage : Image = Image(systemName: "rectangle.portrait.fill")
    var caretColor : Color = .blue
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(_ code : String,
                language: String = "swift",
                lightTheme: HighlighterTheme = .atomOneLight,
                darkTheme: HighlighterTheme = .atomOneDark,
                showCaret : Bool = false,
                fontSize: Double = 16) {
        
        self.code = code
        self.language = language
        self.showCaret = showCaret
        self.fontSize = fontSize
    }


    var highlighter = Highlightr()

    var coded : AttributedString {
        
        code.syntaxHighlight(colorScheme: colorScheme, language: language, fontSize: fontSize)
    }
    
    var finalText : Text {
        var elements = [ Text ]()
        if showCaret {
            elements.append(Text(caretImage)
                .foregroundColor(.blue))
        }
        return elements.reduce(Text(coded)) { $0 + $1 }
    }
    
    public var body: some View {
        VStack {
            finalText
                .lineSpacing(4)

        }
        
    }
}

struct CodeText_Previews : PreviewProvider {
    static var previews: some View {
        CodeTextView("let a = 2")
    }
}

extension String {
    
    public func syntaxHighlightAsNSAttributedString(colorScheme: ColorScheme, language: String, fontSize: Double) -> NSAttributedString? {
        let highlighter = Highlightr()!
        
        highlighter.setTheme(to: colorScheme == .dark
                             ? HighlighterTheme.darcula.rawValue
                             : HighlighterTheme.atomOneLight.rawValue)
        
        var lang = language.lowercased()
        if !highlighter.supportedLanguages().contains(language) {
                print("CHL: Falling back to javascript")
            lang = "javascript"
        }
        guard let nsAtt = highlighter.highlight(self, as: lang) else { return nil }
        return nsAtt
    }
    
    /// Returns a modern AttributedString syntax highlighted
    public func syntaxHighlight(colorScheme: ColorScheme, language: String, fontSize: Double) -> AttributedString {
        guard let nsAtt = syntaxHighlightAsNSAttributedString(colorScheme: colorScheme, language: language, fontSize: fontSize) else { return "" }
        var att = AttributedString(nsAtt)
        att.font = .custom("FiraCodeRoman-Regular", size: fontSize)
        att.inlinePresentationIntent = .code
        return att
    }
    
    public func syntaxHighlightTokens(colorScheme: ColorScheme, language: String, fontSize: Double) -> [AttributedString] {
        guard let nsAtt = syntaxHighlightAsNSAttributedString(colorScheme: colorScheme, language: language, fontSize: fontSize) else { return [] }
        let tokens = nsAtt.split(by: " ")
        return tokens.map { AttributedString($0) }
    }
    
    public func syntaxHighlightLines(colorScheme: ColorScheme, language: String, fontSize: Double) -> [NSAttributedString] {
        guard let nsAtt = syntaxHighlightAsNSAttributedString(colorScheme: colorScheme, language: language, fontSize: fontSize) else { return [] }
        let lines = nsAtt.split(by: "\n")
        return lines
    }
    
}


extension NSAttributedString {
    public func split(by: String) -> [NSAttributedString] {
        let input = self.string
        let separatedInput = input.components(separatedBy: by)
        var output = [NSAttributedString]()
        var start = 0
        for sub in separatedInput {
            let range = NSMakeRange(start, sub.utf16.count)
            let attribStr = self.attributedSubstring(from: range)
            output.append(attribStr)
            start += range.length + by.count
        }
        return output
    }
}
