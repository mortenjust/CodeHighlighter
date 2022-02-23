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
    
    @Environment(\.colorScheme) var colorScheme
    
    public init(_ code : String,
                language: String = "swift",
                lightTheme: HighlighterTheme = .atomOneLight,
                darkTheme: HighlighterTheme = .atomOneDark) {
        
        self.code = code
        self.language = language
        self.lightTheme = lightTheme
        self.darkTheme = darkTheme
    }


    var highlighter = Highlightr()

    var coded : AttributedString {
        highlighter?.setTheme(to: colorScheme == .dark ? darkTheme.rawValue : lightTheme.rawValue)
        
        guard let nsatt = highlighter?.highlight(code, as: language)
        else { return "" }
        var att = AttributedString(nsatt)
        att.font = .custom("FiraCodeRoman-Regular", size: 16) // FiraCodeRoman-Regular, CascadiaMonoPL-Italic, CascadiaMonoPLRoman-ExtraLight, CascadiaMonoPLRoman-SemiLight
        att.inlinePresentationIntent = .code
        return att
    }
    
    public var body: some View {
        VStack {
            Text(coded)
                .textSelection(.enabled)
        }
        
    }
}
