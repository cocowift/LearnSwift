//: Playground - Currying: Learn From 100 Swift Tips

func addTwoNumbers(a: Int)(num: Int) -> Int {
    return a+num
}

let addToFour = addTwoNumbers(4) // Int->Int
let result = addToFour(num: 6)  // result = 10


func greaterThan(comparor: Int)(input : Int) -> Bool{
    return input > comparor;
}

let greaterThan10 = greaterThan(10)
greaterThan10(input : 13)
greaterThan10(input : 9)

//Currying Can Make func

/// using Selector

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject> : TargetAction{
    weak var target: T?
    let action:(T) -> () -> ()
    
    func performAction()  -> () {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TounchUpInside
    case ValueChanged
    //..
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    
    func setTarget<T: AnyObject>(target: T,action: (T) -> () -> (), controlEvent: ControlEvent){
            actions[controlEvent] = TargetActionWrapper(target:target,action:action)
        }
    
    func removeTargetForControlEvent(controlEvent: ControlEvent){
            actions[controlEvent] = nil
        }
    
    func performSctionForcontrolEvent(controlEvent: ControlEvent){
            actions[controlEvent]?.performAction()
    }
}

//safety action!
