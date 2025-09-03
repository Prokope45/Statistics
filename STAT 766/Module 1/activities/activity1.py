

class stat766:
    def __init__(self):
        self.Semester: int = 2024
        self.class_start_date: str = 'Aug 19, 2024'
        self.class_end_date: str = 'Dec 5, 2024'


class stat766_2(stat766):
    def __init__(self, Student_name: str, Student_major: str):
        self.Student: str = Student_name
        self.Major: str = Student_major
        super().__init__()


class stat766_3(stat766_2):
    def __init__(self, Student_name, Student_major):
        super().__init__(Student_name, Student_major)

    def Add(self) -> str:
        return "{} {}".format(self.Student, self.Major)
