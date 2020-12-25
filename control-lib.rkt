 #lang slideshow
(define (square n)
  (filled-rectangle n n))

(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))
;; (checker (colorize (square 10) "red") (colorize (square 10) "black"))

(define (four p)
  (let ([two-p (hc-append p p)])
    (vc-append two-p two-p)))

(define (checkerboard p)
  (let* ([rp (colorize p "red")]
         [bp (colorize p "black")]
         [c  (checker rp bp)]
         [c4 (four c)])
    (four c4)))
;; (checkerboard (square 20))

(define (series mk)
    (hc-append (mk 5) (mk 10) (mk 20) (mk 10) (mk 5)))

;; (series (λ (size) (checkerboard (square size))))

(define (rgb-maker mk)
  (lambda (sz)
    (vc-append (colorize (mk sz) "red")
               (colorize (mk sz) "green")
               (colorize (mk sz) "blue"))))

(series (rgb-maker circle))

;;https://docs.racket-lang.org/quick/


;; #lang racket
;; (require plot)
;; (plot-new-window? #t)

;; (plot (function (λ (x) (abs x)) -5 5 #:label "y = sin(x)"))
