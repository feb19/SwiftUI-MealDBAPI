//
//  MealGenerator.swift
//  SwiftUI-MealDBAPI
//
//  Created by Nobuhiro Takahashi on 2022/05/08.
//

import Foundation
import Combine

final class MealGenerator: ObservableObject {
    @Published var currentMeal: Meal?
    @Published var currentImageURLString: String?
    private var cancellable: AnyCancellable?
    
    func fetchRandomMeal() {
        let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php")!
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: MealData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { _ in
            } receiveValue: { data in
                self.currentMeal = data.meals.first
                self.currentImageURLString = data.meals.first?.imageUrlString
            }
    }
}
