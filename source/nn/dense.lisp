
(in-package #:cl-waffe.nn)

(defun mmul (A B)
  (let* ((m (car (array-dimensions A)))
         (n (cadr (array-dimensions A)))
         (l (cadr (array-dimensions B)))
         (C (make-array `(,m ,l) :initial-element 0)))
    (loop for i from 0 to (- m 1) do
              (loop for k from 0 to (- l 1) do
                    (setf (aref C i k)
                          (loop for j from 0 to (- n 1)
                                sum (* (aref A i j)
                                       (aref B j k))))))
    C))


(deflayer Dense ((l l)
		 (y y)
		 (w (make-array (list l y)))
		 (b (make-array y))) (x) model
  (let ((m (mmul x w)))
    (make-array (list 1 y)
		:initial-contents (list (loop for i from 0 to (1- (array-dimension m 1))
					:collect (+ (aref m 0 i)
						    (aref b i)))))))
