(define (* a b)
	(cond ((= b 1) 1)
		    ((even? b) (double (* a (halve b))))
		    (else (+ a (* a (- b 1))))))


(* 10 32)
(* 20 16)
(* 40 8)
(* 80 4)
(* 160 2)
(* 320 1)