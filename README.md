# cl-waffe
A deeplearning library

# Example
```lisp
; implement attention seq2seq
(defsequence AttentionSeq2Seq :as seq :initargs (vocab-size embed-size hidden-size)
   (LSTMEncoder seq vocab-size embed-size hidden-size)
   (LSTMEncoder seq vocab-size embed-size hidden-size)
   (Atteention  seq hidden-size)
   (AtteentionLSTMDecoder seq vocab-size embed-size hidden-size))

(defmethod encode ((model AttentionSeq2Seq) words)
    ~~~)

(defmethod forward ((model LSTMEncoder) words)
    ~~~)

(defmethod encode ((model Attention) words)
    ~~~)

  ;...

(deflayer LSTMEEncoder (vocab-size embed-size hidden-size))
(deflayer Attention (vocab-size embed-size hidden-size))
(deflayer AttentionLSTMDecoder (vocab-size embed-size hidden-size))

(let ((model (make-sequence AttentionSeq2Seq 1024 1024 1024)))
  (train-model model ~~~ ...)
  (predict-model model ~~~ ...))
  ```
