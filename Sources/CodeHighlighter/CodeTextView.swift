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
    var lightTheme : HighlighterTheme = .atomOneLight
    var darkTheme : HighlighterTheme = .atomOneDark
    let showCaret : Bool
    let fontSize : Double 
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(_ code : String,
                language: String = "swift",
                lightTheme: HighlighterTheme = .atomOneLight,
                darkTheme: HighlighterTheme = .atomOneDark,
                showCaret : Bool = false,
                fontSize: Double = 16) {
        
        self.code = code
        self.language = language
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
        self.showCaret = showCaret
        self.fontSize = fontSize
    }


    var highlighter = Highlightr()

    var coded : AttributedString {
        highlighter?.setTheme(to: colorScheme == .dark ? darkTheme.rawValue : lightTheme.rawValue)
        
        var lang = language
        
        if !highlighter!.supportedLanguages().contains(language.lowercased()) {
            lang = "javascript"
        }
        
        
        guard let nsatt = highlighter?.highlight(code, as: lang)
        else { return "" }
        var att = AttributedString(nsatt)
        att.font = .custom("FiraCodeRoman-Regular", size: fontSize) // FiraCodeRoman-Regular, CascadiaMonoPL-Italic, CascadiaMonoPLRoman-ExtraLight, CascadiaMonoPLRoman-SemiLight
        att.inlinePresentationIntent = .code
        return att
    }
    
    public var body: some View {
        VStack {
            Text(coded) + (Text(showCaret ? "|█" : "").foregroundColor(.blue).font(.system(size: fontSize).bold()))
//                .textSelection(.enabled)
        }
        
    }
}

struct CodeText_Previews : PreviewProvider {
    static var previews: some View {
        CodeTextView("let a = 2")
    }
}
