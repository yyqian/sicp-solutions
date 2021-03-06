(define nil '())
(define x (list (list 1 (list 2 8 5)) (list 3 4)))
(define (append list1 list2)
  (if (null? list1)
      list2
      (cons (car list1) (append (cdr list1) list2))))
(define (fringe tree)
  (cond ((pair? tree) (append (fringe (car tree)) (fringe (cdr tree))))
        ((null? tree) nil)
        (else (list tree))))
(fringe x)