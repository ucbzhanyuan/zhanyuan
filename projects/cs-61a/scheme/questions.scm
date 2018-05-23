(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (if (null? rests)
    nil
    (cons (cons first (car rests)) (cons-all first (cdr rests)))))

(define (zip pairs) ;Each list in PAIRS should have and only have length of 2
  (list (map car pairs) (map cadr pairs))
  )

;; Problem 17
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 17
  (define (helper s k)
    (if (null? s)
        nil
        (cons (cons k (list (car s))) (helper (cdr s) (+ k 1))))
  )
  (helper s 0))
  ; END PROBLEM 17

;; Problem 18
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 18
  (cond 
    ((null? denoms) nil)
    ((< total 0) nil)
    ((= total 0) (cons (list (car denoms)) nil))
    ((< total (car denoms)) (list-change total (cdr denoms)))
    ((= (car denoms) total) (append (list-change (- total (car denoms)) denoms) 
                                    (list-change total (cdr denoms))))
    (else (append (cons-all (car denoms) (list-change (- total (car denoms)) denoms)) 
                  (list-change total (cdr denoms))))
    )
  )
  
  ; END PROBLEM 18

;; Problem 19
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr))))

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond ((atom? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((quoted? expr)
         ; BEGIN PROBLEM 19
         expr
         ; END PROBLEM 19
         )
        ((or (lambda? expr)
             (define? expr))
         (let ((form   (car expr))
               (params (cadr expr))
               (body   (cddr expr)))
           ; BEGIN PROBLEM 19
           (if (null? (cdr body)) ;Check if we call this procedure
            (list form params (car body))
            (list form params (car body) (let-to-lambda (cadr body)))) ;Also need to "evaluate" the values being passed in
           ; END PROBLEM 19
           ))
        ((let? expr)
         (let ((values (cadr expr))
               (body   (car (cddr expr))))
           ; BEGIN PROBLEM 19
           (define zipped (zip values))
           (define params (car zipped))
           (define myvalues (cadr zipped))
           (append
                (list (list 'lambda params (let-to-lambda body)))
                (map let-to-lambda myvalues))
           ; END PROBLEM 19
           ))
        (else
         ; BEGIN PROBLEM 19
         (let ((form (car expr))
               (first (cadr expr))
               (second (car (cddr expr))))
              (list form (let-to-lambda first) (let-to-lambda second)))
         ; END PROBLEM 19
         )))
