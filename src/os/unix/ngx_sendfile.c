
#include <ngx_config.h>
#include <ngx_types.h>
#include <ngx_errno.h>
#include <ngx_log.h>
#include <ngx_sendv.h>
#include <ngx_sendfile.h>

/*
  TODO:
    FreeBSD:
       check sent if errno == EINTR then should return right sent.
*/

/*
  returns
      0 done
     -1 error
*/

int ngx_sendfile(ngx_socket_t s,
                 ngx_iovec_t *headers, int hdr_cnt,
                 ngx_file_t fd, off_t offset, size_t nbytes,
                 ngx_iovec_t *trailers, int trl_cnt,
                 off_t *sent,
                 ngx_log_t *log)
{
  int i;
  for (i = 0; i < hdr_cnt; i++) {
    write(s, headers[i].iov_base, headers[i].iov_len);
  }
  sendfile(s, fd, offset, nbytes);
  for (i = 0; i < trl_cnt; i++) {
    write(s, trailers[i].iov_base, trailers[i].iov_len);
  }

  ngx_log_debug(log, "ngx_sendfile: %d, @%qd %d:%qd" _
  rc _ offset _ nbytes _ *sent);
  return 0;
}


#if (HAVE_FREEBSD_SENDFILE)

int ngx_sendfile(ngx_socket_t s,
                 ngx_iovec_t *headers, int hdr_cnt,
                 ngx_file_t fd, off_t offset, size_t nbytes,
                 ngx_iovec_t *trailers, int trl_cnt,
                 off_t *sent,
                 ngx_log_t *log)
{
    int             rc, i;
    ngx_err_t       err;
    struct sf_hdtr  hdtr;

    hdtr.headers = headers;
    hdtr.hdr_cnt = hdr_cnt;
    hdtr.trailers = trailers;
    hdtr.trl_cnt = trl_cnt;

#if (HAVE_FREEBSD_SENDFILE_NBYTES_BUG)
    for (i = 0; i < hdr_cnt; i++)
        nbytes += headers[i].iov_len;
#endif

    rc = sendfile(fd, s, offset, nbytes, &hdtr, sent, 0);

    if (rc == -1) {
        err = ngx_socket_errno;
        if (err != NGX_EAGAIN && err != NGX_EINTR) {
            ngx_log_error(NGX_LOG_ERR, log, err,
                         "ngx_sendfile: sendfile failed");
            return -1;

        } else {
            ngx_log_error(NGX_LOG_INFO, log, err,
                         "ngx_sendfile: sendfile sent only %qd bytes", *sent);
        }
    }

    ngx_log_debug(log, "ngx_sendfile: %d, @%qd %d:%qd" _
                  rc _ offset _ nbytes _ *sent);

    return 0;
}

#endif
