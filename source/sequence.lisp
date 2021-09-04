
(in-package :cl-waffe)


(defclass SequenceLayer () nil)

(defmacro defsequence (sequence-name as initargs &rest layers)
  `(defclass ,sequence-name (SequenceLayer)
     ((self :accessor self
	    :initarg :self
	    :initform ',as)
      (initargs :accessor initargs
		:initarg :initargs
		:initform ',initargs)
      ,@(map 'list #'(lambda (layer) `(,(car layer) :initform ,(second layer)
						    :initarg ,(intern (symbol-name
								      (car layer))
								     "KEYWORD"))) layers))))
								      


