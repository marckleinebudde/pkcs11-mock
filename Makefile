# Display exported symbols:
#  nm -D pkcs11-mock.so | grep ' T '

SRC_DIR = src
CFLAGS += -Wall -Wextra -O1 -fPIC -ggdb
CPPFLAGS += -Iinclude
LIBNAME = pkcs11-mock.so

all: $(LIBNAME)

$(LIBNAME): pkcs11-mock.o
	$(CC) -shared -o $(LIBNAME) \
	-Wl,-soname,$(LIBNAME) \
	-Wl,--version-script,$(SRC_DIR)/pkcs11-mock.version \
	pkcs11-mock.o

pkcs11-mock.o: $(SRC_DIR)/pkcs11-mock.c include/cryptoki/*.h
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $(SRC_DIR)/pkcs11-mock.c

clean:
	-rm -f *.o *.so

distclean: clean
	-rm -f *.so
