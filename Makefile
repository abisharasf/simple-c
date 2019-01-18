ODIR = build

lsrc = $(wildcard src/lib/*.c)
lobj = $(lsrc:src/lib/%.c=$(ODIR)/%.o)
mbin = $(patsubst src/models/%.c, $(ODIR)/%, $(wildcard src/models/*.c))

extlibroot = external-libs/simple-c-external-lib/

.PHONY: default
default: $(mbin)

$(ODIR):
	mkdir -p $(ODIR)

# build internal library
$(ODIR)/%.o: src/lib/%.c | $(ODIR)
	$(CC) -c -o $@ $^

$(ODIR)/libtest.a: $(lobj)
	ar rcs $@ $^

# build models depending only on self
$(ODIR)/%: src/models/%.c $(ODIR)/libtest.a | $(ODIR)
	$(CC) -Isrc -o $@ $< -Lbuild -ltest

# make external library
$(ODIR)/libexttest.a:
	$(MAKE) -C $(extlibroot) ODIR=../../$(ODIR)

# build models depending on external library
$(ODIR)/print3: src/models/print3.c $(ODIR)/libtest.a $(ODIR)/libexttest.a | $(ODIR)
	$(CC) -Isrc -I$(extlibroot)/src -o $@ $< -Lbuild -ltest -lexttest


.PRECIOUS: $(ODIR)/%.o

.PHONY: dum
dum:
	echo $(mbin)

.PHONY: clean
clean:
	rm -rf build

