; 这里比较关键的地方有2点：
; (1) make-sum和make-product用.来处理多个参数，由于.后面的参数是个list，所以要谨慎处理
; (2) augend, multiplicand在提取的过程中，如果有2个以上参数，就需要把尾部构造成一个表达式
;     譬如(+ 1 2 3 4 5)，要把它看成(+ 1 (+ 2 3 4 5))，因此augend解析得到的应当是(+ 2 3 4 5)
;     这样程序就可以递归地去处理多个参数的表达式

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (let ((u (base exp))
               (n (exponent exp)))
           (make-product
             n
             (make-product
               (make-exponentiation u (- n 1))
               (deriv u var)))))
        (else
          (error "unknow expression type -- DERIV" exp))))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum m1 . m2)
  (if (= 1 (length m2))
      (let ((m2 (car m2)))
        (cond ((=number? m1 0) m2)
              ((=number? m2 0) m1)
              ((and (number? m1) (number? m2)) (+ m1 m2))
              (else (list '+ m1 m2))))
      (cond ((=number? m1 0) (cons '+ m2))
            (else (cons '+ (cons m1 m2))))))

(define (make-product m1 . m2)
  (if (= 1 (length m2))
      (let ((m2 (car m2)))
        (cond ((or (=number? m1 0) (=number? m2 0)) 0)
              ((=number? m1 1) m2)
              ((=number? m2 1) m1)
              ((and (number? m1) (number? m2)) (* m1 m2))
              (else (list '* m1 m2))))
      (cond ((=number? m1 0) 0)
            ((=number? m1 1) (cons '* m2))
            (else (cons '* (cons m1 m2))))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))

(define (addend s)
  (cadr s))

(define (augend s)
  (if (= 3 (length s))
      (caddr s)
      (cons '+ (cddr s))))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (if (= 3 (length p))
      (caddr p)
      (cons '* (cddr p))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base x)
  (cadr x))

(define (exponent x)
  (caddr x))

(define (make-exponentiation u n)
  (cond ((= n 0) 1)
        ((= n 1) u)
        (else (list '** u n))))

(trace-entry deriv)
(deriv '(* x y (+ x 3)) 'x)