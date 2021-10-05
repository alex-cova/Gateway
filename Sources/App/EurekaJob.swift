//
//  File.swift
//  
//
//  Created by alex on 05/10/21.
//


import Foundation
import Vapor
import Queues

struct Eureka : Codable{
    let test : String
}

struct EurekaJob : Job {
    
    func dequeue(_ context: QueueContext, _ payload: Eureka) -> EventLoopFuture<Void> {
        
    }
    
    typealias Payload = Eureka
    
    
    
    
}
