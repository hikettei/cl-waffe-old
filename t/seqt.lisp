
(defsequence simplenet seq (input-shape)
	     (f (dense input-shape :activation #'relu))
	     (s (dense 1           :activation #'sigmoid)))

(make-sequence simplenet 100)
