
(defsequence Encoder seq (vocab-size embed-size hidden-size)
	     :xe (EmbedID vocab-size embed-size)
	     :eh (Linear embed-size (* 4 hidden-size))
	     :hh (Linear hidden-size (* 4 hidden-size)))

(defsequence Decoder seq (vocab-size embed-size hidden-size))

(defsequence Seq2Seq seq (vocab-size embed-size hidden-size)
	     :encoder (Encoder vocab-size embed-size hidden-size)
	     :decoder (Decoder vocab-size embed-size hidden-size))

(defmethod call ((model Encoder) x c h)
  (let ((e (tanh (getlayer :xe x))))
    (lstm c (+   (getlayer :eh e)
	         (getlayer :hh h)))))

(defmethod call ((model Decoder) ~~)
  )

(defmethod call ((model Seq2Seq) ~~~)
  )



