(define (last-pair items)
	(cond ((null? items) (error "list empty -- LAST-PART"))
	      ((null? (cdr items) items)
		    (else (last-pair (cdr items))))))