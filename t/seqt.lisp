
(defsequence simplenet seq (input-shape)
	     (f (dense input-shape #'relu))
	     (s (dense 1           #'sigmoid)))

(defparameter model (SimpleNet 10))

(defmethod call ((model SimpleNet) x)
  (calllayer model s (calllayer model f x)))
