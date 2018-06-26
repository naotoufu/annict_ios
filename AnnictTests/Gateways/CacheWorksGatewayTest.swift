//
//  CacheWorksGatewayTest.swift
//  AnnictTests
//
//  Created by 伊東直人 on 2018/06/24.
//  Copyright © 2018 伊東直人. All rights reserved.
//

import Foundation
import XCTest

@testable import Annict

class CacheWorksGatewayTest: XCTestCase {
    // https://www.martinfowler.com/bliki/TestDouble.html
    var apiWorksGatewaySpy = ApiWorksGatewaySpy()
    var localPersistenceWorksGatewaySpy = LocalPersistenceWorksGatewaySpy()
    
    var cacheWorksGateway: CacheWorksGateway!
    
    // MARK: - Set up
    
    override func setUp() {
        super.setUp()
        cacheWorksGateway = CacheWorksGateway(apiWorksGateway: apiWorksGatewaySpy,
                                              localPersistenceWorksGateway: localPersistenceWorksGatewaySpy)
    }
    
    // MARK: - Tests
    
    func test_fetchWorks_api_success_save_locally() {
        // Given
        let worksToReturn = Work.createWorksArray()
        let expectedResultToBeReturned: Result<[Work]> = .success(worksToReturn)
        
        apiWorksGatewaySpy.fetchWorksResultToBeReturned = expectedResultToBeReturned
        
        let fetchWorksCompletionHandlerExpectation = expectation(description: "Fetch Works completion handler expectation")
        
        // When
        cacheWorksGateway.fetchWorks { (result) in
            // Then
            XCTAssertEqual(expectedResultToBeReturned, result, "The expected result wasn't returned")
            XCTAssertEqual(worksToReturn, self.localPersistenceWorksGatewaySpy.worksSaved, "The Works weren't saved on the local persistence")
            
            fetchWorksCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func test_fetchWorks_api_failure_fetch_from_local_persistence() {
        // Given
        let worksToReturnFromLocalPersistence = Work.createWorksArray()
        let expectedResultToBeReturnedFromLocalPersistence: Result<[Work]> = .success(worksToReturnFromLocalPersistence)
        let expectedResultFromApi: Result<[Work]> = .failure(NSError.createError(withMessage: "Some error fetching Works"))
        
        apiWorksGatewaySpy.fetchWorksResultToBeReturned = expectedResultFromApi
        localPersistenceWorksGatewaySpy.fetchWorksResultToBeReturned = expectedResultToBeReturnedFromLocalPersistence
        
        let fetchWorksCompletionHandlerExpectation = expectation(description: "Fetch Works completion handler expectation")
        
        // When
        cacheWorksGateway.fetchWorks { (result) in
            // Then
            XCTAssertEqual(expectedResultToBeReturnedFromLocalPersistence, result, "The expected result wasn't returned")
            XCTAssertTrue(self.localPersistenceWorksGatewaySpy.fetchWorksCalled, "Fetch Works wasn't called on the local persistence")
            
            fetchWorksCompletionHandlerExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // FIXME: can't add by REST Annict API
//    func test_add_api_success_add_locally_as_well() {
//        // Given
//        let workToAdd = Work.createWork()
//        let expectedResultToBeReturned: Result<Work> = .success(workToAdd)
//        let addWorkParameters = AddWorkParameters.createParameters()
//        apiWorksGatewaySpy.addWorkResultToBeReturned = expectedResultToBeReturned
//
//        let addWorkCompletionHandlerExpectation = expectation(description: "Add Work completion handler expectation")
//
//        // When
//        cacheWorksGateway.add(parameters: addWorkParameters) { (result) in
//            // Then
//            XCTAssertEqual(expectedResultToBeReturned, result, "The expected result wasn't returned")
//            XCTAssertEqual(addWorkParameters, self.apiWorksGatewaySpy.addWorkParameters, "Add Work parameters passed to API mismatch")
//            XCTAssertEqual(workToAdd, self.localPersistenceWorksGatewaySpy.addedWork, "The added Work wasn't passed to the local persistence")
//
//            addWorkCompletionHandlerExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//
//    func test_add_api_failure_add_locally() {
//        // Given
//        let workToAdd = Work.createWork()
//        let expectedResultToBeReturnedFromLocalPersistence: Result<Work> = .success(workToAdd)
//        let expectedResultsFromApi: Result<Work>! = .failure(NSError.createError(withMessage: "Some error adding Work"))
//        let addWorkParameters = AddWorkParameters.createParameters()
//
//        apiWorksGatewaySpy.addWorkResultToBeReturned = expectedResultsFromApi
//        localPersistenceWorksGatewaySpy.addWorkResultToBeReturned = expectedResultToBeReturnedFromLocalPersistence
//
//        let addWorkCompletionHandlerExpectation = expectation(description: "Add Work completion handler expectation")
//
//        // When
//        cacheWorksGateway.add(parameters: addWorkParameters) { (result) in
//            // Then
//            XCTAssertEqual(expectedResultToBeReturnedFromLocalPersistence, result, "The expected result wasn't returned")
//            XCTAssertEqual(addWorkParameters, self.apiWorksGatewaySpy.addWorkParameters, "Add Work parameters passed to API mismatch")
//            XCTAssertEqual(addWorkParameters, self.localPersistenceWorksGatewaySpy.addWorkParameters, "Add Work parameters passed to local persistence mismatch")
//
//            addWorkCompletionHandlerExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
//
//    func test_delete_api_delete_return_response_from_local_repo() {
//        // Given
//        let WorkToDelete = Work.createWork()
//        let expectedResultToBeReturnedFromApi: Result<Void> = .failure(NSError.createError(withMessage: "Some error delete Work"))
//        let expectedResultToBeReturnedFromLocalPersistence: Result<Void> = .success(())
//        apiWorksGatewaySpy.deleteWorkResultToBeReturned = expectedResultToBeReturnedFromApi
//        localPersistenceWorksGatewaySpy.deleteWorkResultToBeReturned = expectedResultToBeReturnedFromLocalPersistence
//
//        let deleteWorkCompletionHandlerExpectation = expectation(description: "Add Work completion handler expectation")
//
//        // When
//        cacheWorksGateway.delete(Work: WorkToDelete) { (result) in
//            XCTAssertEqual(expectedResultToBeReturnedFromLocalPersistence, result, "The expected result wasn't returned")
//            XCTAssertEqual(WorkToDelete, self.apiWorksGatewaySpy.deletedWork, "Work to delete wasn't passed to the API")
//            XCTAssertEqual(WorkToDelete, self.localPersistenceWorksGatewaySpy.deletedWork, "Work to delete wasn't passed to the local persistence")
//            deleteWorkCompletionHandlerExpectation.fulfill()
//        }
//
//        waitForExpectations(timeout: 1, handler: nil)
//    }
}
