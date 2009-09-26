(require 'java-mode-indent-annotations)

(defun ash-c-mode-customizations ()
  (setq c-basic-offset 2)
  (c-subword-mode)
  (hs-org/minor-mode)
  (add-to-list 'c-cleanup-list 'comment-close-slash))

(defun ash-java-mode-customizations ()
  (ash-c-mode-customizations)
  (java-mode-indent-annotations-setup))

(add-hook 'java-mode-hook
          (lambda () (ash-java-mode-customizations)))

(add-hook 'c-mode-hook
          'ash-c-mode-customizations)

(defun ash-blank-line-p ()
  (string-match "^\s*$" (ash-current-line)))

(defun ash-previous-blank-line ()
  (while (and (> (point) 0)
              (not (ash-blank-line-p)))
    (previous-line)))

(defun ash-in-import-block ()
  "Returns true if the current line matches something to be found in an import block,
such as an import statement or a blank line"
  (or (string-match "import" (ash-current-line))
      (ash-blank-line-p)))

;; copied from org-mode
(defun ash-no-properties (s)
  (if (fboundp 'set-text-properties)
      (set-text-properties 0 (length s) nil s)
    (remove-text-properties 0 (length s) org-rm-props s))
  s)

(defun ash-current-line ()
  (save-excursion
    (let ((begin (progn (beginning-of-line)
                        (point)))
          (end (progn (end-of-line)
                      (point))))
      (buffer-substring-no-properties begin end))))

(defvar ash-java-ordering
  '("com" "junit" "net" "org" "java[^x]" "javax")
  "Ordering of import regex, each one defines a block that
  matches the regex and is separated from other blocks by a
  line")

(defun ash-java-organize-imports ()
  "Organize imports in groups according to `ash-java-ordering'"
  (interactive)
  (save-excursion
   (goto-line 1)
   (re-search-forward "^package" nil t)
   (beginning-of-line 3)
   (let ((group-alist (mapcar 'list ash-java-ordering))
         (unknowns))
     (while (ash-in-import-block)
       (let ((line (ash-current-line)))
         (unless (or (ash-blank-line-p) (ash-java-unused-import-p line))
           (dolist (group group-alist)
             (when (string-match (car group) line)
               (unless (member line group)  ;; no dups
                 (setf (cdr group) (cons line (cdr group))))
               (return)))   ;; no more matching
           (when (= (length line) 0)
             ;; then we haven't matched yet
             (add-to-list 'unknowns line))))
       (kill-line))
     ;; At this point, everything has been eaten, so let's let it all
     ;; come back out.
     (add-to-list 'group-alist (cons "" unknowns))
     (dolist (group group-alist)
       (dolist (line (sort (cdr group) 'string<))
         (insert line "\n"))
       (when (cdr group) (insert "\n"))))))

(defun ash-java-unused-import-p (line)
  (save-excursion
    (goto-line 1)
    (re-search-forward "[@{]" nil t)
    (null (re-search-forward (car
                             (last (butlast
                                    (split-string line "[\\.;]")))) nil t))))


(defun ash-java-add-imports (imports)
  "Add imports to this java file, if it is not there already.
Each import is a fully qualified class name only."
  (interactive)
  (save-excursion
    (goto-line 1)
    (unless (re-search-forward "^import" nil t)
      (goto-line 1)
      (next-line 1)
      (insert "\n"))
    (beginning-of-line)
    (dolist (import imports)
      (insert (format "import %s;\n" import)))
    (ash-java-organize-imports)))

(defun ash-java-add-grabbed-import ()
  "For use in conjunction with `ash-java-grab-import'.  Takes a
grabbed import and sticks it in the current java file, organizing
imports afterwards."
  (interactive)
  (ash-java-add-imports (list (get-register 105))))

(defun ash-java-guess-imports ()
  "Add imports found in open java buffers that are appropriate
for this buffer. "
  (interactive)
  (unless (eq major-mode 'java-mode)
    (error "Must be run from a java buffer"))
  (let ((imports))
    (dolist (buf (buffer-list))
      (when (string-match "java$" (or (buffer-file-name buf) ""))
        (with-current-buffer buf
          (setq imports (append imports (ash-java-get-imports))))))
    (ash-java-add-imports imports)))

(defun ash-java-get-imports ()
  "Get a list of fully qualified class names that are file's
import statements."
  (save-excursion
    (let ((imports))
      (goto-line 1)
      (while (re-search-forward "^import \\(.*\\);$" nil t)
        (add-to-list 'imports (ash-no-properties (match-string 1))))
      imports)))

(defun ash-java-grab-import ()
  "Grab the current file as an import name, and put it in the
register 105 (i).  Use this in conjunction with
`ash-java-add-grabbed-import'."
  (interactive)
  (unless (eq major-mode 'java-mode)
    (error "Must be run from a java buffer"))

  (save-excursion
    (goto-char 0)
    (let ((package-name (progn
                          (when (re-search-forward "^package " nil t)
                            (beginning-of-line)
                            (set-mark (point))
                            (end-of-line)
                            (buffer-substring (+ (mark) 8) (- (point) 1)))))
          (class-name (file-name-sans-extension
                       (file-name-nondirectory (buffer-file-name)))))
      (set-register 105 (concat package-name (when package-name ".") class-name)))))

(global-set-key [f8] 'ash-java-grab-import)
(global-set-key [f9] 'ash-java-add-grabbed-import)

(provide 'ash-java)
