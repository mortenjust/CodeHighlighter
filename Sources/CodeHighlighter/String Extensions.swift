//
//  File.swift
//  
//
//  Created by Morten Just on 4/15/22.
//

import Foundation
import SwiftUI
import Highlightr

public extension String {
    
    func syntaxHighlightAsNSAttributedString(colorScheme: ColorScheme, language: String, fontSize: Double) -> NSAttributedString? {
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
    func syntaxHighlight(colorScheme: ColorScheme, language: String, fontSize: Double) -> AttributedString {
        guard let nsAtt = syntaxHighlightAsNSAttributedString(colorScheme: colorScheme, language: language, fontSize: fontSize) else { return "" }
        var att = AttributedString(nsAtt)
        att.font = .custom("FiraCodeRoman-Regular", size: fontSize)
        att.inlinePresentationIntent = .code
        return att
    }
    
    func syntaxHighlightTokens(colorScheme: ColorScheme, language: String, fontSize: Double) -> [AttributedString] {
        guard let nsAtt = syntaxHighlightAsNSAttributedString(colorScheme: colorScheme, language: language, fontSize: fontSize) else { return [] }
        let tokens = nsAtt.split(by: " ")
        return tokens.map { AttributedString($0) }
    }
    
    func syntaxHighlightLines(colorScheme: ColorScheme, language: String, fontSize: Double) -> [NSAttributedString] {
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
