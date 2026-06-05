CC ?= gcc
CFLAGS_EXTRA ?=
CFLAGS ?= -O3 -std=c11 -Wall -Wextra -Wno-unused-parameter -Wno-unused-function -march=haswell -mavx2 -mfma -flto $(CFLAGS_EXTRA)
LDFLAGS ?= -pthread -lm -flto
API_BIN := rinha-c-api
API_SRC := src/main.c
API_URING_BIN := rinha-c-api-uring
API_URING_SRC := src/api_uring.c
LB_BIN := rinha-c-lb
LB_SRC := src/lb.c
.PHONY: all clean
all: $(API_BIN) $(API_URING_BIN) $(LB_BIN)
$(API_BIN): $(API_SRC)
	$(CC) $(CFLAGS) -o $@ $(API_SRC) $(LDFLAGS)
$(API_URING_BIN): $(API_URING_SRC) $(API_SRC)
	$(CC) $(CFLAGS) -o $@ $(API_URING_SRC) $(LDFLAGS) -luring
$(LB_BIN): $(LB_SRC)
	$(CC) $(CFLAGS) -o $@ $(LB_SRC) $(LDFLAGS)
clean:
	rm -f $(API_BIN) $(API_URING_BIN) $(LB_BIN)
