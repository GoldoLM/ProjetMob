

import XCTest

class EventsUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false

        app.launch()
    }


  
    func testNavigation_Activities() throws {
        
        
        let app = XCUIApplication()
        app.scrollViews["Activities List"].otherElements.buttons["Keynote, Opening remarks (Friday), 10:00 AM - 10:25 AM"].tap()
        app.navigationBars["Opening remarks (Friday)"].buttons["Activities"].tap()
        
        
    }
    
 
    func testNavigation_Sponsors() throws {
        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Sponsors"].tap()
        
        let sponsorsContainerScrollView = app.scrollViews["Sponsors Container"]
        sponsorsContainerScrollView.otherElements.containing(.staticText, identifier:"Pledged $").element.swipeUp()
        sponsorsContainerScrollView.otherElements.scrollViews.otherElements.buttons["AE, Absolute Electric"].tap()
        app.navigationBars["Absolute Electric"].buttons["Sponsors"].tap()
        
    }
    

    func testNavigation_Attendees() throws {

        
        let app = XCUIApplication()
        app.tabBars["Tab Bar"].buttons["Attendees"].tap()
        
        let elementsQuery = app.scrollViews["Attendees Container"]
        elementsQuery.swipeUp()
        elementsQuery.buttons["PD, Peyton Devereaux"].tap()
        app.navigationBars["Peyton Devereaux"].buttons["Attendees"].tap()
        
        
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
           
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
