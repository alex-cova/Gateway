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
        
        do{
            
            print("updating...")
            var headers = HTTPHeaders()
            headers.contentType = .json
            
            let request = context.application.client
                .get("http://\(eureka)/eureka/apps", headers: headers)
            
            do {
            
            let response = try request.wait()
            
        
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
                }else{
                    print("response: \(response.status)")
                }
            
        }catch{
            print(error)
        }
        
        return context.eventLoop.makeSucceededFuture(())
    }
    }
}
    
    
    
    
    

