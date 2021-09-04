
(in-package #:cl-user)

(asdf:defsystem :cl-waffe
  :name "cl-waffe"
  :depends-on ()
  :description "A deeplearning library for Common Lisp"
  :author "hikettei"
  :license "MIT"
  :serial t
  :components ((:file "source/package")
	       (:file "source/sequence.lisp")
	       (:file "source/cl-waffe.lisp")
	       (:file "source/functions.lisp")))
