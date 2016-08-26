import CoreData
import XCTest
import DATAStack
import NSManagedObject_HYPPropertyMapper

class FillWithDictionaryTests: XCTestCase {
    func testBug112() {
        let dataStack = Helper.dataStackWithModelName("Bug112")

        let owner = Helper.insertEntity("Owner", dataStack: dataStack)
        owner.setValue(NSProcessInfo.processInfo().globallyUniqueString, forKey: "id")

        let tasklist = Helper.insertEntity("Tasklist", dataStack: dataStack)
        tasklist.setValue(NSProcessInfo.processInfo().globallyUniqueString, forKey: "id")
        tasklist.setValue(owner, forKey: "owner")

        let task = Helper.insertEntity("Task", dataStack: dataStack)
        task.setValue(NSProcessInfo.processInfo().globallyUniqueString, forKey: "id")
        task.setValue(tasklist, forKey: "taskList")
        task.setValue(owner, forKey: "owner")

        try! dataStack.mainContext.save()

        print("Data saved successfully!")
        print("-----")
        print(tasklist)
        print(task)
        print("-----")

        print("Trying to make JSON...")
        print(tasklist.hyp_dictionary())
    }
}