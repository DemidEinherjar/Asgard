class Orange:
    def __init__(self, w, c):
        self.weight = w
        self.color = c
        print('Create!')
#or1 = Orange(10, 'orange')
#print(or1.weight, or1.color)

class Stack:
    def __init__(self):
        self.items = []
    
    def is_empty(self): #возвращает значение True если ваш стек пуст, и False в противном случае
        return self.items == []
    
    def push(self, item): #добавляет элемент на «вершину» стека
        self.items.append(item)
    
    def pop(self): #удаляет и возвращает элемент с «вершины» стека
        return self.items.pop()
    
    def peek(self): #возвращает этот элементов, но не удаляет его
        return self.items[-1]
    
    def size(self): #возвращает целое число, представляющее количество элементов в стеке
        return len(self.items)

#stack = Stack()
#for c in 'Hello!':
#    stack.push(c)

#reverse = ''

#for j in range(stack.size()):
#    reverse += stack.pop()
#print(reverse)

class Queue:
    def __init__(self):
        self.items = []
    
    def is_empty(self): #проверяет, пуста ли очередь
        return self.items == []
    
    def enqueue(self, item):
        self.items.insert(0, item)
    
    def dequeue(self, item): #удаляет элемент из очереди
        return self.items.pop()
    
    def size(self): #возвращает количество элементов в очереди
        return len(self.items)

a = Queue()
for i in range(5):
    a.enqueue(i)

for j in range(a.size()):
    print(a.dequeue(i))
print(a.size())
