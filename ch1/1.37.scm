(define (cont-fract-rec n d k)
  (define (rec i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (rec (+ i 1))))))
  (rec 1))
(newline)
(display (cont-fract-rec (lambda (i) 1.0) (lambda (i) 1.0) 1000))

(define (cont-fract-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))
(newline)
(display (cont-fract-iter (lambda (i) 1.0) (lambda (i) 1.0) 1000))