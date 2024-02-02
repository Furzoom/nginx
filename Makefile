CC = gcc
CFLAGS =  -O -W -Wall -Wpointer-arith -Wno-unused -g

CORE_DEPS = \
  src/core/nginx.h \
  src/core/ngx_alloc.h \
  src/core/ngx_array.h \
  src/core/ngx_auto_config.h \
  src/core/ngx_config.h \
  src/core/ngx_connection.h \
  src/core/ngx_hunk.h \
  src/core/ngx_listen.h \
  src/core/ngx_log.h \
  src/core/ngx_server.h \
  src/core/ngx_string.h \
  src/event/ngx_event.h \
  src/event/ngx_event_accept.h \
  src/event/ngx_event_close.h \
  src/event/ngx_event_write.h \
  src/event/modules/ngx_kqueue_module.h \
  src/http/ngx_http.h \
  src/http/ngx_http_header.h \
  src/os/unix/ngx_errno.h \
  src/os/unix/ngx_sendfile.h \
  src/os/unix/ngx_sendv.h \
  src/os/unix/ngx_stat.h \
  src/os/unix/ngx_time.h \
  src/os/unix/ngx_types.h \

CORE_INCS = -I src/core -I src/event -I src/event/modules -I src/http -I src/http/modules -I src/os/unix -I build

all: nginx

nginx: \
  build/src/core/nginx.o \
  build/src/core/ngx_alloc.o \
  build/src/core/ngx_array.o \
  build/src/core/ngx_listen.o \
  build/src/core/ngx_log.o \
  build/src/core/ngx_string.o \
  build/src/event/ngx_event.o \
  build/src/event/ngx_event_accept.o \
  build/src/event/ngx_event_close.o \
  build/src/http/ngx_http_event.o \
  build/src/os/unix/ngx_time.o \
  build/src/event/modules/ngx_select_module.o \

	$(CC) -o nginx \
  build/src/core/nginx.o \
  build/src/core/ngx_alloc.o \
  build/src/core/ngx_array.o \
  build/src/core/ngx_listen.o \
  build/src/core/ngx_log.o \
  build/src/core/ngx_string.o \
  build/src/event/ngx_event.o \
  build/src/event/ngx_event_accept.o \
  build/src/event/ngx_event_close.o \
  build/src/http/ngx_http_event.o \
  build/src/os/unix/ngx_time.o \
  build/src/event/modules/ngx_select_module.o \
   \


build/src/core/nginx.o: \
  src/core/nginx.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/nginx.o \
    src/core/nginx.c

build/src/core/ngx_alloc.o: \
  src/core/ngx_alloc.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/ngx_alloc.o \
    src/core/ngx_alloc.c

build/src/core/ngx_array.o: \
  src/core/ngx_array.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/ngx_array.o \
    src/core/ngx_array.c

build/src/core/ngx_listen.o: \
  src/core/ngx_listen.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/ngx_listen.o \
    src/core/ngx_listen.c

build/src/core/ngx_log.o: \
  src/core/ngx_log.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/ngx_log.o \
    src/core/ngx_log.c

build/src/core/ngx_string.o: \
  src/core/ngx_string.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/core/ngx_string.o \
    src/core/ngx_string.c

build/src/event/ngx_event.o: \
  src/event/ngx_event.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/event/ngx_event.o \
    src/event/ngx_event.c

build/src/event/ngx_event_accept.o: \
  src/event/ngx_event_accept.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/event/ngx_event_accept.o \
    src/event/ngx_event_accept.c

build/src/event/ngx_event_close.o: \
  src/event/ngx_event_close.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/event/ngx_event_close.o \
    src/event/ngx_event_close.c

build/src/os/unix/ngx_time.o: \
  src/os/unix/ngx_time.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/os/unix/ngx_time.o \
    src/os/unix/ngx_time.c

build/src/http/ngx_http_event.o: \
  src/http/ngx_http_event.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/http/ngx_http_event.o \
    src/http/ngx_http_event.c

build/src/event/modules/ngx_select_module.o: \
  src/event/modules/ngx_select_module.c $(CORE_DEPS)
	$(CC) -c $(CFLAGS) $(CORE_INCS) \
    -o build/src/event/modules/ngx_select_module.o \
    src/event/modules/ngx_select_module.c

.PHONY: clean all
clean:
	$(RM) nginx \
  build/src/core/nginx.o \
  build/src/core/ngx_alloc.o \
  build/src/core/ngx_array.o \
  build/src/core/ngx_listen.o \
  build/src/core/ngx_log.o \
  build/src/core/ngx_string.o \
  build/src/event/ngx_event.o \
  build/src/event/ngx_event_accept.o \
  build/src/event/ngx_event_close.o \
  build/src/http/ngx_http_event.o \
  build/src/os/unix/ngx_time.o \
  build/src/event/modules/ngx_select_module.o \
