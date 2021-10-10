//
//  File.swift
//  
//
//  Created by alex on 05/10/21.
//


import Foundation
import Vapor
import Queues


struct EurekaJob : ScheduledJob {
    
    func run(context: QueueContext) -> EventLoopFuture<Void> {
        
        let eureka = Environment.get("eureka") ?? "localhost:8761"
        
        
            
            print("updating...")
        
            var headers = HTTPHeaders()
        headers.contentType = .json
        headers.basicAuthorization = .init(username: "sQ9aSwUtM6RQFFRh", password: "NdKYx6fI+FFApmkKK3d8jGV0G49nYbHn")
        
            
            let request = context.application.client
                .get("http://\(eureka)/eureka/apps", headers: headers)
            
            
            
            request.whenSuccess{ response in
                
                print("response: \(response.status)")
                
                        if(response.status == .ok){
                            
                            map.removeAll()
                            
                            if let body = response.body{
                                
                                do {
                                let applications = try JSONDecoder().decode(Applications.self, from: body)
                                    
                                    for  app in applications.application {
                                        
                                        var ip : [String] = []
                                        
                                        for ins in app.instance {
                                            let route = "\(ins.ipAddr):\(ins.port)"
                                            print("adding: \(route)")
                                            ip.append(route)
                                        }
                                        
                                        map[app.name] = ip
                                    }
                                    
                                }catch {
                                    print(error)
                                }
                            }
                        }
                    
            }
            
            
    
        
        return request
            .transform(to: context.eventLoop.makeSucceededVoidFuture())
    }
    
}
    
    
    
    
    

