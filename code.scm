(define atom?
  (lambda (x)
    (and (not (pair? x)) (not (null? x)))))

(define lat?
  (lambda (l)
    (cond
      ((null? l) #t)
      ((atom? (car l)) (lat? (cdr l)))
      (else #f))))

; (lat? '("a" "little"))

(define member?
  (lambda (a lat)
    (cond
      ((null? lat) #f)
      (else (or (eq? (car lat) a)
                    (member? a (cdr lat)))))))

; (member? 'poached '(a b poached d))

(define rember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      ((eq? (car lat) a) (cdr lat))
      (else (cons (car lat)
              (rember a (cdr lat)))))))

; (rember 'mint '(lamb chops and mint jelly))

(define firsts
  (lambda (l)
    (cond
      ((null? l) (quote ()))
      (else (cons (car (car l))
                (firsts (cdr l)))))))

; (firsts '((apple peach pumpkin) (plum pear cherry) (grape raisin pea) (bean carrot eggplant)))

(define insertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old) (cons old (cons new (cdr lat))))
          (else (cons (car lat) (insertR new old (cdr lat)))))))))

; (insertR 'topping 'fudge '(ice cream with fudge for dessert))

(define insertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old) (cons new (cons old (cdr lat))))
          (else (cons (car lat) (insertL new old (cdr lat)))))))))

; (insertL 'topping 'fudge '(ice cream with fudge for dessert))

(define subst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) old) (cons new (cdr lat)))
              (else (cons (car lat) (subst new old (cdr lat)))))))))


; (subst 'topping 'fudge '(ice cream with fudge for dessert))

(define subst2
  (lambda (new o1 o2 lat)
    (cond
      ((null? lat) (quote()))
      (else (cond
        ((or (eq? (car lat) o1) (eq? (car lat) o2)) (cons new (cdr lat)))
        (else (cons (car lat) (subst2 new o1 o2 (cdr lat)))))))))

; (subst2 'vanilla 'chocolate 'banana '(banana ice cream with chocolate topping))
(define multirember
  (lambda (a lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? a (car lat))
                (multirember a (cdr lat)))
              (else (cons (car lat)
                      (multirember a
                        (cdr lat)))))))))
; (multirember 'cup '(coffee cup tea cup and hick cup))

(define multiinsertR
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old) (cons old (cons new (multiinsertR(new old (cdr lat))))))
          (else (consn  (car lat) (multiinsertR new old (cdr lat)))))))))

(define multiinsertL
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else
        (cond
          ((eq? (car lat) old) (cons new (cons old (multiinsertL new old (cdr lat)))))
          (else (cons (car lat) (multiinsertL new old (cdr lat)))))))))

(define multisubst
  (lambda (new old lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((eq? (car lat) old) (cons new (multisubst new old (cdr lat))))
              (else (cons (car lat) (multisubst new old (cdr lat)))))))))

(define add1
  (lambda (n)
    (+ n 1)))

; (add1 1)

(define add
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (add1 (add n (sub1 m)))))))

; (add 3 4)

(define sub1
  (lambda (n)
    (- n 1)))

; (sub1 2)

(define sub
  (lambda (n m)
    (cond
      ((zero? m) n)
      (else (sub1 (sub n (sub1 m)))))))

; (sub 12 7)

(define addup
  (lambda (tup)
    (cond
      ((null? tup) 0)
      (else (+ (car tup) (addup (cdr tup)))))))

; (addup '(1 2 3 4 5))

(define multiply
  (lambda (n m)
    (cond
      ((zero? m) 0)
      (else (add n (multiply n (sub1 m)))))))

; (multiply 12 3)

(define tup+
  (lambda (tup1 tup2)
    (cond
      ((null? tup1) tup2)
      ((null? tup2) tup1)
      (else
        (cons (add (car tup1) (car tup2))
            (tup+ (cdr tup1) (cdr tup2)))))))

; (tup+ '(2 3 4 1) '(4 6))

(define >
  (lambda (n m)
    (cond
      ((zero? n) #f)
      ((zero? m) #t)
      (else (> (sub1 n) (sub1 m))))))

; (> 4 3)

(define <
  (lambda (n m)
    (cond
      ((zero? m) #f)
      ((zero? n) #t)
      (else (< (sub1 n) (sub1 m))))))

; (< 4 3)

(define =
  (lambda (n m)
    (cond
      ((< n m) #f)
      ((> n m) #f)
      (else #t))))

(define ↑
  (lambda (n m)
    (cond
      ((zero? m) 1)
      (else (multiply n (↑ n (sub1 m)))))))

; (↑ 5 3)

(define ÷
  (lambda (n m)
    (cond
      ((< n m) 0)
      (else (add1 (÷ (sub n m) m))))))

; (÷ 15 4)

(define length
  (lambda (lat)
    (cond
      ((null? lat) 0)
      (else (add1 (length (cdr lat)))))))

; (length '(hotdog with mustard sauerkruat and pickles))

(define pick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (car lat))
      (else (pick (sub1 n) (cdr lat))))))

; (pick 4 '(hotdog with mustard sauerkruat and pickles))

(define rempick
  (lambda (n lat)
    (cond
      ((zero? (sub1 n)) (cdr lat))
      (else (cons (car lat) (rempick (sub1 n) (cdr lat)))))))

; (rempick 3 '(hotdogs with hot mustard))

(define no-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((number? (car lat)) (no-nums (cdr lat)))
              (else (cons (car lat) (no-nums (cdr lat)))))))))

; (no-nums '(5 pears 6 prunes 9 dates))

(define all-nums
  (lambda (lat)
    (cond
      ((null? lat) (quote ()))
      (else (cond
              ((number? (car lat))
                (cons (car lat) (all-nums (cdr lat))))
              (else (all-nums (cdr lat))))))))

; (all-nums '(5 pears 6 prunes 9 dates))

(define occur
  (lambda (a lat)
    (cond
      ((null? lat) 0)
      (else
        (cond
           ((eq? a (car lat)) (add1 (occur a (cdr lat))))
            (else (occur a (cdr lat)))
        )))))

; (occur 5 '(5 pears 5 prunes 9 dates))

(define one?
  (lambda (n)
    (= n 1)))

; (one? 2)

(define rempick2
  (lambda (n lat)
    (cond
      ((one? n) (cdr lat))
      (else
        (cons (car lat) (rempick2 (sub1 n) (cdr lat)))))))

(rempick 3 '(lemon meringue salty pie))
