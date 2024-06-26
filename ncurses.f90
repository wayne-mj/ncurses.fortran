program formexample
    use iso_c_binding
    use ncursesmod
    implicit none

    integer(c_int) :: ch, y, x, f1x, f2x, i
    character(len=20) :: field1, field2, temp
    integer :: field_length
    type(c_ptr) :: win

    field_length = 20
    field1 = " "
    field2 = " "
    temp = ""

   
    call initscr()
    win = newwin(20, 80, 0, 0)
    y = 10
    x = 40

    f1x =0
    f2x =0

    
    call refresh()
   
    ! call move(10,30)
    ! call refresh()
    ! call box(win, 0, 0)
    call mvprintw(10,30, "field 1:> ")
    call mvprintw(12,30, "field 2:> ")
    call move(y, x)
    ! call wrefresh(win)
    call refresh()
    do !while (ch /= 10)
        ch = getch()
        

        select case (ch)
        case (9)    ! tab
            if (y == 10) then
                y = 12
                if (f1x .gt. 40) then 
                    x = f1x
                else
                    x = 40
                end if
            else
                y = 10
                if (f2x .gt. 40) then
                    x = f2x
                else
                    x = 40
                end if
            end if
            call move(y, x)
            call refresh()
        case (127)    ! backspace
            if (y == 10) then
                !if (len_trim(field1) .gt. 0) then
                    ! field1 = " "
                    field1 = field1(1:len_trim(field1)-1) // " "
                    call move(10, 30)
                    call clrtoeol()
                    call mvprintw(10,30, "field 1:> " // trim(field1) // achar(0))
                    call refresh()
                !end if
            else if (y == 12) then
                !if (len_trim(field2) .gt. 0) then
                    ! field2 = " "
                    field2 = field2(1:len_trim(field2)-1) // " "
                    call move(12, 30)
                    call clrtoeol()
                    call mvprintw(12,30, "field 2:> " // trim(field2) // achar(0))
                    call refresh()
                !end if
            end if
            
        case (10)   ! enter
            exit
        case default
            if ((ch .ge. 32 .and. ch .le. 126)) then
                !gx = getcurx(win)
                !gy = getcury(win)
                if (y == 10) then
                    field1 = field1(1:len_trim(field1)) // char(ch)
                    f1x = getcurx(win)
                else if (y == 12) then
                    field2 = field2(1:len_trim(field2)) // char(ch)
                    f2x = getcurx(win)
                end if
            end if
        end select
        call refresh()
    end do

    
    call delwin(win)
    ! end ncurses
    call endwin()

    ! print captured field values
    print *, "field 1: ", field1
    print *, "field 2: ", field2
    print *, temp
end program formexample
