import Fluent
import Vapor

final class Post: Model {
    static let schema = "posts"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "description")
    var description: String
    
    @Field(key: "file_name")
    var fileName: String

    init() { }

    init(id: UUID? = nil, description: String, fileName: String) {
        self.id = id
        self.description = description
        self.fileName = fileName
    }
}

struct PostContent: Content {
    var description: String
    var image: File
    
    mutating func afterDecode() throws {
        // check if file uploaded is in fact an image
        guard image.isImage else {
            throw Abort(.badRequest)
        }
    }
}

struct PostResponse: Content {
    var id: UUID
    var description: String
    var imageLink: URL
}

    
extension File {
    var isImage: Bool {
        [
            "png",
            "jpeg",
            "jpg",
            "gif"
        ].contains(self.extension?.lowercased())
    }
}
