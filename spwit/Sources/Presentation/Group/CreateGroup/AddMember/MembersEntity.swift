//
//  MemberEntity.swift
//  Spwit
//
//  Created by Shafa Tiara Tsabita Himawan on 04/08/25.
//

struct MembersEntity {
    let name : String
    var initials : String {
        let words = name.split(separator: " ")
        let result = words.prefix(2).compactMap{$0.first}.map{String($0)}
        return result.joined().uppercased()
        
    }
}
