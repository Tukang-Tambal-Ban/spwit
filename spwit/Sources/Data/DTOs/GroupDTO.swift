//
//  GetGroupsResponse.swift
//  Spwit
//
//  Created by Adithya Firmansyah Putra on 04/08/25.
//

// CREATE GROUP
struct CreateGroupRequest: Codable {
    let name: String
    let memberIds: [String]

    enum CodingKeys: String, CodingKey {
        case name
        case memberIds = "member_ids"
    }
}


struct CreateGroupResponse: Codable {
    let groupId: String

    enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
    }
}

// GET GROUPS
struct GroupsResponse: Codable {
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

// GET GROUP DETAIL
struct GroupDetailResponse: Codable {
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

extension GroupDetailEntity {
    static func fromDTO(_ dto: GroupDetailResponse) -> GroupDetailEntity {
        GroupDetailEntity(
            groupId: dto.groupId,
            groupName: dto.groupName,
            summary: Summary(
                youOwe: dto.summary.youOwe.map {
                    Summary.UserAmount(
                        userId: $0.userId,
                        name: $0.name,
                        username: $0.username,
                        appleId: $0.appleId,
                        amount: $0.amount
                    )
                },
                youAreOwed: dto.summary.youAreOwed.map {
                    Summary.UserAmount(
                        userId: $0.userId,
                        name: $0.name,
                        username: $0.username,
                        appleId: $0.appleId,
                        amount: $0.amount
                    )
                }
            ),
            members: dto.members.map {
                User(
                    userId: $0.userId,
                    name: $0.name,
                    username: $0.username,
                    appleId: $0.appleId
                )
            },
            timeline: dto.timeline.map { item in
                TimelineItem(
                    type: item.type,
                    expenseId: item.expenseId,
                    settlementId: item.settlementId,
                    title: item.title,
                    date: item.date,
                    totalAmount: item.totalAmount,
                    typeOfSplit: item.typeOfSplit,
                    paidBy: item.paidBy.map {
                        TimelineItem.PaidBy(
                            userId: $0.userId,
                            name: $0.name,
                            amountPaid: $0.amountPaid
                        )
                    },
                    createdBy: item.createdBy.map {
                        TimelineItem.CreatedBy(
                            userId: $0.userId,
                            name: $0.name
                        )
                    },
                    youPaid: item.youPaid,
                    youLent: item.youLent,
                    youBorrowed: item.youBorrowed,
                    fromUser: item.fromUser.map {
                        TimelineItem.UserSummary(
                            userId: $0.userId,
                            name: $0.name
                        )
                    },
                    toUser: item.toUser.map {
                        TimelineItem.UserSummary(
                            userId: $0.userId,
                            name: $0.name
                        )
                    },
                    amount: item.amount,
                    note: item.note,
                    displayText: item.displayText
                )
            }
        )
    }
}
