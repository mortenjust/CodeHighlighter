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

