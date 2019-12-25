
      SUBROUTINE LWPC_ERROR
     &          (error_type,error_msg)

c***********************************************************************
c                         subroutine lwpc_error
c***********************************************************************
c
c  Program Source:  Naval Ocean Systems Center - Code D882
c
c  Date:
c     29 October 1992
c
c  Function:
c     Displays an error message to either an graphics screen, or to the
c     standard output device.
c
c  Parameters passed:
c     error_level      [s] type error level:
c                         'WARNING' for a warning message
c                         'ERROR'   for a fatal error message
c     error_msg    [s] the error message to display/print
c
c  Parameters returned:
c
c  Common blocks referenced:
c
c  Functions and subroutines referenced:
c     close
c     log
c     write
c
c     sys_error_msg
c
c     str_length
c
c  Common blocks:
c     sysstrct.cmn
c
c  References:
c
c  Change History:
c     21 Oct 95     Changed to get the LOG unit from LWPC_LUN.CMN.
c
c*******************!***************************************************
      use, intrinsic:: iso_fortran_env, only: stderr=>error_unit
c     LWPC parameters
      include      'lwpc_lun.cmn'

c     Get sys error defintions
      INCLUDE      'sysstrct.cmn'
      INCLUDE      'graphics.cmn'

      character*(*) error_type
      character*(*) error_msg
      
      write (stderr,*) error_type(1:len_trim(error_type)), 
     &    error_msg(1:len_trim(error_msg))


      if (program_type(1:2) .eq. 'SY' .or.
     &    program_type(1:2) .eq. 'sy') then

c        This is a graphics program;
c        use sys_error_msg to write messages
         if (error_type(1:1) .eq. 'E' .or.
     &       error_type(1:1) .eq. 'e') then

c            10 defines a fatal error message
             sys_error_level=10
         else

c            0 defines an informational message only
             sys_error_level=0
         end if

         error stop 'error_msg'
 
      else

c        This is a text based program;
c        write messages to standard outout
         WRITE(lwpcLOG_lun,'(a)')
     &         error_type(:len_trim(error_type))
         WRITE(lwpcLOG_lun,'(a)')
     &         error_msg (:len_trim(error_msg ))

         if (error_type(1:1) .eq. 'E' .or.
     &       error_type(1:1) .eq. 'e') then

c           This is a fatal ERROR, force termination with a trace back
            temp=1.
            result=LOG(-1.*temp)
            CLOSE(lwpcLOG_lun)
            error STOP
         end if
      end if


      END      ! LWPC_ERROR

