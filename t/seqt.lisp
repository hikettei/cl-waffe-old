
(defsequence simplenet seq (input-shape)
	     (f (dense input-shape))
	     (s (dense 1)))

(defparameter model (SimpleNet 10))

(defmethod call ((model SimpleNet) x)
  (calllayer model s (calllayer model f x)))
