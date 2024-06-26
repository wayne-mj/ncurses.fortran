FC=gfortran
FFLAGS=-O3 -Wall -Wextra -lncurses
AR=ar
ARARGS=r
MODULES=ncursesmod.f90
PROG=ncurses.f90
SRC=$(MODULES) $(PROG)
OBJ=${SRC:.f90=.o}
BASE=${SRC:.f90=}

all: clean lib $(PROG:.f90=)

%.o: %.f90
	$(FC) $(FFLAGS) -o $@ -c $<

$(PROG:.f90=): $(OBJ)
	$(FC) $(FFLAGS) -o $@ $(OBJ)

lib: $(MODULES)
	$(FC) $(FFLAGS) -c $(MODULES)

dist: clean lib $(MODULES)
	$(AR) $(ARARGS) $(PROG:.f90=.a) $(MODULES:.f90=.o)

clean:
	rm -f *.o *.mod $(BASE) *.a
