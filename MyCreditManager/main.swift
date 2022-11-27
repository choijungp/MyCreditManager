struct Subject {
    var title: String
    var score: String
}
let Score = ["A+":4.5, "A":4.0, "B+":3.5, "B":3.0, "C+":2.5, "C":2.0, "D+":1.5, "D":1.0, "F":0.0]

var input: String = ""
var students = [String: [Subject]]()
repeat {
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    
    input = readLine()!
    
    switch input {
    case "1":
        AddStudent()
    case "2":
        DeleteStudent()
    case "3":
        AddScore()
    case "4":
        DeleteScore()
    case "5":
        GetGrade()
    case "X":
        print("프로그램을 종료합니다...")
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
} while (input != "X")


func AddStudent() {
    print("추가할 학생의 이름을 입력해주세요")
    let student = readLine()!
    
    if student == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    else {
        if students.keys.contains(student) {
            print("\(student)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
        else {
            students[student] = []
        }
    }
}

func DeleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let student = readLine()!
    
    if student == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    else {
        if !students.keys.contains(student) {
            print("\(student) 학생을 찾지 못했습니다.")
        }
        else {
            students.removeValue(forKey: student)
            print("\(student) 학생을 삭제하였습니다.")
        }
    }
}

func AddScore() {
    print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift A+")
    print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
    
    let student = readLine()!.split(separator: " ")
    if student.count != 3 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    else {
        if !students.keys.contains(String(student[0])) {
            print("\(student[0]) 학생을 찾지 못했습니다.")
        }
        else {
            if !Score.keys.contains(String(student[2])) {
                print("과목 입력이 잘못되었습니다. 다시 확인해주세요.")
            }
            else {
                let subject = Subject(title: String(student[1]), score: String(student[2]))

                if students[String(student[0])]!.map({$0.title}).contains(String(student[1])) {
                    if let idx = students[String(student[0])]!.firstIndex(where: {$0.title == String(student[1])}) {
                        students[String(student[0])]![idx] = Subject(title: String(student[1]), score: String(student[2]))
                    }
                }
                else {
                    students[String(student[0])]!.append(subject)
                }

                print("\(String(student[0])) 학생의 \(String(student[1])) 과목이 \(String(student[2]))로 추가(변경)되었습니다.")
            }
        }
    }
}

func DeleteScore() {
    print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
    print("입력예) Mickey Swift")
    let student = readLine()!.split(separator: " ")
    
    if student.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    else {
        if !students.keys.contains(String(student[0])) {
            print("\(student[0]) 학생을 찾지 못했습니다.")
        }
        else {
            if let idx = students[String(student[0])]!.firstIndex(where: {$0.title == String(student[1])}) {
                students[String(student[0])]!.remove(at: idx)
            }
            print("\(student[0]) 학생의 \(student[1]) 과목의 성적이 삭제되었습니다.")
        }
    }
}

func GetGrade() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    let student = readLine()!
    if student == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    }
    else {
        if !students.keys.contains(student) {
            print("\(student) 학생을 찾지 못했습니다.")
        }
        else {
            var total = 0.0
            for subject in students[student]! {
                print("\(subject.title): \(subject.score)")
                total += Score[subject.score]!
            }
            print("평점 : \(total / Double(students[student]!.count))")
        }
    }
}
