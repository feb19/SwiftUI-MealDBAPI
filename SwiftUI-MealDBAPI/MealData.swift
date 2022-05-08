//
//  MealData.swift
//  SwiftUI-MealDBAPI
//
//  Created by Nobuhiro Takahashi on 2022/05/08.
//

import Foundation

/**
 {
 "meals":[
 {
 "idMeal":"53032",
 "strMeal":"Tonkatsu pork",
 "strDrinkAlternate":null,
 "strCategory":"Pork",
 "strArea":"Japanese",
 "strInstructions":"STEP 1\r\nRemove the large piece of fat on the edge of each pork loin, then bash each of the loins between two pieces of baking parchment until around 1cm in thickness \u2013 you can do this using a meat tenderiser or a rolling pin. Once bashed, use your hands to reshape the meat to its original shape and thickness \u2013 this step will ensure the meat is as succulent as possible.\r\n\r\nSTEP 2\r\nPut the flour, eggs and panko breadcrumbs into three separate wide-rimmed bowls. Season the meat, then dip first in the flour, followed by the eggs, then the breadcrumbs.\r\n\r\nSTEP 3\r\nIn a large frying or saute\u0301 pan, add enough oil to come 2cm up the side of the pan. Heat the oil to 180C \u2013 if you don\u2019t have a thermometer, drop a bit of panko into the oil and if it sinks a little then starts to fry, the oil is ready. Add two pork chops and cook for 1 min 30 secs on each side, then remove and leave to rest on a wire rack for 5 mins. Repeat with the remaining pork chops.\r\n\r\nSTEP 4\r\nWhile the pork is resting, make the sauce by whisking the ingredients together, adding a splash of water if it\u2019s particularly thick. Slice the tonkatsu and serve drizzled with the sauce.",
 "strMealThumb":"https:\/\/www.themealdb.com\/images\/media\/meals\/lwsnkl1604181187.jpg",
 "strTags":null,
 "strYoutube":"https:\/\/www.youtube.com\/watch?v=aASr5x0d3Ys",
 "strIngredient1":"Pork Chops",
 "strIngredient2":"Flour",
 "strIngredient3":"Eggs",
 "strIngredient4":"Breadcrumbs",
 "strIngredient5":"Vegetable Oil",
 "strIngredient6":"Tomato Ketchup",
 "strIngredient7":"Worcestershire Sauce",
 "strIngredient8":"Oyster Sauce",
 "strIngredient9":"Caster Sugar",
 "strIngredient10":"",
 "strIngredient11":"",
 "strIngredient12":"",
 "strIngredient13":"",
 "strIngredient14":"",
 "strIngredient15":"",
 "strIngredient16":"",
 "strIngredient17":"",
 "strIngredient18":"",
 "strIngredient19":"",
 "strIngredient20":"",
 "strMeasure1":"4",
 "strMeasure2":"100g ",
 "strMeasure3":"2 Beaten ",
 "strMeasure4":"100g ",
 "strMeasure5":"Fry",
 "strMeasure6":"2 tbs",
 "strMeasure7":"2 tbs",
 "strMeasure8":"1 tbs",
 "strMeasure9":"2 tblsp ",
 "strMeasure10":" ",
 "strMeasure11":" ",
 "strMeasure12":" ",
 "strMeasure13":" ",
 "strMeasure14":" ",
 "strMeasure15":" ",
 "strMeasure16":" ",
 "strMeasure17":" ",
 "strMeasure18":" ",
 "strMeasure19":" ",
 "strMeasure20":" ",
 "strSource":"https:\/\/www.bbcgoodfood.com\/recipes\/tonkatsu-pork",
 "strImageSource":null,
 "strCreativeCommonsConfirmed":null,
 "dateModified":null
 }
 ]
 }
 */

struct MealData: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    let name: String
    let imageUrlString: String
    let ingredients: [Ingredient]
    let instructions: String
}

extension Meal {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)

        var index = 1
        var ingredients: [Ingredient] = []

        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
              let measure = mealDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
        self.ingredients = ingredients
        self.name = mealDictionary["strMeal"] as? String ?? ""
        self.imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        self.instructions = mealDictionary["strInstructions"] as? String ?? ""
    }
}

struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String
}
