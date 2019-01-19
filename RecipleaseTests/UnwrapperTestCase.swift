//
//  UnwrapperTestCase.swift
//  RecipleaseTests
//
//  Created by Morgan on 19/01/2019.
//  Copyright © 2019 Morgan. All rights reserved.
//

import XCTest
@testable import Reciplease

class UnwrapperTestCase: XCTestCase {


    let recipeTest = Recipes.Recipe(recipeName: "Pâtes",
                                    id: "1",
                                    rating: 4,
                                    totalTimeInSeconds: 720,
                                    smallImageUrls: ["a"])

    let recipeNilTest = Recipes.Recipe(recipeName: "Pâtes",
                                       id: "1",
                                       rating: nil,
                                       totalTimeInSeconds: nil,
                                       smallImageUrls: ["a"])

    let detailedRecipeSource = DetailedRecipe.Source(sourceRecipeUrl: "aze")
    let detailedRecipeImages = DetailedRecipe.Images(hostedLargeUrl: "asx")

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // test .rating has value
    func testRatingUnwrappedReturnStringWithStar() {
        // given recipeTest

        // when
        let ratingString = Unwrapper.unwrap(.rating, for: recipeTest)

        // then
        XCTAssertEqual("4 ⭐️", ratingString)
    }

    // test .rating is nil
    func testRatingIsNilUnwrappedReturnNotAvailableString() {
        // given recipeNilTest

        // when
        let notAvailableString = Unwrapper.unwrap(.rating, for: recipeNilTest)

        // then
        XCTAssertEqual("n/a", notAvailableString)
    }

    // test .time has value
    func testTimeUnwrappedReturnStringWithSingleQuote() {
        // given recipeNilTest

        // when
        let timeString = Unwrapper.unwrap(.time, for: recipeTest)

        // then
        XCTAssertEqual("12'", timeString)
    }

    // test .time is nil
    func testTimeIsNilUnwrappedReturnNotAvailableString() {
        // given recipeNilTest

        // when
        let notAvailableString = Unwrapper.unwrap(.time, for: recipeNilTest)

        // then
        XCTAssertEqual("n/a", notAvailableString)
    }

    // test .servings has value
    func testServingsUnwrappedReturnStringWithServings() {
        // given
        let detailedRedipe = DetailedRecipe(ingredientLines: ["a"],
                                            numberOfServings: 3,
                                            source: detailedRecipeSource,
                                            images: [detailedRecipeImages])

        // when
        let servingsString = Unwrapper.unwrap(.servings, for: detailedRedipe)

        // then
        XCTAssertEqual("Servings: 3", servingsString)

    }

    // test .servings is nil
    func testServingsIsNilUnwrappedReturnNotAvailableString() {
        // given
        let detailedRedipe = DetailedRecipe(ingredientLines: ["a"],
                                            numberOfServings: nil,
                                            source: detailedRecipeSource,
                                            images: [detailedRecipeImages])

        // when
        let notAvailableString = Unwrapper.unwrap(.servings, for: detailedRedipe)

        // then
        XCTAssertEqual("n/a", notAvailableString)

    }
}
