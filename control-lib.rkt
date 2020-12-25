#lang racket
;; make a transfer function function

(define (transfer-function num den)
  ;; (transfer-finction '(1 2 3) '(4 5 7)) => s^2 + 2s + 3
  ;;                                          -------------
  ;;                                          4s^2 + 5s + 7
  (let* ([num-infix (make-infix (s-domain num))]
         [den-infix (make-infix (s-domain den))])
    (printf (string-append num-infix "\n"))
    (printf (string-append (make-vinculum num-infix den-infix) "\n"))
    (printf den-infix)))

(define (s-domain charac-eq)
  ;; (s-domain '(1 2 3) => ("s^2" "2s" "3")
  (for/list ([i charac-eq]
             [j (reverse (make-s-list charac-eq))])
    (cond [(or (equal? j "0") (= i 0)) (number->string i)]
          [(> i 1) (string-append (number->string i) j)]
          [(= i 1) j])))

(define (make-s-list charac-eq)
  ;; (make-s-list '(1 2 3)) => '(s^2 s 0)
  (let  ([charac-length (length charac-eq)])
    (for/list ([i (in-range charac-length)])
      (cond  [(> i 1) (string-append "s^" (number->string i))]
             [(= i 1) "s"]
             [(= i 0) (number->string 0)]))))

(define (make-infix s-list)
  ;; (make-infix '("s^2" "2s" "3")) => ("s^2 + 2s + 3")
  (let* ([s-final (remove "0" s-list)])
    (string-join s-final " + ")))

(define (make-vinculum num-infix den-infix)
  ;; (make-vinculum "s^2 + 2s + 3" "4s^3 + 5s^2 + 6s + 7") => ---------------
  (let* ([biggest-infix
          (max (string-length num-infix)
               (string-length den-infix))])
    (make-string biggest-infix #\-)))



(define num '(1 0 3))
(define den '(4 0 6 7))
;(define num-s-list (s-domain num))
;(define den-s-list (s-domain den))
;(define num-infix (make-infix num-s-list))
;(define den-infix (make-infix den-s-list))
;(make-vinculum num-infix den-infix)
(transfer-function num den)



