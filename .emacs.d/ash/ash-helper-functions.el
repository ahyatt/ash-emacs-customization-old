(require 'cl)

(defun assoc-get (key alist)
  "Get the value corresponding to the key from an assoc list"
  (cdr (assoc key alist)))

(defun assoc-replace (oldalist newalist)
  "Replace or append values from the the old assoc list with the
new assoc list."
  (labels ((arep (oldalist newalist acc)
		 (if newalist
		     (let ((key (caar newalist)) (value (cdar newalist)))
		       (if (assoc key acc)
			   (progn (setcdr (assoc key acc) value)
				  (arep oldalist (cdr newalist) acc))
			 (arep oldalist (cdr newalist)
			       (append acc `((,key . ,value))))))
		   acc)))
    (arep oldalist newalist (copy-tree oldalist))))

;; in Gnu Emacs Extensions
(defmacro limited-save-excursion (&rest subexprs)
  "Like save-excursion, but only restores point"
  (let ((orig-point-symbol (make-symbol "orig-point")))
    `(let ((,orig-point-symbol (point-marker)))
       (unwind-protect 
	   (progn ,@subexprs)
	 (goto-char ,orig-point-symbol)))))

(defmacro with-every-filename (start var &rest subexprs)
  `(let ((max-lisp-eval-depth 1000))
     (ash-recur-and-execute
      ,start (lambda (,var) ,@subexprs))))

(defun ash-recur-and-execute (dir f)
  (dolist (child (directory-files dir 't "^[^.]"))
    (if (file-directory-p child)
      (ash-recur-and-execute child f)
      (funcall f child))))

(defmacro with-every-matching-filename (start var regex &rest rest)
  `(with-every-filename
    ,start ,var
    (when (string-match ,regex ,var)
      ,@rest)))

(defun ash-file-search-and-replace (dir from to &optional post-fun)
  (let ((buf (get-buffer-create " *tmpscript*")))
    (with-every-filename
     dir filename 
     (set-buffer buf)
     (erase-buffer)
     (insert-file-contents filename)
     (when (search-forward from nil 't)
       (message filename)
       (find-file filename)
       (g4-edit nil)
       (replace-string from to)
       (when post-fun
	 (funcall post-fun))
       (save-buffer)
       (kill-buffer (current-buffer))))))

(provide 'ash-helper-functions)
