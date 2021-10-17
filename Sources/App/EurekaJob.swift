//
//  File.swift
//  
//
//  Created by alex on 05/10/21.
//


import Foundation
import Vapor
import Queues


struct EurekaJob: ScheduledJob {

    func run(context: QueueContext) -> EventLoopFuture<Void> {

        let eureka = Environment.get("eureka") ?? "localhost:8761"

        print("updating...")

        var headers: HTTPHeaders?

        let eurekaUser = Environment.get("EUREKA_USER")
        let eurekaPass = Environment.get("EUREKA_PASS")

        if eurekaUser != nil && eurekaPass != nil {

            headers = HTTPHeaders()

            headers?.contentType = .json
            headers?.basicAuthorization = .init(username: eurekaUser!, password: eurekaPass!)
        }

        let url = "http://\(eureka)/eureka/apps"

        let request = headers != nil ?

                context.application.client
                        .get("\(url)", headers: headers!) :
                context.application.client.get("\(url)")


        request.whenSuccess { response in

            print("response: \(response.status)")

            if (response.status == .ok) {

                map.removeAll()

                if let body = response.body {

                    do {
                        let applications = try JSONDecoder().decode(Applications.self, from: body)

                        for app in applications.application {

                            var ip: [String] = []

                            for ins in app.instance {
                                let route = "\(ins.ipAddr):\(ins.port)"
                                print("adding: \(route)")
                                ip.append(route)
                            }

                            map[app.name] = ip
                        }

                    } catch {
                        print(error)
                    }
                }
            }

        }

        return request
                .transform(to: context.eventLoop.makeSucceededVoidFuture())
    }

}
    
    
    
    
    

