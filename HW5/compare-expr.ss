
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
      [(list first ...) x]
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