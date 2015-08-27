(define (make-interval a b)
  (cons a b))
(define (upper-bound c)
  (max (car c) (cdr c)))
(define (lower-bound c)
  (min (car c) (cdr c)))
(define (print interval)
  (newline)
  (display "(")
  (display (lower-bound interval))
  (display ",")
  (display (upper-bound interval))
  (display ")"))

(define (make-center-percent center percent)
  (let ((half-width (/ (abs (* center percent)) 2)))
    (cons (- center half-width) (+ center half-width))))

(define (percent interval)
  (let ((width (- (upper-bound interval) (lower-bound interval)))
        (center (/ (+ (upper-bound interval) (lower-bound interval)) 2)))
    (abs (/ width center))))

;testing
(percent (make-center-percent 100 0.87))