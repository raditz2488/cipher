// The Swift Programming Language
// https://docs.swift.org/swift-book

import ArgumentParser
import Foundation
import RNCryptor

struct Cypher: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Encrypt and decrypt files",
        version: "0.0.1"
    )

    @Argument(help: "Password used for encrypting and decrypting") var password: String
    @Option(name: .shortAndLong, help: "Input file name") var inputFile: String
    @Option(name: .shortAndLong, help: "Output file name") var outputFile: String
    @Flag(name: .shortAndLong, help: "Decrypt the input file") var decrypt = false

    mutating func run() throws {
        var converted = ""
        guard let input = try? String(contentsOfFile: inputFile) else {
            throw RuntimeError("Couldn't read from file '\(inputFile)'")
        }
    
        if decrypt {
            guard let output = try? decryptContents(of: input) else {
                throw RuntimeError("Could'nt decrypt contents of '\(inputFile)'")
            }
            converted = output
        } else {
            let output = encryptContents(of: input)
            converted = output
        }

        guard let _ = try? converted.write(toFile: outputFile, atomically: true, encoding: .utf8) else {
            throw RuntimeError("Couldn't write to file '\(outputFile)'")
        }
    }

    func encryptContents(of content: String) -> String {
        let contentData = content.data(using: .utf8)!
        let encryptedData = RNCryptor.encrypt(data: contentData, withPassword: password)
        let encryptedString = encryptedData.base64EncodedString()
        return encryptedString
    }

    func decryptContents(of encryptedContent: String) throws -> String {
        let encryptedData = Data(base64Encoded: encryptedContent)!
        let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: password)
        let contentString = String(data: decryptedData, encoding: .utf8)!
        return contentString
    }
}

Cypher.main()

struct RuntimeError: Error, CustomStringConvertible {
    var description: String
    
    init(_ description: String) {
        self.description = description
    }
}
