// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let eurekaDto = try? newJSONDecoder().decode(EurekaDto.self, from: jsonData)

import Foundation

// MARK: - EurekaDto
struct EurekaDto: Codable {
    let applications: Applications
}

// MARK: - Applications
 struct Applications: Codable {
    let versionsDelta, appsHashcode: String
    let application: [ApplicationDto]

    enum CodingKeys: String, CodingKey {
        case versionsDelta = "versions__delta"
        case appsHashcode = "apps__hashcode"
        case application = "application"
    }
}

// MARK: - Application
struct ApplicationDto: Codable {
    let name: String
    let instance: [Instance]
}

// MARK: - Instance
struct Instance: Codable {
    let instanceID, hostName, app, ipAddr: String
    let status, overriddenStatus: String
    let port, securePort: Port
    let countryID: Int
    let dataCenterInfo: DataCenterInfo
    let leaseInfo: LeaseInfo
    let metadata: Metadata
    let homePageURL, statusPageURL, healthCheckURL: String
    let vipAddress, secureVipAddress, isCoordinatingDiscoveryServer, lastUpdatedTimestamp: String
    let lastDirtyTimestamp, actionType: String

    enum CodingKeys: String, CodingKey {
        case instanceID = "instanceId"
        case hostName, app, ipAddr, status, overriddenStatus, port, securePort
        case countryID = "countryId"
        case dataCenterInfo, leaseInfo, metadata
        case homePageURL = "homePageUrl"
        case statusPageURL = "statusPageUrl"
        case healthCheckURL = "healthCheckUrl"
        case vipAddress, secureVipAddress, isCoordinatingDiscoveryServer, lastUpdatedTimestamp, lastDirtyTimestamp, actionType
    }
}

// MARK: - DataCenterInfo
struct DataCenterInfo: Codable {
    let dataCenterInfoClass, name: String

    enum CodingKeys: String, CodingKey {
        case dataCenterInfoClass = "@class"
        case name
    }
}

// MARK: - LeaseInfo
struct LeaseInfo: Codable {
    let renewalIntervalInSecs, durationInSecs, registrationTimestamp, lastRenewalTimestamp: Int
    let evictionTimestamp, serviceUpTimestamp: Int
}

// MARK: - Metadata
struct Metadata: Codable {
    let managementPort: String

    enum CodingKeys: String, CodingKey {
        case managementPort = "management.port"
    }
}

// MARK: - Port
struct Port: Codable {
    let empty: Int
    let enabled: String

    enum CodingKeys: String, CodingKey {
        case empty = "$"
        case enabled = "@enabled"
    }
}

