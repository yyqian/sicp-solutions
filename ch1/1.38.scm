(define (cont-fract-rec n d k)
  (define (rec i)
    (if (= i k)
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (rec (+ i 1))))))
  (rec 1))
(define (cont-fract-iter n d k)
  (define (iter i result)
    (if (= i 0)
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define (n i) 1.0)
(define (d i)
  (if (= (remainder i 3) 2)
      (/ (+ i 1) 1.5)
      1))
(newline)
(display (+ 2 (cont-fract-rec n d 100)))
(newline)
(display (+ 2 (cont-fract-iter n d 100)))