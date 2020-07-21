


921008-10:19am
this file formerly named tactics.001 - too hard to find with that name.
previous most recent entries in this file were approx jul/aug-90.



This is for update to add CCS SCSI compatibility.
We aim to change as little as possible otherwise,
therefore will try to retain existing Dataframe compatibility.

The main areas of incompatibility are:

               drive reset and initialization
               directory creation
               head parking





No changes needed in GNRCSCSI - this is all low-level and standard stuff.









SCSICMDS stuff:

Reset procedures (power up and scsi reset util) call scsi_multiple_conf:

               displays "scanning for scsi devices"

               clears bank_sel.b - uses for devices-present map
               drive_sel.w = 6 - scans downward
               scan uses request_sense command
                       if successful, a bit is marked in map -
                       a scsi error other than select_failed is
                       just as good, indicates device present.
               if no devices found, exits with drive_sel.w = -1 (floppy),
               "no scsi devices" message and no-error status.
               else ....

               resets scsi bus.
               displays "awaiting drive recal"
               sets drive_sel.w to zero - works upwards.
               works through devices-present map until all covered -
               polls, returns to each one if no immediate success,
               but keeps circulating to avoid getting hung up on any one.
               when drive_sel is on device-present channel:
********>              uses read_data_buffer command -
********>              THIS WILL CAUSE ERRORS ON A NON-DATAFRAME DRIVE.
                       success causes call to config_dataframe, which uses
                       the cur_omti_rev value set by read_data_buffer.
                       AN ERROR OTHER THAN SELECT_FAILED NOW CAUSES ABORT.
                       a select_failed error is initially interpreted to mean
                       that a 3103/3105 dataframe drive is recalibrating itself
                       in response to bus reset and is therefore not responding
                       to commands yet, since it doesn't know its own id  -
                       timeout is allowed, which is measured
                       by a set number of calls to read_data_buffer - the actual
                       timeout-determining factor is the wait for response to
                       selection which occurs as part of read-buffer command.
********>              successful config call causes removal of drive from
********>              devices-present map, addition to devices-configged map,
                       also displays "awaiting recal" again.
                       config failure causes abort.
               loop is exited when all devices configged, or timeout is up.
               drive_sel is now defaulted to -1.
               devices-configged map is scanned upward from 0.
               drive_sel is set per lowest id of configged device, if any.


Notes on modification of scsi_multiple_conf:

A device error response to read_data_buffer can be assumed to indicate a
non-dataframe drive present, or can be further investigated using a
request_sense command (which should yield "illegal request").
This should be handled similarly to successful dataframe config,
and the drive needs no further init.




config_dataframe is called by init_scsi_dir and set_new_scsi_id - watch out!

send_specifiers is also called by these routines - watch out!




assign_df20_params is a subroutine of config_dataframe, not called elsewhere.




park_the_heads is called locally only by config_dataframe - no problem.
it is also called multiple times in diskmain - watch out!
Simplest code mod is to test hd_drive_type within park_the_heads,
after checking for valid disk descriptor - exit without action if ccs drive.
Calls come mainly from diskmain and are largely similar in terms of
subsequent action - may be able to handle this there, which would be cleaner.






read_data_buffer is called in init_scsi_dir - watch out!












init_scsi_dir stuff:

               disk_deppidy calls read_descriptor as first step,
               to determine disk contents (if any).
               any device error here causes abort.
               failure to find valid descriptor causes immediate
               call to format_disk - if a descriptor is found,
               user is queried first.
               dataframe note - as a result of the above, disk heads
               are now positioned over physical track 32.

               format_disk transfers directly to init_scsi_dir
               if called for scsi drive.

               multiple warnings to user.

               resets scsi bus.
********>      attempts to read data buffer of drive_sel device -
********>      ANY DEVICE ERROR CAUSES PROCEDURE ABORT.
               implements timeout per scsi_multiple_config,
               but two seconds only, owing to head position assumed.
               read_data_buffer sets cur_omti_rev.
********>      calls config_dataframe.
********>      sets up values for hd_capacity and hd_drive_type
********>      according to cur_omti_rev and new_drive_size.
********>      new_drive_size is 0 for dataframe 20 or 1 for dataframe 40 -
********>      this parameter is set by user upon entering init function.
               displays "initializing directory".
               creates bank descriptor template.
               sets drive's bank_sel to 0 - works upward.
               writes all bank descriptors, with names = "emptyXXX",
               where XXX is the bank number.
               sets bank_sel back to zero.
               writes main disk descriptor.
********>      looks at hd_drive_type to determine need for further action:
********>      if 3103/3105 controller, calls send_specifiers in order to set
********>      max cyl addr to a value different from factory default.
               that's all!



Notes on modification of init_scsi_dir:

Rename new_drive_size to new_drive_type -
redefine so that zero setting is for ccs drive (call it "Standard SCSI").
When this value is passed to init_scsi_dir, branch past read-buffer stuff.
set hd_drive_type to indicate ccs device ( = 0? ),
then issue read_capacity command (should error-out on any dataframe drive).
abort if any error, else use result to set hd_capacity.
return to standard procedure to write bank and disk descriptors.
After descriptors written, no further action if hd_drive_type is ccs.

