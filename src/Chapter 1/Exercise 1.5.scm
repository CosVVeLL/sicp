; => normal-order evaluation
(test 0 (p))
; => 0

; => applicative-order evaluation
(test 0 (p))
; => infinite loop
