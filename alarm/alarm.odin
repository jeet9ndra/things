package alarm

import "base:runtime"
import "core:c"
import "core:fmt"
import "core:os"
import "core:sys/windows"
import "core:time"
import "vendor:sdl3"

play_alarm_at :: #config(next_alarm_in_hour, 1)
play_file::#config(alarm_tune,"E:\\Scripts and essays\\Olivia Rodrigo - Can’t Catch Me Now (from The Hunger Games： The Ballad of Songbirds & Snakes).opus")

main :: proc() {
	a: cstring = "alarm"
	
	// inbytes:[256]byte
	// b,e:=os.read(os.stdin,inbytes[:])
	///ADD some control interface and its done

	sdl3.CreateWindow(a, 200, 200, {.RESIZABLE})

	onAlarm: os.Process_Desc = {
		command     = {
			"ffplay",
			play_file,
			"-volume",
			"13",
			"-autoexit"
		},
		// stdout      = os.stdout,
		working_dir = "E:\\Scripts and essays",
	}
	startTime := time.now()
	ev: sdl3.Event
	for {
		if sdl3.WaitEventTimeout(&ev, 1000) {
			if ev.type == .WINDOW_CLOSE_REQUESTED {
				return
			}
		}

		now := time.now()
		if time.duration_hours(time.since(startTime)) > f64(play_alarm_at) {
			state, appstdout, appstderr, apperr := os.process_exec(onAlarm, context.allocator)
			fmt.print(state, string(appstdout), string(appstderr), apperr)
			return
		}
		fmt.print("\r",time.duration_hours(time.since(startTime)))
	}
}
