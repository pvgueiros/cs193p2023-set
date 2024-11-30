//
//  Leaderboard.swift
//  Set
//
//  Created by Paula Vasconcelos Gueiros on 29/11/24.
//

import Foundation

struct UserScore: Identifiable, Codable {
    var id = UUID()
    let name: String
    let score: Int
}

class LeaderboardManager {
    
    private var leaderboard: [UserScore] = []
    var highScore: Int? { leaderboard.first?.score }
    
    private let leaderboardKey = "leaderboardKey"
    
    init() {
        loadEntries()
    }
    
    private func loadEntries() {
        if let savedData = UserDefaults.standard.data(forKey: leaderboardKey),
           let decoded = try? JSONDecoder().decode([UserScore].self, from: savedData) {
            
            leaderboard = decoded
        }
    }
    
    func addEntry(score: Int, name: String) {
        let newScore = UserScore(name: name, score: score)
        leaderboard.append(newScore)
        leaderboard.sort { $0.score > $1.score }
        
        saveFirstTenEntries()
    }
    
    private func saveFirstTenEntries() {
        let firstTenEntries = Array(leaderboard.prefix(10))
        
        if let encoded = try? JSONEncoder().encode(firstTenEntries) {
            UserDefaults.standard.set(encoded, forKey: leaderboardKey)
        }
    }
}
