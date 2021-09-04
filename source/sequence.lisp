
(in-package :cl-waffe)


(defmacro symbolk (symbol) `(intern (symbol-name ,symbol) "KEYWORD"))

(defclass SequenceLayer ()
  ((self :accessor seqself)
   (initarg :accessor seqargs)
   (layers :accessor seqlayers)))

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
	      :initform ',(map 'list #'(lambda (layer) (car layer))
			       layers))
      ,@(map 'list #'(lambda (layer) `(,(car layer) :initform (quote ,(second layer))
						    :initarg ,(symbolk (car layer))))
	     layers))))


