proc findVhdFiles {directory includeBase} {
    set directory [string trimright [file join [file normalize $directory] { }]]
    if {$includeBase} {
        set directories $directory
    } else {
        set directories [list]
    }
    
    set parents $directory
    while {[llength $parents] > 0} {
        set children [list]
        foreach parent $parents {
            set children [concat $children [glob -nocomplain -type {d r} -path $parent *]]
        }
        set children [lsort -unique $children]

        set parents [list]
    
        foreach child $children {
            if {[lsearch -sorted $directories $child] == -1} {
                lappend parents $child
            }
        }
        set directories [lsort -unique [concat $directories $parents]]
    }

    set result [list]
    foreach directory $directories {
        foreach file [glob [file join $directory *.vhd]] {
            set result [concat $result $file]
        }
    }
    return [lsort -unique $result]
}