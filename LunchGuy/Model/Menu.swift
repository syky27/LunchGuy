//
//  Menu.swift
//  LunchGuy
//
//  Created by Josef Dolezal on 23/10/2017.
//  Copyright © 2017 AJTY, s.r.o. All rights reserved.
//

import Foundation

struct Menu: Decodable {
    enum RootCodingKeys: String, CodingKey { case data }
    enum DataCodingKeys: String, CodingKey { case attributes }
    enum AttributesCodingKeys: String, CodingKey { case content }

    let mealCategories: [MealCategory]

    init(mealCategories: [MealCategory]) {
        self.mealCategories = mealCategories
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        let data = try container.nestedContainer(keyedBy: DataCodingKeys.self, forKey: .data)
        let attributes = try data.nestedContainer(keyedBy: AttributesCodingKeys.self, forKey: .attributes)
        let mealsInCatgories = (try? attributes.decode([String: [Meal]].self, forKey: .content)) ?? [:]
        let mealCategories = mealsInCatgories.map { MealCategory(category: $0, meals: $1) }

        self.init(mealCategories: mealCategories)
    }
}
