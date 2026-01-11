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


(defun check-merge-lists-pairs (name l1 l2 expected)
  "Execute merge-lists-pairs and compare result with expected"
  (format t "~:[FAILED~;passed~] ~a~%"
          (equal (merge-lists-pairs l1 l2) expected)
          name))


(defun check-sublist-after-p (name lst elem sub expected)
  "Execute sublist-after-p and compare result with expected"
  (format t "~:[FAILED~;passed~] ~a~%"
          (eql (sublist-after-p lst elem sub) expected)
          name))


(defun test-variant-7 ()
  (format t "~%=== Testing merge-lists-pairs (Variant 7) ===~%")

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

  (format t "~%=== Testing sublist-after-p (Variant 7) ===~%")

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


(test-variant-7)