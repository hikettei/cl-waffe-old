
(in-package #:cl-waffe.nn)

(deflayer Dense ((w (make-array w))
		 (b (make-array b))) (x) model
  (+ w b x))

