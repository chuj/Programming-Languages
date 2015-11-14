
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
            ; regular list
            (if (equal? (car x) (car y))
              (cons (car x) (compare-expr (cdr x) (cdr y)))
              (cons `(if TCP ,(car x) ,(car y)) (compare-expr (cdr x) (cdr y))  )
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
