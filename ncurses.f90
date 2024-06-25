PROGRAM FormExample
    USE ISO_C_BINDING
    IMPLICIT NONE

    INTERFACE
        SUBROUTINE initscr() BIND(C, NAME="initscr")
            USE ISO_C_BINDING
        END SUBROUTINE initscr

        SUBROUTINE endwin() BIND(C, NAME="endwin")
            USE ISO_C_BINDING
        END SUBROUTINE endwin

        SUBROUTINE mvprintw(y, x, fmt) BIND(C, NAME="mvprintw")
            USE ISO_C_BINDING
            INTEGER(C_INT), VALUE :: y, x
            CHARACTER(C_CHAR), DIMENSION(*) :: fmt
        END SUBROUTINE mvprintw

        INTEGER (C_INT) FUNCTION wgetch(win) BIND(C, NAME="wgetch")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END FUNCTION wgetch

        SUBROUTINE refresh() BIND(C, NAME="refresh")
            USE ISO_C_BINDING
        END SUBROUTINE refresh

        INTEGER(C_INT) FUNCTION getch() BIND(C, NAME="getch")
            USE ISO_C_BINDING
        END FUNCTION getch

        SUBROUTINE move(y, x) BIND(C, NAME="move")
            USE ISO_C_BINDING
            INTEGER(C_INT), VALUE :: y, x
        END SUBROUTINE move

        SUBROUTINE clrtoeol() BIND(C, NAME="clrtoeol")
            USE ISO_C_BINDING
        END SUBROUTINE clrtoeol

        TYPE(C_PTR) FUNCTION newwin(nlines, ncols, begin_y, begin_x) BIND(C, NAME="newwin")
            USE ISO_C_BINDING
            INTEGER(C_INT), VALUE :: nlines, ncols, begin_y, begin_x
        END FUNCTION newwin

        SUBROUTINE wrefresh(win) BIND(C, NAME="wrefresh")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END SUBROUTINE wrefresh

        SUBROUTINE wprintw(win, fmt) BIND(C, NAME="wprintw")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
            CHARACTER(C_CHAR), DIMENSION(*) :: fmt
        END SUBROUTINE wprintw

        SUBROUTINE wclrtoeol(win) BIND(C, NAME="wclrtoeol")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END SUBROUTINE wclrtoeol

        SUBROUTINE delwin(win) BIND(C, NAME="delwin")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END SUBROUTINE delwin

        SUBROUTINE box(win, verch, horch) BIND(C, NAME="box")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
            INTEGER(C_INT), VALUE :: verch, horch
        END SUBROUTINE box

        SUBROUTINE noecho() BIND(C, NAME="noecho")
            USE ISO_C_BINDING
        END SUBROUTINE noecho

        SUBROUTINE cbreak() BIND(C, NAME="cbreak")
            USE ISO_C_BINDING
        END SUBROUTINE cbreak

        ! SUBROUTINE getyx(win, y, x) BIND(C, NAME="getyx")
        !     USE ISO_C_BINDING
        !     TYPE(C_PTR), VALUE :: win
        !     INTEGER(C_INT), INTENT(OUT) :: y, x
        ! END SUBROUTINE getyx

        INTEGER(C_INT) FUNCTION getcurx(win) BIND(C, NAME="getcurx")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END FUNCTION getcurx

        INTEGER(C_INT) FUNCTION getcury(win) BIND(C, NAME="getcury")
            USE ISO_C_BINDING
            TYPE(C_PTR), VALUE :: win
        END FUNCTION getcury
    END INTERFACE

    INTEGER(C_INT) :: ch, y, x, gx, gy
    CHARACTER(LEN=20) :: field1, field2, temp
    INTEGER :: field_length
    TYPE(C_PTR) :: win

    field_length = 20
    field1 = " "
    field2 = " "
    temp = ""

    ! Initialize ncurses
    

    ! call noecho()

    ! Create a new window
   

    
    
    

    
    CALL initscr()
    win = newwin(20, 80, 0, 0)
    y = 10
    x = 40

    gx =0
    gx =0

    
    call refresh()
   
    ! call move(10,30)
    ! call refresh()
    ! call box(win, 0, 0)
    call mvprintw(10,30, "Field 1:> ")
    call mvprintw(12,30, "Field 2:> ")
    call move(y, x)
    ! call wrefresh(win)
    call refresh()
    do !while (ch /= 10)
        ch = getch()
        

        select case (ch)
        case (9)    ! Tab
            if (y == 10) then
                y = 12
                x = 40
            else
                y = 10
                x = 40
            end if
            call move(y, x)
            call refresh()
        case (127)    ! Backspace
            if (y == 10) then
                !if (len_trim(field1) .gt. 0) then
                    field1 = " "
                    call move(10, 30)
                    call clrtoeol()
                    call mvprintw(10,30, "Field 1:> " // trim(field1) // achar(0))
                !end if
            else if (y == 12) then
                !if (len_trim(field2) .gt. 0) then
                    field2 = " "
                    call move(12, 30)
                    call clrtoeol()
                    call mvprintw(12,30, "Field 2:> " // trim(field2) // achar(0))
                !end if
            end if
            
        case (10)   ! Enter
            exit
        case default
            if ((ch .ge. 32 .and. ch .le. 126)) then
                !call getyx(win, gy, gx)
                gx = getcurx(win)
                if (y == 10) then
                    if (gx .lt. 50) then 
                        field1 = field1(1:len_trim(field1)) // char(ch)
                    end if 
                else if (y == 12) then
                    if (gx .lt. 50) then
                        field2 = field2(1:len_trim(field2)) // char(ch)
                    end if
                end if
            end if
        end select
        call refresh()
    end do

    
    call delwin(win)
    ! End ncurses
    CALL endwin()

    ! Print captured field values
    PRINT *, "Field 1: ", field1
    PRINT *, "Field 2: ", field2
    print *, temp
END PROGRAM FormExample
