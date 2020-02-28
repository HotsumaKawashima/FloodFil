import Foundation

let UNRAPE = 0
let RAPE = 1
let NONE = -1

func initialize(_ input: String) -> (M: Int, N: Int, table: [[Int]], list: [(x: Int, y: Int)]) {
    let row = input.components(separatedBy: .newlines)
    let M = Int(row[0].components(separatedBy: " ")[0])!
    let N = Int(row[0].components(separatedBy: " ")[1])!
    var table = [[Int]]()
    for i in 1...N {
        let temp = row[i].components(separatedBy: " ").map{ Int($0)! }
        table.append(temp)
    }

    var list = [(x: Int, y: Int)]()
    for y in 0..<N {
        for x in 0..<M {
            if table[y][x] == RAPE {
                list.append((x: x,y: y))
            }
        }
    }
    
    return (M, N, table, list)
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
            if b == UNRAPE {
                print(" 0", terminator: " ")
            } else if b == RAPE {
                print(" 1", terminator: " ")
            } else if b == NONE {
                print("-1", terminator: " ")
            } else {
                print(NSString(format: "% 2d", b), terminator: " ")
            }
        }
        i += 1
        print("")
    }
}

func walk(_ list:[(x: Int, y:Int)], _ table: [[Int]], _ day: Int = 1) -> Int {
    if list.count < 1 {
        for y in 0..<table.count {
            for x in 0..<table[0].count {
                if table[y][x] == UNRAPE {
                    return -1
                }
            }
        }
        
        return day - 2
    }

    var _table = table 
    var next = [(x: Int, y: Int)]()
    for p in list {
        let adjs = [
            (x: p.x, y: p.y - 1),
            (x: p.x, y: p.y + 1),
            (x: p.x - 1, y: p.y),
            (x: p.x + 1, y: p.y)
        ]
        
        for adj in adjs {
            if adj.x < 0 || table[0].count - 1 < adj.x { continue }
            if adj.y < 0 || table.count - 1 < adj.y { continue }

            if table[adj.y][adj.x] == UNRAPE {
                next.append(adj)
                _table[adj.y][adj.x] = day
            }
        }
    }
    //printTable(String(day), _table)
    return walk(next, _table, day + 1)
}

let input1 = "6 4\n0 0 0 0 0 0\n0 0 0 0 0 0\n0 0 0 0 0 0\n0 0 0 0 0 1"
let input2 = "6 4\n0 -1 0 0 0 0\n-1 0 0 0 0 0\n0 0 0 0 0 0\n0 0 0 0 0 1"
let input3 = "6 4\n1 -1 0 0 0 0\n0 -1 0 0 0 0\n0 0 0 0 -1 0\n0 0 0 0 -1 1"
let input4 = "5 5\n-1 1 0 0 0\n0 -1 -1 -1 0\n0 -1 -1 -1 0\n0 -1 -1 -1 0\n0 0 0 0 0"
let input5 = "2 2\n1 -1\n-1 1"

let (M1, N1, table1, list1) = initialize(input1)

print("M1: \(M1)")
print("N1: \(N1)")
printTable("table1: ", table1)
print("list1: \(list1)")
print("result: \(walk(list1, table1))")
print("")

let (M2, N2, table2, list2) = initialize(input2)
print("M2: \(M2)")
print("N2: \(N2)")
printTable("table2: ", table2)
print("list2: \(list2)")
print("result: \(walk(list2, table2))")
print("")

let (M3, N3, table3, list3) = initialize(input3)
print("M3: \(M3)")
print("N3: \(N3)")
printTable("table3: ", table3)
print("list3: \(list3)")
print("result: \(walk(list3, table3))")
print("")

let (M4, N4, table4, list4) = initialize(input4)
print("M4: \(M4)")
print("N4: \(N4)")
printTable("table4: ", table4)
print("list4: \(list4)")
print("result: \(walk(list4, table4))")
print("")

let (M5, N5, table5, list5) = initialize(input5)
print("M5: \(M5)")
print("N5: \(N5)")
printTable("table5: ", table5)
print("list5: \(list5)")
print("result: \(walk(list5, table5))")
print("")