//
// Created by Александр Масленников on 28.08.17.
// Copyright (c) 2017 Heads and Hands. All rights reserved.
//

import ObjectMapper

class ServerResponse: ImmutableMappable {

    var code: Int
    var message: String

    private let codeKey = "code"
    private let messageKey = "message"

    required init(map: Map) throws {
        code = try map.value(codeKey)
        message = try map.value(messageKey)
    }

    func mapping(map: Map) {
        code >>> map[codeKey]
        message >>> map[messageKey]
    }
}

class ErrorField: ImmutableMappable {

    var field: String
    var message: String

    private let fieldKey = "field"
    private let messageKey = "message"

    required init(map: Map) throws {
        field = try map.value(fieldKey)
        message = try map.value(messageKey)
    }

    func mapping(map: Map) {
        field >>> map[fieldKey]
        message >>> map[messageKey]
    }
}

class ErrorResponse: ServerResponse {

    var fields: [ErrorField]

    private let fieldsKey = "data"

    required init(map: Map) throws {
        fields = try map.value(fieldsKey)

        try super.init(map: map)
    }

    override func mapping(map: Map) {
        fields >>> map[fieldsKey]

        super.mapping(map: map)
    }
}
