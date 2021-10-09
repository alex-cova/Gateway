import Vapor
import Queues

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    // register routes
    
    app.queues.schedule(EurekaJob())
        .everySecond()
        
    app.http.server.configuration.port = 8081
    
    try routes(app)
}
