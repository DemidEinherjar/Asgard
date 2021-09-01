a = int(input()) #вход

b = int(input()) #выход

print(a+b) #сложение
print(a-b) #вычитание
print(a*b) #умножение
print(a/b) #частное
print(a//b) #целая часть от деления
print(a%b) #остаток от деления
print(((a**10)+(b**10))**0.5) #корень квадратный из суммы их 10-х степеней
#___________________________________________________________________________________
#Индекс массы тела
m = float(input())
h = float(input())

def imt(m, h):
    index = (m/(h*h))
    if index < 18.5:
        print('Недостаточная масса')
    elif index > 18.5 and index <= 25:
        print('Оптимальная масса')
    else:
        print('Избыточная масса')

imt(m, h)
#___________________________________________________________________________________
#Стоимость строки
#Дана строка текста. Напишите программу для подсчета стоимости строки, исходя из того,
#что один любой символ (в том числе пробел) стоит 60 копеек.
# Ответ дайте в рублях и копейках в соответствии с примерами.
text = input()
#cost = 60*len(text)
#rub = int(cost/100)
#kop = cost-(rub*100)
#print(f'{rub} р. {kop} коп.')
print(f'{int(60*len(text)/100)} р. {60*len(text)-(int(60*len(text)/100)*100)} коп.')
#or
x = len(input()) * 60
print(f'{x // 100}р. {x % 100}коп.')
#___________________________________________________________________________________
#Количество слов
#Дана строка, состоящая из слов, разделенных пробелами.
# Напишите программу, которая подсчитывает количество слов в этой строке
print(len(input().split()))
#___________________________________________________________________________________
#Зодиак
#Китайский гороскоп назначает животным годы в 12-летнем цикле.
#Один 12-летний цикл показан в таблице ниже.
#Таким образом, 2012 год будет очередным годом дракона.
#Напишите программу, которая считывает год и отображает название связанного с ним животного.
zodiak = ['Дракон','Змея','Лошадь','Овца','Обезьяна','Петух','Собака','Свинья','Крыса','Бык','Тигр','Заяц']
print(zodiak[(int(input())-2000)%12])
#___________________________________________________________________________________
#Переворот числа
#Дано пятизначное или шестизначное натуральное число. Напишите программу,
#которая изменит порядок его последних пяти цифр на обратный.
x = input()
if len(x) < 6:
    print(int(x[::-1]))
else:
    print(int(x[0] + x[len(x):0:-1]))
#or
s = input()
print(int(s[:-5] + s[-5:][::-1]))
#___________________________________________________________________________________
#Standard American Convention
#На вход программе подаётся натуральное число.
#Напишите программу,
#которая вставляет в заданное число запятые в соответствии со стандартным американским соглашением о запятых в больших числах.
value = int(input())
print(f'{value:,}') #использован 'a thousands separator'
#___________________________________________________________________________________
#Задача Иосифа Флавия
#n человек, пронумерованных числами от 1 до n, стоят в кругу.
#Они начинают считаться, каждый k-й по счету человек выбывает из круга,
#после чего счет продолжается со следующего за ним человека.
#Напишите программу, определяющую номер человека, который останется в кругу последним.
n = int(input())
k = int(input())
res = 0

for i in range(1, n+1):
    res = (res+k)%i
print(res+1)
#___________________________________________________________________________________
#Координатные четверти
#Дан набор точек на координатной плоскости.
#Необходимо подсчитать и вывести количество точек, лежащих в каждой координатной четверти.
#В первой строке записано количество точек.
#Каждая следующая строка состоит из двух целых чисел — координат точки (сначала абсцисса – x, затем ордината – y), разделенных символом пробела.
all = int(input())
one = 0
two = 0
three = 0
four = 0
for i in range(0, all):
    x, y = map(int, input().split())
    if x>0 and y>0:
        one +=1
    elif x<0 and y>0:
        two +=1
    elif x<0 and y<0:
        three +=1
    elif x>0 and y<0:
        four +=1

print(f'Первая четверть: {one} \n'
      f'Вторая четверть: {two} \n'
      f'Третья четверть: {three} \n'
      f'Четвертая четверть: {four}')
#___________________________________________________________________________________
#Больше предыдущего
#На вход программе подается строка текста из натуральных чисел.
#Из неё формируется список чисел. Напишите программу подсчета количества чисел,
#которые больше предшествующего им в этом списке числа, то есть, стоят вслед за меньшим числом.
value = list(map(int, input().split()))
arthur = 0

for i in range(1, len(value)):
    if value[i] > value[i-1]:
        arthur +=1
print(arthur)
#___________________________________________________________________________________
#Назад, вперёд и наоборот
#На вход программе подается строка текста из натуральных чисел.
#Из элементов строки формируется список чисел.
#Напишите программу, которая меняет местами соседние элементы списка (a[0] c a[1], a[2] c a[3] и т.д.).
#Если в списке нечетное количество элементов, то последний остается на своем месте.
a = [int(i) for i in input().split()]
for i in range(0, len(a)-1, 2):
    a[i], a[i+1] = a[i+1], a[i]
print(' '.join([str(i) for i in a]))
#print(*a)
#___________________________________________________________________________________
#Сдвиг в развитии
#На вход программе подается строка текста из натуральных чисел.
#Из элементов строки формируется список чисел. Напишите программу циклического сдвига элементов списка направо,
#когда последний элемент становится первым, а остальные сдвигаются на одну позицию вперед, в сторону увеличения индексов.
num_list = list(input().split())
print(num_list[-1], end = ' ')
print(*num_list[:-1])

a = input().split()
print(*[a[-1]] + a[:-1])

n=input().split()
print(n.pop(), *n)
#___________________________________________________________________________________
#Различные элементы
#На вход программе подается строка текста, содержащая натуральные числа,
#расположенные по неубыванию. Из строки формируется список чисел.
#Напишите программу для подсчета количества разных элементов в списке.
print(len(set(input().split())))
#___________________________________________________________________________________
#Произведение чисел
#Напишите программу для определения, является ли число произведением двух чисел из данного набора,
#выводящую результат в виде ответа «ДА» или «НЕТ».
a = int(input())
num_list = list()
num_list.append(a)
for i in range(a+1):
    num_list.append(int(input()))

def number(num_list):
    for i in range(1, num_list[0]+1):
        for j in range(i+1, num_list[0]+1):
            if num_list[i]*num_list[j] == num_list[-1]:
                return 'ДА'
    return 'НЕТ'
print(number(num_list))
#___________________________________________________________________________________
#Камень, ножницы, бумага
m = {'камень-камень': 'ничья', 'камень-ножницы': 'Тимур', 'камень-бумага': 'Руслан',
     'ножницы-ножницы': 'ничья','ножницы-бумага': 'Тимур', 'ножницы-камень': 'Руслан',
     "бумага-бумага": 'ничья','бумага-камень': 'Тимур','бумага-ножницы': 'Руслан'}
print(m[input() + '-' + input()])

print(['ничья', 'Тимур', 'Руслан'][input().count('а') - input().count('а')])
#___________________________________________________________________________________
#Орел и решка
#Дана строка текста, состоящая из букв русского алфавита "О" и "Р".
#Буква "О" – соответствует выпадению Орла, а буква "Р" – соответствует выпадению Решки.
#Напишите программу, которая подсчитывает наибольшее количество подряд выпавших Решек.
print(max(map(len, list(input().split('О')))))
#___________________________________________________________________________________
#Кремниевая долина 🌶️🌶️
#Для каждого холодильника существует строка с данными, состоящая из строчных букв и цифр,
#и если в ней присутствует слово "anton" (необязательно рядом стоящие буквы,
#главное наличие последовательности букв),
#то холодильник заражен и нужно вывести номер холодильника, нумерация начинается с единицы
a = int(input())
value = list()
pattern = 'anton'
answer = list()
for i in range(a):
    value.append(input())
    
for k in range(len(value)):
    count = 0
    srez = 0
    google = value[k][srez:]
    for letter in range(len(pattern)):
        google = google[srez:]
        if pattern[letter] in google:
            count +=1
            srez = google.find(pattern[letter])
        else:
            break
        if count == 5:
            answer.append(k+1)
            break
if len(answer) !=0:
    print(*answer)
#or
import re
sample = r'a.*n.*t.*o.*n'
result = []
n = int(input())
for k in range(n):
    if re.findall(sample, input()):
        result.append(k + 1)
print(*result)
#or
for i in range(int(input())):
    s, virus, x  = input(), 'anton', 0
    for sym in s:
        if sym == virus[x]:
            x += 1
        if x == 5:
            print(i + 1, end=' ')
            break 
#___________________________________________________________________________________
#Роскомнадзор запретил букву а 🌶️🌶️
#Алгоритм выводит в конце предложения следующую в алфавитном порядке букву,
#если она встречается в строке текста, а очередную строку отображает уже без этой буквы.
word = input() + ' запретил букву'
abc = ['а', 'б', 'в', 'г', 'д', 'е', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я']
sub = word
for letter in range(len(abc)):
    if abc[letter] in sub:
        print(f'{sub} {abc[letter]}')
        sub = sub.replace(abc[letter], '').replace('  ', ' ').strip()
        if len(sub) == 0:
            break
#___________________________________________________________________________________
#Предикат делимости
#Напишите функцию func(num1, num2), принимающую в качестве аргументов два натуральных
#числа num1 и num2 и возвращающую значение True если число num1 делится без остатка на число num2 и False в противном случае.
#Результатом вывода программы должно быть "делится" (если функция func() вернула True) и "не делится" (если функция func() вернула False).
def func(num1, num2):
    return num1%num2

num1, num2 = int(input()), int(input())

if func(num1, num2):
    print('не делится')
else:
    print('делится')
#___________________________________________________________________________________
#Списки
#На вход программе подается число n.
#Напишите программу, которая создает и выводит построчно вложенный список,
#состоящий из nn списков [[1, 2, ..., n], [1, 2, ..., n], ..., [1, 2, ..., n]].
a = int(input())
lst = []
for i in range(1, a+1):
    elem = [j for j in range(1, a+1)]   # создаем список из элементов строки
    lst.append(elem)
    print(elem)
#___________________________________________________________________________________
#На вход программе подается число n.
#Напишите программу, которая создает и выводит построчно вложенный список,
#состоящий из nn списков [[1], [1, 2], [1, 2, 3], ..., [1, 2, ..., n]].
a = int(input())
lst = []
for i in range(1, a+1):
    elem = [j for j in range(1, i+1)]
    lst.append(elem)
    print(elem)
#___________________________________________________________________________________
#Треугольник Паскаля
#Треугольник Паскаля — бесконечная таблица биномиальных коэффициентов, имеющая треугольную форму.
#В этом треугольнике на вершине и по бокам стоят единицы.
#Каждое число равно сумме двух расположенных над ним чисел.
def pascal(a):
    lst = [1]
    for i in range(a):
        lst = [sum(j) for j in zip([0]+lst, lst+[0])]
    return lst
print(pascal(int(input())))
#___________________________________________________________________________________
#Треугольник Паскаля 2
#На вход программе подается натуральное число n.
#Напишите программу, которая выводит первые nn строк треугольника Паскаля.
def pascal(a):
    lst = [1]
    for i in range(a):
        print(*lst)
        lst = [sum(j) for j in zip([0]+lst, lst+[0])]
       
pascal(int(input()))
#___________________________________________________________________________________
#Упаковка дубликатов 🌶️
#На вход программе подается строка текста, содержащая символы.
#Напишите программу, которая упаковывает последовательности одинаковых символов заданной строки в подсписки.



#___________________________________________________________________________________
#Матрицы
#Вывести матрицу 1
#На вход программе подаются два натуральных числа nn и mm, каждое на отдельной строке — количество строк и столбцов в матрице.
#Далее вводятся сами элементы матрицы — слова, каждое на отдельной строке; подряд идут элементы сначала первой строки, затем второй, и т.д.
#Напишите программу, которая сначала считывает элементы матрицы один за другим, затем выводит их в виде матрицы.
i = int(input())
j = int(input())
matrix = []

def print_matrix(matrix, i, j):
    for r in range(i):
        for c in range(j):
            print(matrix[r][c], end = ' ')
        print()
        
for row in range(i):
    temp = []
    for cow in range(j):
        temp.append(input())
    matrix.append(temp)

print_matrix(matrix, i, j)
#___________________________________________________________________________________
#Вывести матрицу 2



