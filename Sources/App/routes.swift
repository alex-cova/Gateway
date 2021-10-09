import Vapor

var map : [String:[String]] = [:]

func routes(_ app: Application) throws {
   
    app.get("**") { req -> EventLoopFuture<ClientResponse> in
         
        let path : String = "http://localhost:8080\(req.url.path)"
        let url = URI.init(string: path)
        
        return req.client.get(url, headers: req.headers)
    
    }
    
    app.post("**") { req -> EventLoopFuture<ClientResponse> in
        
        let path : String = "http://localhost:8080\(req.url.path)"
        let url = URI.init(string: path)
        
        return req.client.post(url, headers: req.headers) { cli in
            cli.body = req.body.data
        }
    }
    
    app.put("**"){ req -> EventLoopFuture<ClientResponse> in
        let path : String = "http://localhost:8080\(req.url.path)"
        let url = URI.init(string: path)
        
        return req.client.put(url, headers: req.headers) { cli in
            cli.body = req.body.data
        }
    }
    
    app.delete("**"){ req -> EventLoopFuture<ClientResponse> in
        let path : String = "http://localhost:8080\(req.url.path)"
        let url = URI.init(string: path)
        
        return req.client.delete(url, headers: req.headers)
    }
    
    app.patch("**"){ req -> EventLoopFuture<ClientResponse> in
        let path : String = "http://localhost:8080\(req.url.path)"
        let url = URI.init(string: path)
        
        return req.client.patch(url, headers: req.headers)
    }
    
  
}



