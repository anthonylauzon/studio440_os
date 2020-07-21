echo off



rem ... 911009 ...
rem ... 911009 ... \utils\stripasm seqdefs      e:seqdefs
rem ... 911009 ... \utils\stripasm q_blk_eq     e:q_blk_eq
rem ... 911009 ... \utils\stripasm equates      e:equates
rem ... 911009 ... \utils\stripasm event_eq     e:event_eq
rem ... 911009 ... \utils\stripasm field_eq     e:field_eq
rem ... 911009 ... \utils\stripasm g_q_blk      e:g_q_blk
rem ... 911009 ... \utils\stripasm g_ram_44     e:g_ram_44
rem ... 911009 ... \utils\stripasm g_v_blk      e:g_v_blk
rem ... 911009 ... \utils\stripasm lcd_funs     e:lcd_funs
rem ... 911009 ... \utils\stripasm s_blk_eq     e:s_blk_eq
rem ... 911009 ... \utils\stripasm trapdefs     e:trapdefs
rem ... 911009 ... \utils\stripasm v_blk_eq     e:v_blk_eq
rem ... 911009 ... \utils\stripasm diskdefs     e:diskdefs
rem ... 911009 ... copy hpfixups e:
rem ... 911009 ...





del %rd%\code.*
del %rd%\i\*.
del %rd%\i\*.imp
del %rd%\i\*.exp


stripasm seqdefs      %rd%\i\seqdefs
stripasm q_blk_eq     %rd%\i\q_blk_eq
stripasm equates      %rd%\i\equates
stripasm event_eq     %rd%\i\event_eq
stripasm field_eq     %rd%\i\field_eq
stripasm g_q_blk      %rd%\i\g_q_blk
stripasm g_ram_44     %rd%\i\g_ram_44
stripasm g_v_blk      %rd%\i\g_v_blk
stripasm lcd_funs     %rd%\i\lcd_funs
stripasm s_blk_eq     %rd%\i\s_blk_eq
stripasm trapdefs     %rd%\i\trapdefs
stripasm v_blk_eq     %rd%\i\v_blk_eq
stripasm diskdefs     %rd%\i\diskdefs
stripasm hpfixups     %rd%\i\hpfixups

