#FizzBuzz
#Напишите программу, которая выводит числа от 1 до 100.
#Но вместо чисел, кратных трем, выводите «Fizz»,
#вместо кратных пяти выводите «Buzz», вместо кратных и трем, и пяти — «FizzBuzz»

def fizz_buzz():
    for i in range(1, 101):
        if i % 3 == 0 and i % 5 == 0 :
            print('FizzBuzz')
        elif i % 3 == 0 :
            print('Fizz')
        elif i % 5 == 0 :
            print('Buzz')
        else:
            print(i)
#fizz_buzz()

#Последовательный поиск
def ss(number_list, n):
    found = False
    for i in number_list:
        if i == n:
            found = True
            break
    return found

#Палиндром Palinfrome
def palindrome(word):
    word = word.lower()
    return word[::-1] == word
#print(palindrome('Mama'))
#print(palindrome('Mam'))

#Анаграмма Anagram
def anagram(w1, w2):
    w1 = w1.lower()
    w2 = w2.lower()
    return sorted(w1) == sorted(w2)
#print(anagram('тапок', 'капот'))
#print(anagram('лист','дерево'))

#Подсчет вхождений символов
def count_characters(string):
    count_dict = {}
    string = string.lower()
    for c in string:
        if c in count_dict:
            count_dict[c] += 1
        else:
            count_dict[c] = 1
    print(count_dict)
#count_characters('Demid')

#Рекурсия
def bottles_of_beer(bob):
    if bob < 1:
        print('Нет бутылок на стене:. Нет бутылок пива.')
        return
    tmp = bob
    bob -= 1
    print(f'{tmp} бутылок пива на стене. {tmp} бутылок пива.'
        f'Возьми одну, пусти по кругу, {bob} бутылок на стене.')
    bottles_of_beer(bob)
#bottles_of_beer(99)

#Фибоначи
def fib():
    a, b = 1, 1
    while True:
        yield a
        a, b = b, a + b

for index, x in enumerate(fib()):
    if index == 10:
        break
    print("%s" % x),