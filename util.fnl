(local {: gettimeofday} (require :posix.sys.time))

(fn eprintf [fmt ...]
  (io.stderr:write (string.format fmt ...))
  nil)

(fn new-timer []
  (local time-start (gettimeofday))

  (fn value []
    (let [time-end (gettimeofday)
          delta-sec (- time-end.tv_sec time-start.tv_sec)
          delta-usec (+ (* 1000000 delta-sec)
                        (- time-end.tv_usec time-start.tv_usec))]
      delta-usec))

  {: value})

{: eprintf
 : new-timer}
