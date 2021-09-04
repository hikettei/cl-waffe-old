
(in-package :cl-waffe)


(defclass SequenceLayer () nil)

(defmacro defsequence (sequence-name as initargs &rest layers)
  `(defclass ,sequence-name (SequenceLayer)
     ((self :accessor seqself
	    :initarg :self
	    :initform ',as)
      (initargs :accessor seqargs
		:initarg :initargs
		:initform ',initargs)
      (layers :accessor seqlayers
	      :initargs :layers
	      :initform ,(map 'list #'(lambda (layer) (car layer))
			       layers))
      ,@(map 'list #'(lambda (layer) `(,(car layer) :initform (quote ,(second layer))
						    :initarg ,(intern (symbol-name
								      (car layer))
								      "KEYWORD")))
	     layers))))

(defmacro init-sequence (sequence-name &rest args))