Note that currently, bank select range is always 1-100 (BANK_SEL = 0-99),
regardless of actual drive capacity, since drive is not polled at the time that
the bank number is adjusted.  This is roughly able to accommodate an 80 megabyte
drive.  This can be expanded to 1-256, to allow larger drives to be used without
needlessly compromising the usefulness of the slider for selecting bank numbers
in the smaller range which is more likely to be of interest (something like
1-55, on a 44 megabyte drive, or 1-125 on a 100 Meg unit).  The new
init_scsi_dir, which will key hd_capacity to actual drive size on a CCS drive,
may thus be able to create a "directory" containing a greater number of banks
than can be accessed, if a drive larger than 200 Meg is used, unless there is a
compelling reason to avoid this (ie, if it would cause problems in bank
directory displays, as this is the only time when the actual drive capacity is
referred to directly).  Although this is a bit of corner cutting, it will still
probably be unusual for any user to hang a drive greater than 100 megabytes onto
a 440 (to say nothing of inadvisable ....).  The Syquest 44 Meg unit is the most
likely target.

so:  rename BANK_SEL to bank_sel, make sure all references to it are kosher.
Subfunctions which use it should permit it to reach 255 as maximum.
Nahh ... fuck it.  I don't feel like changing it.




Notes on modification of set_new_scsi_id:

Disk descriptor is confirmed valid before calling -
we can check hd_drive_type and exit with approp error code
if it indicates a ccs drive.









Other:

Get rid of DRIVE_SEL_SUB, perhaps.











Notes after first pass:


Syquest drive is hanging during configuration procedure,
because some part of it is failing to handle unexpected
status phase - find it and handle it.
               This is the read_data_buffer command used in post-reset
               configuration loop - command routine is not correctly
               handling unexpected transition to status phase which is
               the response of Syquest to the unknown read buffer command.
               Verified on emulator that Syquest is attempting to return
               Check Condition status for read_data_buffer command,
               and sense key is Illegal Request - read_data_buffer command
               is adequate to clear post-reset Unit Attention condition.
			921008-10:20am
			it is true that the read_data_buffer command clears a pending unit 
			attention condition when issued to a syquest drive.  however, somewhere 
			back there in '90 i missed something, because now what i see is that 
			syquest is actually getting stuck in command phase when the 
			read_data_buffer command is thrown at it.  because the existing routine 
			doesn't know how to deal with any error other than the possible 
			wrong_phase, it leaves the syquest hanging here.  this is happening 
			because the command code for this command falls into a category which, 
			per the draft scsi-2 spec, is undefined, and the syquest is not 
			handling it as a six-byte command.  instead, it seems to want ten 
			bytes, based on preliminary experiments.  i will attempt to treat this 
			by putting a special case into this routine which, upon detecting 
			stuck_phase, will issue single command bytes in a loop (using a 
			specially-created filler_command_byte routine) until a wrong_phase 
			error occurs instead (or up to the maximum limit of 12 bytes total).  
			this should allow the syquest (and presumably any other ccs-kinda 
			drive) to complete the illegal command and get off the bus, and allow 
			read_data_buffer to fall through as was originally intended in this 
			situation.

			921008-04:41pm
			onemorething .... when not ready (no cartridge inserted), syquest will 
			respond correctly to test unit ready commands, but little else - will 
			go off into space with hung bus immediately after command phase.  it 
			was necessary to do the test unit ready thing in the config procedure 
			as well as for normal disk functions (as described below) in order to 
			avoid a hung device at powerup under these conditions.



Syquest enters unit attention condition after reset -
configuration routine should issue "NOP" request_sense command
upon successfully configuring each drive - won't affect Dataframes.
               As per above, read_data_buffer command clears Unit Attention
               condition - but I put this in anyway because it doesn't hurt.
               It is done only for non-Dataframe drives, however.
			921008-12:44pm
			as was the case in the above situation, this does not quite do the 
			trick.  unit attention recurs on a syquest each time a new cartridge is 
			inserted.  to remedy this, we create and deploy a test unit ready 
			command.  this is safest because there is no possibility of unexpected 
			phase transitions nor any need to provide for multiple outcomes - 
			command phase always gives way to status phase, regardless of the 
			status info returned, and unit attention, if any, is cleared.  this 
			command is inserted inline at the start of read_hd_descriptor, whereby 
			it becomes the first scsi access in all scsi functions except for scsi 
			bus reset.  used for this purpose, it is not truly necessary to examine 
			the return code which it sends back.  any problem state which it 
			encounters, other than unit attention, represents an "incurable" 
			problem which will immediately block the progress of any subsequent 
			scsi commands issued - ie, i'm cheezing out here, sorta.  we could make 
			better use of this.  one way would be to issue the command twice in 
			succession, and to check results after the second pass - error status 
			here could suppress further action and prompt a request-sense cycle, 
			but this would only be useful if the interpretation and reporting of 
			sense info were improved - in other words, ain't gonna do it now.
			ummm - well, kind of will, but cheezy again.  problem is, syquest does 
			a weird thing if accessed with a read command when no cartridge is 
			inserted - it accepts the command string, then goes off into space with 
			the bus hung.  it won't even pay attention if you try to stick in a 
			cartridge in this state.  i don't know why it should be doing this, but 
			testing with test unit ready is enough to prevent its occurrence.  so 
			what we do is, we do the test unit ready twice, so that the second one 
			can pick up this kind of "won't go away easily" error, and we blithely 
			assume it to indicate that the drive is not ready.


As paste-up for the above - if bus_not_free error is detected at start of
configuration procedure (in scan loop), issue bus reset and proceed
after brief delay (1 second at most).  This may result in Dataframes
being missed during the initial scan for devices, but - this is not
about Dataframes.  Dataframes be damned.
               Solution used was to jump out of scan loop and go directly
               to bus reset point in configuration procedure.
               This bypasses all drive initialization because device-present
               map stays empty - thus, net effect is simply to reset all
               bus devices.








