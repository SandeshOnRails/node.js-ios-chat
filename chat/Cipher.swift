//
//  Cipher.swift
//  chat
//
//  Created by Sandesh Basnet on 9/26/18.
//  Copyright © 2018 Sandesh Basnet. All rights reserved.
//

import Foundation

protocol Cipher {
    
    func encode(_ plaintext: String) -> String
    
    
}

struct ROT13: Cipher {
    
    
    func encode (_ plaintext: String) -> String {
        
            var secret = "13"
            var shiftBy = Int32(13)
            let newText = plaintext.uppercased()
            var encoded = ""
            for character in newText {
                let unicode = character.unicodeScalars.first!.value
                var shiftedUnicode = Int32(unicode) + shiftBy
                if (shiftedUnicode < 65) {
                    let toActuallyShift = 64 - shiftedUnicode
                    shiftedUnicode = 90 - toActuallyShift
                    let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    encoded = encoded + shiftedCharacter
                    continue
                }
                else if (shiftedUnicode > 90) {
                    let toActuallyShift = shiftedUnicode - 90
                    shiftedUnicode = 64 + toActuallyShift
                    let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    encoded = encoded + shiftedCharacter
                    continue
                }
                else {
                    let shiftedUnicode = Int32(unicode) + shiftBy
                    let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                    encoded = encoded + shiftedCharacter
                    print ("ShiftedUnicode neutral: \(shiftedUnicode)")
                }
            }
            return encoded
        }
    
}
