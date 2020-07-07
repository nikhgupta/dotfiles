(defun markdown-preview (&optional output-buffer-name)
  "Run `markdown-command' on the current buffer and view output in browser.
    When OUTPUT-BUFFER-NAME is given, insert the output in the buffer with
    that name."
  (interactive)
  (browse-url-of-buffer)) 
