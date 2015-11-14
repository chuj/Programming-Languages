
(define compare-expr
  (lambda (x y)
    (match x
      ; Boolean
      [#t 
        (if (equal? x y)
          x
          'TCP
        )
      ]
      ; Boolean
      [#f 
        (if (equal? x y)
          x
          '(not TCP)
        )
      ]
      ; Empty List
      ['() x]
      ; List
      [(list begin ...) 
        (if (equal? (length x) (length y))
          ; double quotes
          (if (equal? (car x) `quote)
            (if (equal? (cdr x) (cdr y))
              (cdr x)
              `(if TCP ,x ,y)
            )
            (match (car x)
              ; nested list
              [(list first ...)
                (cons (compare-expr (car x) (car y)) (compare-expr (cdr x) (cdr y)))
              ]
              ; special if case
              ['if
                (if (equal? (car x) (car y))
                  (cons (car x) (compare-expr (cdr x) (cdr y)))
                  `(if TCP ,x ,y)
                )
              ]
              ; lambda case
              ['lambda
                (if (equal? (cdr x) (cdr y))
                  x
                  `(if TCP ,x ,y)
                )
              ]
              ; let case
              ['let
                (if (equal? (cdr x) (cdr y))
                  x
                  `(if TCP ,x ,y)
                )
              ]
              ; false
              [#f
                (if (equal? (car x) (car y))
                  x
                  (cons '(not TCP) (compare-expr (cdr x) (cdr y)))
                )
              ]
              ; true
              [#t
                (if (equal? (car x) (car y))
                  x
                  (cons '(not TCP) (compare-expr (cdr x) (cdr y)))
                )
              ]
              ; general case
              [ _
                (if (equal? (car x) (car y))
                  (cons (car x) (compare-expr (cdr x) (cdr y)))
                  (cons `(if TCP ,(car x) ,(car y)) (compare-expr (cdr x) (cdr y))  )
                )
              ]
            )
          )
          `(if TCP ,x ,y)
        )
      ]
      ; Literal
      [literal
        (if (equal? x y)
          x
          `(if TCP ,x ,y)
        )
      ]      
      ; Number
      [number
        (if (= x y)
          x
          `(if TCP ,x ,y)
        )
      ]
    )
  ) 
)


; Part 2
(define test-compare-expr 
  (lambda (x y)
    (if (equal? (eval x) (let ([TCP #t]) (compare-expr x y)))
      (if (equal? (eval y) (let ([TCP #f]) (compare-expr x y)))
        #t
        #f
      )
      #f
    )
  )
)
