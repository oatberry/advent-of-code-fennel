(fn eprintf [fmt ...]
  (io.stderr:write (string.format fmt ...))
  nil)

{: eprintf}
