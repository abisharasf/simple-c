ODIR = build

lsrc = $(wildcard src/lib/*.c)
lobj = $(lsrc:src/lib/%.c=$(ODIR)/%.o)

.PHONY: default
default: $(ODIR)/print1 $(ODIR)/print2

$(ODIR):
	mkdir -p $(ODIR)

$(ODIR)/%.o: src/lib/%.c | $(ODIR)
	$(CC) -c -o $@ $^

$(ODIR)/%: src/models/%.c $(ODIR)/libtest.a | $(ODIR)
	$(CC) -Isrc -o $@ $< -Lbuild -ltest

$(ODIR)/libtest.a: $(lobj)
	ar rcs $@ $^

.PRECIOUS: $(ODIR)/%.o

.PHONY: dum
dum:
	echo $(lobj)

.PHONY: clean
clean:
	rm -rf build

