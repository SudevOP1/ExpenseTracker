
class Person:
    def __init__(self, name, age):
        self.name = name      # attribute
        self.age = age

    def greet(self):          # method
        print(f"Hello, my name is {self.name}")

# Create object
p1 = Person("Alice", 25)
p1.greet()