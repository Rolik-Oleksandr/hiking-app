import Foundation

/// .env files parser

class EnvParser {
    static let shared = EnvParser()
    private var values: [String: [String: String]] = [:] // fileName → values

        private init() {}

        func load(from fileName: String) -> [String: String] {
            if let cached = values[fileName] {
                return cached
            }

            guard let url = Bundle.main.url(forResource: fileName, withExtension: nil),
                  let content = try? String(contentsOf: url, encoding: .utf8) else {
                return [:]
            }

            var parsed: [String: String] = [:]
            let lines = content.components(separatedBy: .newlines)

            for line in lines {
                let parts = line.split(separator: "=", maxSplits: 1).map { String($0) }
                if parts.count == 2 {
                    parsed[parts[0].trimmingCharacters(in: .whitespaces)] =
                    parts[1].trimmingCharacters(in: .whitespaces)
                }
            }

            values[fileName] = parsed
            return parsed
        }
        //entry method
        func value(fileName: String, value: String) -> String? {
            let dict = load(from: fileName)
            return dict[value]
        }
}
