
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
      ; List
      [(list begin ...) 
        (if (equal? (car x) (car y))
          (cons (car x) (compare-expr (cdr x) (cdr y)))
          #f
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