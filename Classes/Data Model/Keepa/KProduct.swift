/*
 Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

 For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

 */

import Foundation
struct KProducts : Codable {
    let csv : [[Int]]?
    let categories : [Int]?
    let audienceRating : String?
    let imagesCSV : String?
    let manufacturer : String?
    let title : String?
    let lastUpdate : Int?
    let lastPriceChange : Int?
    let rootCategory : Int?
    let productType : Int?
    let parentAsin : String?
    let variationCSV : String?
    let asin : String?
    let domainId : Int?
    let type : String?
    let hasReviews : Bool?
    let trackingSince : Int?
    let brand : String?
    let productGroup : String?
    let partNumber : String?
    let model : String?
    let color : String?
    let size : String?
    let edition : String?
    let format : String?
    let packageHeight : Int?
    let packageLength : Int?
    let packageWidth : Int?
    let packageWeight : Int?
    let packageQuantity : Int?
    let isAdultProduct : Bool?
    let isEligibleForTradeIn : Bool?
    let isEligibleForSuperSaverShipping : Bool?
    let offers : String?
    let buyBoxSellerIdHistory : String?
    let isRedirectASIN : Bool?
    let isSNS : Bool?
    let author : String?
    let binding : String?
    let numberOfItems : Int?
    let numberOfPages : Int?
    let publicationDate : Int?
    let releaseDate : Int?
    let languages : [[String]]?
    let lastRatingUpdate : Int?
    let ebayListingIds : String?
    let lastEbayUpdate : Int?
    let eanList : [String]?
    let upcList : String?
    let liveOffersOrder : String?
    let frequentlyBoughtTogether : [String]?
    let features : String?
    let description : String?
    let promotions : String?
    let newPriceIsMAP : Bool?
    let coupon : String?
    let availabilityAmazon : Int?
    let listedSince : Int?
    let fbaFees : FbaFees?
    let variations : String?
    let itemHeight : Int?
    let itemLength : Int?
    let itemWidth : Int?
    let itemWeight : Int?
    let salesRankReference : Int?
    let salesRanks : SalesRanks?
    let salesRankReferenceHistory : [Int]?
    let launchpad : Bool?
    let stats : String?
    let offersSuccessful : Bool?
    let g : Int?
    let categoryTree : [CategoryTree]?

    enum CodingKeys: String, CodingKey {

