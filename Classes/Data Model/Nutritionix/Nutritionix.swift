/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Nutritionix : Codable {
	let old_api_id : String?
	let item_id : String?
	let item_name : String?
	let leg_loc_id : String?
	let brand_id : String?
	let brand_name : String?
	let item_description : String?
	let updated_at : String?
	let nf_ingredient_statement : String?
	let nf_water_grams : String?
	let nf_calories : Int?
	let nf_calories_from_fat : Int?
	let nf_total_fat : Int?
	let nf_saturated_fat : String?
	let nf_trans_fatty_acid : String?
	let nf_polyunsaturated_fat : String?
	let nf_monounsaturated_fat : String?
	let nf_cholesterol : String?
	let nf_sodium : Int?
	let nf_total_carbohydrate : Int?
	let nf_dietary_fiber : String?
	let nf_sugars : Int?
	let nf_protein : Int?
	let nf_vitamin_a_dv : Int?
	let nf_vitamin_c_dv : Int?
	let nf_calcium_dv : Int?
	let nf_iron_dv : Int?
	let nf_refuse_pct : String?
	let nf_servings_per_container : Int?
	let nf_serving_size_qty : Int?
	let nf_serving_size_unit : String?
	let nf_serving_weight_grams : String?
	let allergen_contains_milk : String?
	let allergen_contains_eggs : String?
	let allergen_contains_fish : String?
	let allergen_contains_shellfish : String?
	let allergen_contains_tree_nuts : String?
	let allergen_contains_peanuts : String?
	let allergen_contains_wheat : String?
	let allergen_contains_soybeans : String?
	let allergen_contains_gluten : String?
	let usda_fields : String?

	enum CodingKeys: String, CodingKey {

		case old_api_id = "old_api_id"
		case item_id = "item_id"
		case item_name = "item_name"
		case leg_loc_id = "leg_loc_id"
		case brand_id = "brand_id"
		case brand_name = "brand_name"
		case item_description = "item_description"
		case updated_at = "updated_at"
		case nf_ingredient_statement = "nf_ingredient_statement"
		case nf_water_grams = "nf_water_grams"
		case nf_calories = "nf_calories"
		case nf_calories_from_fat = "nf_calories_from_fat"
		case nf_total_fat = "nf_total_fat"
		case nf_saturated_fat = "nf_saturated_fat"
		case nf_trans_fatty_acid = "nf_trans_fatty_acid"
		case nf_polyunsaturated_fat = "nf_polyunsaturated_fat"
		case nf_monounsaturated_fat = "nf_monounsaturated_fat"
		case nf_cholesterol = "nf_cholesterol"
		case nf_sodium = "nf_sodium"
		case nf_total_carbohydrate = "nf_total_carbohydrate"
		case nf_dietary_fiber = "nf_dietary_fiber"
		case nf_sugars = "nf_sugars"
		case nf_protein = "nf_protein"
		case nf_vitamin_a_dv = "nf_vitamin_a_dv"
		case nf_vitamin_c_dv = "nf_vitamin_c_dv"
		case nf_calcium_dv = "nf_calcium_dv"
		case nf_iron_dv = "nf_iron_dv"
		case nf_refuse_pct = "nf_refuse_pct"
		case nf_servings_per_container = "nf_servings_per_container"
		case nf_serving_size_qty = "nf_serving_size_qty"
		case nf_serving_size_unit = "nf_serving_size_unit"
		case nf_serving_weight_grams = "nf_serving_weight_grams"
		case allergen_contains_milk = "allergen_contains_milk"
		case allergen_contains_eggs = "allergen_contains_eggs"
		case allergen_contains_fish = "allergen_contains_fish"
		case allergen_contains_shellfish = "allergen_contains_shellfish"
		case allergen_contains_tree_nuts = "allergen_contains_tree_nuts"
		case allergen_contains_peanuts = "allergen_contains_peanuts"
		case allergen_contains_wheat = "allergen_contains_wheat"
		case allergen_contains_soybeans = "allergen_contains_soybeans"
		case allergen_contains_gluten = "allergen_contains_gluten"
		case usda_fields = "usda_fields"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		old_api_id = try values.decodeIfPresent(String.self, forKey: .old_api_id)
		item_id = try values.decodeIfPresent(String.self, forKey: .item_id)
		item_name = try values.decodeIfPresent(String.self, forKey: .item_name)
		leg_loc_id = try values.decodeIfPresent(String.self, forKey: .leg_loc_id)
		brand_id = try values.decodeIfPresent(String.self, forKey: .brand_id)
		brand_name = try values.decodeIfPresent(String.self, forKey: .brand_name)
		item_description = try values.decodeIfPresent(String.self, forKey: .item_description)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		nf_ingredient_statement = try values.decodeIfPresent(String.self, forKey: .nf_ingredient_statement)
		nf_water_grams = try values.decodeIfPresent(String.self, forKey: .nf_water_grams)
		nf_calories = try values.decodeIfPresent(Int.self, forKey: .nf_calories)
		nf_calories_from_fat = try values.decodeIfPresent(Int.self, forKey: .nf_calories_from_fat)
		nf_total_fat = try values.decodeIfPresent(Int.self, forKey: .nf_total_fat)
		nf_saturated_fat = try values.decodeIfPresent(String.self, forKey: .nf_saturated_fat)
		nf_trans_fatty_acid = try values.decodeIfPresent(String.self, forKey: .nf_trans_fatty_acid)
		nf_polyunsaturated_fat = try values.decodeIfPresent(String.self, forKey: .nf_polyunsaturated_fat)
		nf_monounsaturated_fat = try values.decodeIfPresent(String.self, forKey: .nf_monounsaturated_fat)
		nf_cholesterol = try values.decodeIfPresent(String.self, forKey: .nf_cholesterol)
		nf_sodium = try values.decodeIfPresent(Int.self, forKey: .nf_sodium)
		nf_total_carbohydrate = try values.decodeIfPresent(Int.self, forKey: .nf_total_carbohydrate)
		nf_dietary_fiber = try values.decodeIfPresent(String.self, forKey: .nf_dietary_fiber)
		nf_sugars = try values.decodeIfPresent(Int.self, forKey: .nf_sugars)
		nf_protein = try values.decodeIfPresent(Int.self, forKey: .nf_protein)
		nf_vitamin_a_dv = try values.decodeIfPresent(Int.self, forKey: .nf_vitamin_a_dv)
		nf_vitamin_c_dv = try values.decodeIfPresent(Int.self, forKey: .nf_vitamin_c_dv)
		nf_calcium_dv = try values.decodeIfPresent(Int.self, forKey: .nf_calcium_dv)
		nf_iron_dv = try values.decodeIfPresent(Int.self, forKey: .nf_iron_dv)
		nf_refuse_pct = try values.decodeIfPresent(String.self, forKey: .nf_refuse_pct)
		nf_servings_per_container = try values.decodeIfPresent(Int.self, forKey: .nf_servings_per_container)
		nf_serving_size_qty = try values.decodeIfPresent(Int.self, forKey: .nf_serving_size_qty)
		nf_serving_size_unit = try values.decodeIfPresent(String.self, forKey: .nf_serving_size_unit)
		nf_serving_weight_grams = try values.decodeIfPresent(String.self, forKey: .nf_serving_weight_grams)
		allergen_contains_milk = try values.decodeIfPresent(String.self, forKey: .allergen_contains_milk)
		allergen_contains_eggs = try values.decodeIfPresent(String.self, forKey: .allergen_contains_eggs)
		allergen_contains_fish = try values.decodeIfPresent(String.self, forKey: .allergen_contains_fish)
		allergen_contains_shellfish = try values.decodeIfPresent(String.self, forKey: .allergen_contains_shellfish)
		allergen_contains_tree_nuts = try values.decodeIfPresent(String.self, forKey: .allergen_contains_tree_nuts)
		allergen_contains_peanuts = try values.decodeIfPresent(String.self, forKey: .allergen_contains_peanuts)
		allergen_contains_wheat = try values.decodeIfPresent(String.self, forKey: .allergen_contains_wheat)
		allergen_contains_soybeans = try values.decodeIfPresent(String.self, forKey: .allergen_contains_soybeans)
		allergen_contains_gluten = try values.decodeIfPresent(String.self, forKey: .allergen_contains_gluten)
		usda_fields = try values.decodeIfPresent(String.self, forKey: .usda_fields)
	}

}
