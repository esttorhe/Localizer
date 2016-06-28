//
//  SourceEditorCommand.swift
//  Localizer
//
//  Created by Esteban Torres on 27/6/16.
//  Copyright © 2016 Esteban Torres. All rights reserved.
//

import Foundation
import XcodeKit

class LocalizerSourceEditorCommand: NSObject, XCSourceEditorCommand {
  
  func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: (NSError?) -> Void ) -> Void {
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    guard let selection = invocation.buffer.selections.firstObject as? XCSourceTextRange else {
      completionHandler(NSError(domain: "es.estebantorr.CocoaHeadsCR.Localizer",
                                code: -1,
                                userInfo: [
                                  NSLocalizedDescriptionKey: NSLocalizedString("«Localize Selection» requires you to select some text to work.", comment: "«Localize Selection» requires you to select some text to work.")
        ]))
      return
    }
    
    // Iterate through all the selected lines
    for index in selection.start.line ... selection.end.line {
      // Convert to `NSString` to easily manipulate the selection
      guard let line = invocation.buffer.lines[index] as? NSString else {
        continue
      }
      
      // Break components by `"`. Was unabled to use RegularExpressions 🙈😳
      let components = line.components(separatedBy: "\"")
      // FIXME: Horrible hack, we broke using `"` so we have to have groups of 3 (e.g. let test = "hello there" => [let test , hello there, \n])
      // This way we know the user selectd between ""
      if (components.count % 3) == 0 {
        // Let's grab the `String` part.
        let text = components[1]
        // And wrap it around `NSLocalizedString()`
        let newText = "NSLocalizedString(\"\(text)\", comment: \"\(text)\")"
        // Then replace the instance of the text (including the quotation marks) with the new text at the current line.
        invocation.buffer.lines.replaceObject(at: index, with: (line as String).replacingOccurrences(of: "\"\(text)\"", with: newText))
      }
    }
    
    completionHandler(nil)
  }
  
}