        case csv = "csv"
        case categories = "categories"
        case imagesCSV = "imagesCSV"
        case audienceRating = "audienceRating"
        case manufacturer = "manufacturer"
        case title = "title"
        case lastUpdate = "lastUpdate"
        case lastPriceChange = "lastPriceChange"
        case rootCategory = "rootCategory"
        case productType = "productType"
        case parentAsin = "parentAsin"
        case variationCSV = "variationCSV"
        case asin = "asin"
        case domainId = "domainId"
        case type = "type"
        case hasReviews = "hasReviews"
        case trackingSince = "trackingSince"
        case brand = "brand"
        case productGroup = "productGroup"
        case partNumber = "partNumber"
        case model = "model"
        case color = "color"
        case size = "size"
        case edition = "edition"
        case format = "format"
        case packageHeight = "packageHeight"
        case packageLength = "packageLength"
        case packageWidth = "packageWidth"
        case packageWeight = "packageWeight"
        case packageQuantity = "packageQuantity"
        case isAdultProduct = "isAdultProduct"
        case isEligibleForTradeIn = "isEligibleForTradeIn"
        case isEligibleForSuperSaverShipping = "isEligibleForSuperSaverShipping"
        case offers = "offers"
        case buyBoxSellerIdHistory = "buyBoxSellerIdHistory"
        case isRedirectASIN = "isRedirectASIN"
        case isSNS = "isSNS"
        case author = "author"
        case binding = "binding"
        case numberOfItems = "numberOfItems"
        case numberOfPages = "numberOfPages"
        case publicationDate = "publicationDate"
        case releaseDate = "releaseDate"
        case languages = "languages"
        case lastRatingUpdate = "lastRatingUpdate"
        case ebayListingIds = "ebayListingIds"
        case lastEbayUpdate = "lastEbayUpdate"
        case eanList = "eanList"
        case upcList = "upcList"
        case liveOffersOrder = "liveOffersOrder"
        case frequentlyBoughtTogether = "frequentlyBoughtTogether"
        case features = "features"
        case description = "description"
        case promotions = "promotions"
        case newPriceIsMAP = "newPriceIsMAP"
        case coupon = "coupon"
        case availabilityAmazon = "availabilityAmazon"
        case listedSince = "listedSince"
        case fbaFees = "fbaFees"
        case variations = "variations"
        case itemHeight = "itemHeight"
        case itemLength = "itemLength"
        case itemWidth = "itemWidth"
        case itemWeight = "itemWeight"
        case salesRankReference = "salesRankReference"
        case salesRanks = "salesRanks"
        case salesRankReferenceHistory = "salesRankReferenceHistory"
        case launchpad = "launchpad"
        case stats = "stats"
        case offersSuccessful = "offersSuccessful"
        case g = "g"
        case categoryTree = "categoryTree"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        csv = try values.decodeIfPresent([[Int]].self, forKey: .csv)
        categories = try values.decodeIfPresent([Int].self, forKey: .categories)
        imagesCSV = try values.decodeIfPresent(String.self, forKey: .imagesCSV)
        audienceRating = try values.decodeIfPresent(String.self, forKey: .audienceRating)
        manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        lastUpdate = try values.decodeIfPresent(Int.self, forKey: .lastUpdate)
        lastPriceChange = try values.decodeIfPresent(Int.self, forKey: .lastPriceChange)
        rootCategory = try values.decodeIfPresent(Int.self, forKey: .rootCategory)
        productType = try values.decodeIfPresent(Int.self, forKey: .productType)
        parentAsin = try values.decodeIfPresent(String.self, forKey: .parentAsin)
        variationCSV = try values.decodeIfPresent(String.self, forKey: .variationCSV)
        asin = try values.decodeIfPresent(String.self, forKey: .asin)
        domainId = try values.decodeIfPresent(Int.self, forKey: .domainId)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        hasReviews = try values.decodeIfPresent(Bool.self, forKey: .hasReviews)
        trackingSince = try values.decodeIfPresent(Int.self, forKey: .trackingSince)
        brand = try values.decodeIfPresent(String.self, forKey: .brand)
        productGroup = try values.decodeIfPresent(String.self, forKey: .productGroup)
        partNumber = try values.decodeIfPresent(String.self, forKey: .partNumber)
        model = try values.decodeIfPresent(String.self, forKey: .model)
        color = try values.decodeIfPresent(String.self, forKey: .color)
        size = try values.decodeIfPresent(String.self, forKey: .size)
        edition = try values.decodeIfPresent(String.self, forKey: .edition)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        packageHeight = try values.decodeIfPresent(Int.self, forKey: .packageHeight)
        packageLength = try values.decodeIfPresent(Int.self, forKey: .packageLength)
        packageWidth = try values.decodeIfPresent(Int.self, forKey: .packageWidth)
        packageWeight = try values.decodeIfPresent(Int.self, forKey: .packageWeight)
        packageQuantity = try values.decodeIfPresent(Int.self, forKey: .packageQuantity)
        isAdultProduct = try values.decodeIfPresent(Bool.self, forKey: .isAdultProduct)
        isEligibleForTradeIn = try values.decodeIfPresent(Bool.self, forKey: .isEligibleForTradeIn)
        isEligibleForSuperSaverShipping = try values.decodeIfPresent(Bool.self, forKey: .isEligibleForSuperSaverShipping)
        offers = try values.decodeIfPresent(String.self, forKey: .offers)
        buyBoxSellerIdHistory = try values.decodeIfPresent(String.self, forKey: .buyBoxSellerIdHistory)
        isRedirectASIN = try values.decodeIfPresent(Bool.self, forKey: .isRedirectASIN)
        isSNS = try values.decodeIfPresent(Bool.self, forKey: .isSNS)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        binding = try values.decodeIfPresent(String.self, forKey: .binding)
        numberOfItems = try values.decodeIfPresent(Int.self, forKey: .numberOfItems)
        numberOfPages = try values.decodeIfPresent(Int.self, forKey: .numberOfPages)
        publicationDate = try values.decodeIfPresent(Int.self, forKey: .publicationDate)
        releaseDate = try values.decodeIfPresent(Int.self, forKey: .releaseDate)
        languages = try values.decodeIfPresent([[String]].self, forKey: .languages)
        lastRatingUpdate = try values.decodeIfPresent(Int.self, forKey: .lastRatingUpdate)
        ebayListingIds = try values.decodeIfPresent(String.self, forKey: .ebayListingIds)
        lastEbayUpdate = try values.decodeIfPresent(Int.self, forKey: .lastEbayUpdate)
        eanList = try values.decodeIfPresent([String].self, forKey: .eanList)
        upcList = try values.decodeIfPresent(String.self, forKey: .upcList)
        liveOffersOrder = try values.decodeIfPresent(String.self, forKey: .liveOffersOrder)
        frequentlyBoughtTogether = try values.decodeIfPresent([String].self, forKey: .frequentlyBoughtTogether)
        features = try values.decodeIfPresent(String.self, forKey: .features)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        promotions = try values.decodeIfPresent(String.self, forKey: .promotions)
        newPriceIsMAP = try values.decodeIfPresent(Bool.self, forKey: .newPriceIsMAP)
        coupon = try values.decodeIfPresent(String.self, forKey: .coupon)
        availabilityAmazon = try values.decodeIfPresent(Int.self, forKey: .availabilityAmazon)
        listedSince = try values.decodeIfPresent(Int.self, forKey: .listedSince)
        fbaFees = try values.decodeIfPresent(FbaFees.self, forKey: .fbaFees)
        variations = try values.decodeIfPresent(String.self, forKey: .variations)
        itemHeight = try values.decodeIfPresent(Int.self, forKey: .itemHeight)
        itemLength = try values.decodeIfPresent(Int.self, forKey: .itemLength)
        itemWidth = try values.decodeIfPresent(Int.self, forKey: .itemWidth)
        itemWeight = try values.decodeIfPresent(Int.self, forKey: .itemWeight)
        salesRankReference = try values.decodeIfPresent(Int.self, forKey: .salesRankReference)
        salesRanks = try values.decodeIfPresent(SalesRanks.self, forKey: .salesRanks)
        salesRankReferenceHistory = try values.decodeIfPresent([Int].self, forKey: .salesRankReferenceHistory)
        launchpad = try values.decodeIfPresent(Bool.self, forKey: .launchpad)
        stats = try values.decodeIfPresent(String.self, forKey: .stats)
        offersSuccessful = try values.decodeIfPresent(Bool.self, forKey: .offersSuccessful)
        g = try values.decodeIfPresent(Int.self, forKey: .g)
        categoryTree = try values.decodeIfPresent([CategoryTree].self, forKey: .categoryTree)
    }

}
