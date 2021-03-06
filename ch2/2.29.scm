(define (make-mobile left right)
  (list left right))
(define (make-branch length structure)
  (list length structure))
(define (mobile? structure)
  (pair? structure))
;a)
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (car (cdr mobile)))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (car (cdr branch)))
;b)
(define (total-weight mobile)
  (if (mobile? mobile)
      (+ (total-weight (branch-structure (left-branch mobile)))
         (total-weight (branch-structure (right-branch mobile))))
      mobile))
;c)
(define (balanced? mobile)
  (= (* (branch-length (left-branch mobile)) (total-weight (branch-structure (left-branch mobile))))
     (* (branch-length (right-branch mobile)) (total-weight (branch-structure (right-branch mobile))))))
(define (all-balanced? mobile)
  (if (mobile? mobile)
      (and (balanced? mobile)
           (all-balanced? (branch-structure (left-branch mobile)))
           (all-balanced? (branch-structure (right-branch mobile))))
      #t))
;d) 2 times: right-branch & branch-structure
(all-balanced? (make-mobile (make-branch 5 (make-mobile (make-branch 2 1) (make-branch 2 1))) (make-branch 2 5)))