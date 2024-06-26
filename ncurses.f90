program formexample
    use iso_c_binding
    use ncursesmod
    implicit none

    integer(c_int) :: ch, y, x, gx, gy, i
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

    gx =0
    gx =0

    
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
                x = 40
            else
                y = 10
                x = 40
            end if
            call move(y, x)
            call refresh()
        case (127)    ! backspace
            if (y == 10) then
                !if (len_trim(field1) .gt. 0) then
                    field1 = " "
                    gx = getcurx(win)
                    do i = 40, gx
                        call mvprintw(10,i, "*") 
                        call wrefresh(win)                       
                    end do
                    call move(10, 30)
                    !call clrtoeol()
                    call mvprintw(10,30, "field 1:> " // trim(field1) // achar(0))
                !end if
            else if (y == 12) then
                !if (len_trim(field2) .gt. 0) then
                    field2 = " "
                    call move(12, 30)
                    call clrtoeol()
                    call mvprintw(12,30, "field 2:> " // trim(field2) // achar(0))
                !end if
            end if
            
        case (10)   ! enter
            exit
        case default
            if ((ch .ge. 32 .and. ch .le. 126)) then
                gx = getcurx(win)
                gy = getcury(win)
                if (y == 10) then
                    if (gx .lt. 50) then 
                        field1 = field1(1:len_trim(field1)) // char(ch)
                        call echo()
                        call refresh()
                    else if (gx .ge. 50) then
                        call noecho()
                        call refresh()
                    end if 
                else if (y == 12) then
                    if (gx .lt. 50) then
                        field2 = field2(1:len_trim(field2)) // char(ch)
                        call echo()
                        call refresh()
                    else if (gx .ge. 50) then
                        call noecho()
                        call refresh()
                    end if
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
