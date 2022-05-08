//
//  ContentView.swift
//  SwiftUI-MealDBAPI
//
//  Created by Nobuhiro Takahashi on 2022/05/08.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var mealGenerator = MealGenerator()
    var actionButton: some View {
        Button("Get Random Meal") {
            mealGenerator.fetchRandomMeal()
        }
        .onAppear {
            mealGenerator.fetchRandomMeal()
        }
    }
    var body: some View {
        ScrollView {
            VStack {
                if let name = mealGenerator.currentMeal?.name {
                    Text(name)
                        .font(.largeTitle)
                }
                AsyncImageView(urlString: $mealGenerator.currentImageURLString)
                if let ingredents = mealGenerator.currentMeal?.ingredients {
                    HStack {
                        Text("Ingredients")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    ForEach(ingredents, id: \.self) { ingredent in
                        HStack {
                            Text(ingredent.name + " - " + ingredent.measure)
                            Spacer()
                        }
                    }
                }

                if let instructions = mealGenerator.currentMeal?.instructions {
                    HStack {
                        Text("Instructions")
                            .font(.title2)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    Text(instructions)

                }
            }
            .padding()
        }
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                actionButton
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
