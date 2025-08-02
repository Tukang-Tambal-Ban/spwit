//
//  MemberEntity.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/1/25.
//

struct MemberEntity {
    
    let name : String
    var initials : String {
        let words = name.split(separator: " ")
        let result = words.prefix(2).compactMap{$0.first}.map{String($0)}
        return result.joined().uppercased()
        
    }
}
