//
//  JSONConverter.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class JSONConverter {
    
    func json(from text: String) -> String? {
        
        // extract the payload
        guard var payload = self.payload(from: text) else { return nil }
        
        // remove whitespace (but keep newlines)
        payload = payload.components(separatedBy: .whitespaces).joined()
        
        // convert array bounding brackets from () to []
        payload = payload.replacingOccurrences(of: "=(", with: "=[")
        payload = payload.replacingOccurrences(of: ");", with: "];")
        
        // convert semicolumn (;) terminators to comma (,)
        payload = payload.replacingOccurrences(of: ";\n", with: ",\n")
        
        // concert to JSON (one line at a time)
        var json = payload.components(separatedBy: .newlines).map { self.jsonFromLine($0) }.joined()
        
        // drop trailing comma (,) right after the opening braket for a JSON object or JSON array
        json = json.replacingOccurrences(of: "{,", with: "{")
        json = json.replacingOccurrences(of: "[,", with: "[")
        
        // drop trailing comma (,) right before the closing braket for a JSON object or JSON array
        json = json.replacingOccurrences(of: ",}", with: "}")
        json = json.replacingOccurrences(of: ",]", with: "]")
                
        #if DEBUG
            print(json)
        #endif
        
        // done!
        return json
    }
    
    private func payload(from content: String) -> String? {
        if let payloadMarkerRange = content.range(of: "^Datasource:", options: .regularExpression) {
            return content.replacingCharacters(in: payloadMarkerRange, with: "").trimmingCharacters(in: .whitespacesAndNewlines)
        } else {
            return nil
        }
    }
    
    private func jsonFromLine(_ line: String) -> String {
        let tokens = line.components(separatedBy: CharacterSet(charactersIn:"="))
        
        switch tokens.count {
        case 1:
            return self.jsonFromToken(tokens.first!)
            
        case 2...:
            let keyToken = tokens.first!.trimmingCharacters(in: CharacterSet(charactersIn:","))
            let valueToken = tokens[1...].joined().trimmingCharacters(in: CharacterSet(charactersIn:","))
            return self.jsonFromToken(keyToken) + ":" + self.jsonFromToken(valueToken) + ","
            
        default:
            return line
        }
    }
    
    private func jsonFromToken(_ token: String) -> String {
        switch token {
        case "{", "}", "},", "[", "]", "],":
            // leave tokens consting of single brackets as they are
            return token
            
        default:
            // ensure the token is surrounded by quotes
            let jsonToken = self.tokenByReplacingUnicodeScalars(inToken: token)
            return "\"" + jsonToken.trimmingCharacters(in: CharacterSet(charactersIn:"\"“”"))  + "\""
        }
    }
    
    private func tokenByReplacingUnicodeScalars(inToken token: String) -> String {
        var convertedToken = token
        var unicodeScalarRange: Range<String.Index>? = nil
        
        repeat {
            unicodeScalarRange = convertedToken.range(of: "\\\\U[0-9a-fA-F]{4}", options: .regularExpression)
            if let unicodeScalarRange = unicodeScalarRange {
                let scalarCodeAsHexString = String(convertedToken[unicodeScalarRange].suffix(4))
                let scalarCodeAsDecimalNumber = Int(scalarCodeAsHexString, radix: 16)
                if let scalarCodeAsDecimalNumber = scalarCodeAsDecimalNumber, let unicodeScalar = UnicodeScalar(scalarCodeAsDecimalNumber)  {
                    convertedToken = convertedToken.replacingCharacters(in: unicodeScalarRange, with: String(unicodeScalar))
                } else {
                    break
                }
            }
        } while unicodeScalarRange != nil
        
        return convertedToken
    }
}
