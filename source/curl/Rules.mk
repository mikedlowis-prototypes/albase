PHONY  += curl
ECLEAN += $(BINDIR)/curl $(CURL_OBJS)
DIRS   += $(CURL_OBJDIR)/lib/vtls $(CURL_OBJDIR)/src

CURL_SUBDIR = source/curl
CURL_OBJDIR = $(OBJDIR)/curl
CURL_SRCS   = $(wildcard $(CURL_SUBDIR)/src/*.c)
CURL_OBJS   = $(patsubst $(CURL_SUBDIR)/%,$(CURL_OBJDIR)/%.o,$(basename $(CURL_SRCS)))

CURL_INCS   = -I$(CURL_SUBDIR)/include/curl -I$(CURL_SUBDIR)/include -I$(CURL_SUBDIR)/lib
CURL_DEFS   = -DHAVE_CONFIG_H -DBUILDING_LIBCURL -DCURL_STATICLIB -DCURL_HIDDEN_SYMBOLS
CURL_CFLAGS = -fvisibility=hidden -O2

CURL_LIB      = $(LIBDIR)/libcurl.a
CURL_LIB_SRCS = $(wildcard $(CURL_SUBDIR)/lib/*.c $(CURL_SUBDIR)/lib/vtls/*.c)
CURL_LIB_OBJS = $(patsubst $(CURL_SUBDIR)/%,$(CURL_OBJDIR)/%.o,$(basename $(CURL_LIB_SRCS)))

curl: $(BINDIR)/curl

$(BINDIR)/curl: $(CURL_OBJS) $(CURL_LIB)
	$(CC) -o $@ $^

$(CURL_LIB): $(CURL_LIB_OBJS)

$(CURL_OBJDIR)/%.o: $(CURL_SUBDIR)/%.c $(CC)
	$(CC) $(CURL_INCS) $(CURL_DEFS) $(CURL_CFLAGS) -c -o $@ $<
