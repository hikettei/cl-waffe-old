
(in-package :cl-waffe)


(defmacro symbolk (symbol) `(intern (symbol-name ,symbol) "KEYWORD"))
(defmacro pushs (obj place) `(concatenate 'list (list ,obj) ,place))

(defclass SequenceLayer ()
  ((self    :accessor seqself)
   (initarg :accessor seqargs)
   (layers  :accessor seqlayers)))

(defmacro defsequence (sequence-name as initargs &rest layers)
  `(progn
     (defmethod ,sequence-name ,initargs
	(init-sequence ',sequence-name ,@initargs))
     (defclass ,sequence-name (SequenceLayer)
	((self :accessor seqself
	       :initarg :self
	       :initform ',as)
	 (initargs :accessor seqargs
		   :initarg :initargs
		   :initform ',initargs)
	 (initargs-value :accessor initargs-value
			 :initarg :initargvalue
			 :initform nil)
	 (layers :accessor seqlayers
		 :initargs :layers
		 :initform ',(map 'list #'(lambda (layer) (car layer))
			       layers)) ; init layer sitai
	 ,@(map 'list #'(lambda (layer) `(,(car layer) :initform (quote ,(second layer))
						       :initarg ,(symbolk (car layer))))
		layers)))))

(defmacro deflayer (layer-name params args model-as &body body)
  `(progn
     (defclass ,layer-name ()
       ((params :initarg :params
		:initform ',params)
	(param-args :initarg :param-args
		    :initform ',(map 'list
				     #'(lambda (x) (symbol-name (car x))) params))
	,@(map 'list #'(lambda (x) (list (car x)
					   :initarg (symbolk (car x))
					   :initform nil)) params)))
     (defmethod ,layer-name (,model-as ,@args)
       (with-slots ,(map 'list #'(lambda (x) (car x)) params) ,model-as
	 ,@body))))

(defmacro initlayer (layer-name &rest args)
  (let* ((model (make-instance layer-name))
	 (params (slot-value model 'params))
	 (pargs (slot-value model 'param-args)))
	       `(let* (,@(loop for i from 0 to (1- (length params))
			      :collect (list (car (nth i params))
					     (nth i args)))
		      ,@(map 'list #'(lambda (x)
				       `(,(car x)
					 ,(pushs 'progn (cdr x)))) params))
		  (declare (special ,@(map 'list #'intern pargs)))
		  (dotimes (i (length ',params))
		    (setf (slot-value ,model (intern (nth i ',pargs)))
			  (or (eval (eval (intern (nth i ',pargs))))
			      (nth i ',args))))
		     ,model)))

(defmacro calllayer (model layer-name &rest args)
  `(let ((input-layer 1))
     (funcall (slot-value ,model ',layer-name) ,@args)))

(defmacro init-sequence (seq-name &rest args)
  `(compile-sequence (make-instance ,seq-name) ,args))

(defmacro compile-sequence (seq args)
  `(progn
     (setf (slot-value ,seq 'initargs-value) (list ,@args))
     ,seq))

			     
