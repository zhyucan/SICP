 (define (multi a b)
 	((define (iter a b product)
 		(if (= b 0)
 			  product
 			  ((even? b)
 			  	(iter (double a) (halve b) product))
 			  ((odd? b)
 			  	(iter a (- b 1) (+ a product))))))
 	(iter a b 0))