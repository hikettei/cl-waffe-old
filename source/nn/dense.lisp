
(in-package #:cl-waffe.nn)

(deflayer Dense (w b) (x) model
  (+ w b x))
