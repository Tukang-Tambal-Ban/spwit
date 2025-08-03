//
//  GroupEntity.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//
struct CreateGroupRequestEntity: Codable {
    let name: String
    let memberIds: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case memberIds = "member_ids"
    }
}


struct CreateGroupEntity: Codable {
    let groupId: String

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
    }
}

extension CreateGroupEntity {
    static func fromDTO(_ dto: CreateGroupResponse) -> CreateGroupEntity {
        CreateGroupEntity(
            groupId: dto.groupId
        )
    }
}

// GET GROUPS
struct GroupsEntity: Codable {
    let overallSummary: Summary
    let groups: [GroupItem]
    
    struct Summary: Codable {
        let youOwe: Int
        let youAreOwed: Int

        enum CodingKeys: String, CodingKey {
            case youOwe = "you_owe"
            case youAreOwed = "you_are_owed"
        }
    }

    struct GroupItem: Codable {
        let groupId: String
        let groupName: String
        let members: [User]
        let status: String
        let amount: Int

        enum CodingKeys: String, CodingKey {
            case groupId = "group_id"
            case groupName = "group_name"
            case members, status, amount
        }
    }

    struct User: Codable {
        let userId: String
        let name: String
        let username: String
        let appleId: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case name, username
            case appleId = "apple_id"
        }
    }

    enum CodingKeys: String, CodingKey {
        case overallSummary = "overall_summary"
        case groups
    }
}

extension GroupsEntity {
    static func fromDTO(_ dto: GroupsResponse) -> GroupsEntity {
        GroupsEntity(
            overallSummary: Summary(
                youOwe: dto.overallSummary.youOwe,
                youAreOwed: dto.overallSummary.youAreOwed
            ),
            groups: dto.groups.map { item in
                GroupItem(
                    groupId: item.groupId,
                    groupName: item.groupName,
                    members: item.members.map { member in
                        User(
                            userId: member.userId,
                            name: member.name,
                            username: member.username,
                            appleId: member.appleId
                        )
                    },
                    status: item.status,
                    amount: item.amount
                )
            }
        )
    }
}

// GET GROUP DETAIL
struct GroupDetailEntity: Codable {
    let groupId: String
    let groupName: String
    let summary: Summary
    let members: [User]
    let timeline: [TimelineItem]

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case groupName = "group_name"
        case summary, members, timeline
    }

    struct Summary: Codable {
        let youOwe: [UserAmount]
        let youAreOwed: [UserAmount]

        enum CodingKeys: String, CodingKey {
            case youOwe = "you_owe"
            case youAreOwed = "you_are_owed"
        }

        struct UserAmount: Codable {
            let userId: String
            let name: String
            let username: String
            let appleId: String
            let amount: Int

            enum CodingKeys: String, CodingKey {
                case userId = "user_id"
                case name, username
                case appleId = "apple_id"
                case amount
            }
        }
    }

    struct User: Codable {
        let userId: String
        let name: String
        let username: String
        let appleId: String

        enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case name, username
            case appleId = "apple_id"
        }
    }

    struct TimelineItem: Codable {
        let type: String
        let expenseId: String?
        let settlementId: String?
        let title: String?
        let date: String?
        let totalAmount: Int?
        let typeOfSplit: String?
        let paidBy: PaidBy?
        let createdBy: CreatedBy?
        let youPaid: Int?
        let youLent: Int?
        let youBorrowed: Int?
        let fromUser: UserSummary?
        let toUser: UserSummary?
        let amount: Int?
        let note: String?
        let displayText: String?

        struct PaidBy: Codable {
            let userId: String
            let name: String
            let amountPaid: Int

            enum CodingKeys: String, CodingKey {
                case userId = "user_id"
                case name
                case amountPaid = "amount_paid"
            }
        }

        struct CreatedBy: Codable {
            let userId: String
            let name: String

            enum CodingKeys: String, CodingKey {
                case userId = "user_id"
                case name
            }
        }

        struct UserSummary: Codable {
            let userId: String
            let name: String

            enum CodingKeys: String, CodingKey {
                case userId = "user_id"
                case name
            }
        }
    }
}
