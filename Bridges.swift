import Foundation

let ISLAND = -1
let COUNTRY = 1
let INF = 999999
let OCEAN = INF

func initialize(_ input: String) -> (N: Int, table: [[Int]]) {
    let row = input.components(separatedBy: .newlines)
    let N = Int(row[0])!
    var table = [[Int]]()

    for i in 1...N {
        let temp = row[i].components(separatedBy: " ").map { $0 == "1" ? ISLAND : OCEAN }
        table.append(temp)
    }

    return (N, table)
}

func enqueue(_ array: inout [(x: Int, y:Int, cost: Int)],_ head: inout Int, _ num: inout Int, _ obj:(x: Int, y:Int, cost: Int)) {
    if num < array.count {
        array[(head + num) % array.count] = obj
        num = num + 1
    }
}

func dequeue(_ array: inout [(x: Int, y:Int, cost: Int)],_ head: inout Int, _ num: inout Int) -> (x: Int, y:Int, cost: Int) {
    if num > 0 {
        let obj = array[head]
        array[head] = (x: -1, y: -1, cost: -1)
        num = num - 1
        head = (head + 1) % array.count;
        return obj
    }
    return (x: -1, y: -1, cost: -1)
}

func surround(_ now: (x: Int, y: Int, cost: Int), _ table:[[Int]]) -> [(x: Int, y: Int, cost: Int)] {
    let ss = [
        (x: now.x, y: now.y - 1, cost: now.cost + 1),
        (x: now.x, y: now.y + 1, cost: now.cost + 1),
        (x: now.x - 1, y: now.y, cost: now.cost + 1),
        (x: now.x + 1, y: now.y, cost: now.cost + 1)
    ]

    var array = [(x: Int, y: Int, cost: Int)]()
    
    for s in ss {
        if s.x < 0 || table[0].count - 1 < s.x { continue }
        if s.y < 0 || table.count - 1 < s.y { continue }
        array.append(s)
    }

    return array
}

func find(_ table: inout [[Int]]) -> Int {
    var q1 = [(x: Int, y: Int, cost: Int)](repeating: (x: -1, y: -1, cost: -1), count: table.count * table.count)
    var h1 = 0
    var n1 = 0
    var q2 = [(x: Int, y: Int, cost: Int)](repeating: (x: -1, y: -1, cost: -1), count: table.count * table.count)
    var h2 = 0
    var n2 = 0

    for x in 0..<table.count {
        for y in 0..<table.count {
            if x == 0 || y == 0 || x == table.count - 1 || y == table.count - 1 {
                enqueue(&q1, &h1, &n1, (x: x, y: y, cost: 0))
            }
        }
    }

    while n1 > 0 {
        var now = dequeue(&q1, &h1, &n1)

        if table[now.y][now.x] == ISLAND {
            table[now.y][now.x] = COUNTRY

            for s in surround(now, table) {
                enqueue(&q1, &h1, &n1, s)
                enqueue(&q2, &h2, &n2, (x: s.x, y: s.y, cost: 2))
            }
        }
    }

    var result = INF
    while n2 > 0 {
        var now = dequeue(&q2, &h2, &n2)

        if table[now.y][now.x] > now.cost {
            table[now.y][now.x] = now.cost

            for s in surround(now, table) {
                enqueue(&q2, &h2, &n2, s)
            }
        }

        if table[now.y][now.x] < 0 {
            if now.cost < result {
                result = now.cost
            }
        }
    }
    return result - 2
}

func printTable(_ name: String, _ table: [[Int]]) {
    print(name)
    print("  ", terminator: "")
    for i in 0..<table[0].count {
        print(NSString(format: "% 2d", i), terminator: " ")
    }
    print("")
    var i = 0
    for a in table {
        print(i, terminator: " ")
        for b in a {
            if b == OCEAN {
                print(" 0", terminator: " ")
            } else if b == COUNTRY {
                print(" 1", terminator: " ")
            } else if b == ISLAND {
                print("-1", terminator: " ")
            } else {
                print(NSString(format: "% 2d", b), terminator: " ")
            }
        }
        i += 1
        print("")
    }
}

let input1 = "10\n1 1 1 0 0 0 0 1 1 1\n1 1 1 1 0 0 0 0 1 1\n1 0 1 1 0 0 0 0 1 1\n0 0 1 1 1 0 0 0 0 1\n0 0 0 1 0 0 0 0 0 1\n0 0 0 0 0 0 0 0 0 1\n0 0 0 0 0 0 0 0 0 0\n0 0 0 0 1 1 0 0 0 0\n0 0 0 0 1 1 1 0 0 0\n0 0 0 0 0 0 0 0 0 0"
// 3

let input2 = "10\n1 1 1 0 0 0 0 1 1 1\n1 1 1 1 0 0 0 0 1 1\n1 0 1 1 0 0 0 0 1 1\n0 0 1 1 1 0 0 0 0 1\n0 0 0 1 0 0 0 0 0 1\n0 0 0 0 0 0 1 0 0 1\n0 0 0 0 0 0 1 0 0 0\n0 0 0 0 1 1 1 0 0 0\n0 0 0 0 1 1 1 0 0 0\n0 0 0 0 0 0 0 0 0 0"
// 2

var (M1, table1) = initialize(input1)
//print("M1: \(M1)")
//printTable("table1: ", table1)
print("result: \(find(&table1))")
//printTable("table1: ", table1)


