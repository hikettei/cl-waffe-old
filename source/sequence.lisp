
(in-package :cl-waffe)


(defclass SequenceLayer ()
  ((name :accessor name
	 :initarg :name
	 :initform nil)))

(defmacro defsequence (sequence-name as initargs &rest layers)
  `(defclass ,sequence-name (SequenceLayer)
     ((self :accessor self
	    :initarg :self
	    :initform ',as)
      (initargs :accessor initargs
		:initarg :initargs
		:initform ',initargs)
      (layers :accessor layers
	      :initarg :layers
	      :initform ',layers))))


