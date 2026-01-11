<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент(-ка)</b>: Кузнецов Дмитро Сергійович  КВ-21</p>
<p align="right"><b>Рік</b>: 2025</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, що виконують деякі дії з вхідним(и) списком(-ами), за
можливості/необхідності використовуючи різні види рекурсії. Функції, які необхідно
реалізувати, задаються варіантом (п. 2.1.1). Вимоги до функцій:
1. Зміна списку згідно із завданням має відбуватись за рахунок конструювання нового
списку, а не зміни наявного (вхідного).
2. Не допускається використання функцій вищого порядку чи стандартних функцій
для роботи зі списками, що не наведені в четвертому розділі навчального
посібника.
3. Реалізована функція не має бути функцією вищого порядку, тобто приймати функції
в якості аргументів.
4. Не допускається використання псевдофункцій (деструктивного підходу).
5. Не допускається використання циклів.
Кожна реалізована функція має бути протестована для різних тестових наборів. Тести
мають бути оформленні у вигляді модульних тестів (див. п. 2.3).

## Варіант 7
1. Написати функцію merge-lists-pairs , яка групує відповідні елементи двох списків:
```lisp
CL-USER> (merge-lists-pairs '(1 2 3 4 5) '(a b c d))
((1 A) (2 B) (3 C) (4 D) (5))
```
2. Написати предикат sublist-after-p , який
перевіряє, чи знаходиться після визначеного елемента списку атомів визначена послідовність елементів (список):
```lisp
CL-USER> (sublist-after-p '(1 a 2 b 3 c 4 d) 'b '(3 c))
T
CL-USER> (sublist-after-p '(1 a 2 b 3 c 4 d) 'b '(3 c d))
NIL
```
## Лістинг функції merge-lists-pairs
```lisp
(defun merge-lists-pairs (l1 l2)
  (cond
    ((and (null l1) (null l2)) nil)

    ((and l1 l2)
     (cons (list (car l1) (car l2))
           (merge-lists-pairs (cdr l1) (cdr l2))))

    (l1
     (cons (list (car l1))
           (merge-lists-pairs (cdr l1) nil)))

    (t
     (cons (list (car l2))
           (merge-lists-pairs nil (cdr l2))))))

```
### Тестові набори та утиліти
```lisp
(defun check-merge-lists-pairs (name l1 l2 expected)
  "Execute merge-lists-pairs and compare result with expected"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (merge-lists-pairs l1 l2) expected)
          name))


(defun test-variant-7 ()
    (format t "~% Testing merge-lists-pairs (Variant 7)~%")

    (check-merge-lists-pairs "test 1"
                            '(1 2 3)
                            '(a b c)
                            '((1 a) (2 b) (3 c)))

    (check-merge-lists-pairs "test 2"
                            '(1 2 3 4 5)
                            '(a b c d)
                            '((1 a) (2 b) (3 c) (4 d) (5)))

    (check-merge-lists-pairs "test 3"
                            nil
                            '(a b)
                            '((a) (b)))
```
### Тестування
```lisp

(test-variant-7)

 Testing merge-lists-pairs (Variant 7)
passed test 1
passed test 2
passed test 3
```
## Лістинг функції sublist-after-p
```lisp
(defun sublist-after-p (lst elem sub)
  (cond
    ((null lst) nil)
    ((eql (car lst) elem)
     (labels ((check (l s)
                (cond
                  ((null s) t)
                  ((null l) nil)
                  ((eql (car l) (car s))
                   (check (cdr l) (cdr s)))
                  (t nil))))
       (check (cdr lst) sub)))

    (t
     (sublist-after-p (cdr lst) elem sub))))
```
### Тестові набори та утиліти
```lisp
(defun check-sublist-after-p (name lst elem sub expected)
  "Execute sublist-after-p and compare result with expected"
  (format t "~:[FAILED~;passed~] ~a~%"
          (eql (sublist-after-p lst elem sub) expected)
          name))

(defun test-variant-7 ()
  (format t "~% Testing sublist-after-p (Variant 7)~%")

  (check-sublist-after-p "test 4"
                         '(1 a 2 b 3 c 4 d)
                         'b
                         '(3 c)
                         t)
(check-sublist-after-p "test 5"
                         '(1 a 2 b 3 c 4 d)
                         'b
                         '(3 c d)
                         nil)

  (check-sublist-after-p "test 6"
                         '(a b c d e)
                         'c
                         '(d e)
                         t)

  (check-sublist-after-p "test 7"
                         '(a b c d e)
                         'c
                         '(e)
                         nil))


```
### Тестування
```lisp
(test-variant-7)

 Testing sublist-after-p (Variant 7)
passed test 4
passed test 5
passed test 6
passed test 7
```
