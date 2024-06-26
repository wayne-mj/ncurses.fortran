module ncursesmod
    use iso_c_binding
    implicit none

    interface
        subroutine initscr() bind(c, name="initscr")
            use iso_c_binding
        end subroutine initscr

        subroutine endwin() bind(c, name="endwin")
            use iso_c_binding
        end subroutine endwin

        subroutine mvprintw(y, x, fmt) bind(c, name="mvprintw")
            use iso_c_binding
            integer(c_int), value :: y, x
            character(c_char), dimension(*) :: fmt
        end subroutine mvprintw

        integer (c_int) function wgetch(win) bind(c, name="wgetch")
            use iso_c_binding
            type(c_ptr), value :: win
        end function wgetch

        subroutine refresh() bind(c, name="refresh")
            use iso_c_binding
        end subroutine refresh

        integer(c_int) function getch() bind(c, name="getch")
            use iso_c_binding
        end function getch

        subroutine move(y, x) bind(c, name="move")
            use iso_c_binding
            integer(c_int), value :: y, x
        end subroutine move

        subroutine clrtoeol() bind(c, name="clrtoeol")
            use iso_c_binding
        end subroutine clrtoeol

        type(c_ptr) function newwin(nlines, ncols, begin_y, begin_x) bind(c, name="newwin")
            use iso_c_binding
            integer(c_int), value :: nlines, ncols, begin_y, begin_x
        end function newwin

        subroutine wrefresh(win) bind(c, name="wrefresh")
            use iso_c_binding
            type(c_ptr), value :: win
        end subroutine wrefresh

        subroutine wprintw(win, fmt) bind(c, name="wprintw")
            use iso_c_binding
            type(c_ptr), value :: win
            character(c_char), dimension(*) :: fmt
        end subroutine wprintw

        subroutine wclrtoeol(win) bind(c, name="wclrtoeol")
            use iso_c_binding
            type(c_ptr), value :: win
        end subroutine wclrtoeol

        subroutine delwin(win) bind(c, name="delwin")
            use iso_c_binding
            type(c_ptr), value :: win
        end subroutine delwin

        subroutine box(win, verch, horch) bind(c, name="box")
            use iso_c_binding
            type(c_ptr), value :: win
            integer(c_int), value :: verch, horch
        end subroutine box

        subroutine echo() bind(c, name="echo")
            use iso_c_binding
        end subroutine echo

        subroutine noecho() bind(c, name="noecho")
            use iso_c_binding
        end subroutine noecho

        subroutine cbreak() bind(c, name="cbreak")
            use iso_c_binding
        end subroutine cbreak

        ! subroutine getyx(win, y, x) bind(c, name="getyx")
        !     use iso_c_binding
        !     type(c_ptr), value :: win
        !     integer(c_int), intent(out) :: y, x
        ! end subroutine getyx

        integer(c_int) function getcurx(win) bind(c, name="getcurx")
            use iso_c_binding
            type(c_ptr), value :: win
        end function getcurx

        integer(c_int) function getcury(win) bind(c, name="getcury")
            use iso_c_binding
            type(c_ptr), value :: win
        end function getcury
    end interface

    

end module ncursesmod