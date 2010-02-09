#!/bin/sh

osascript <<APPLESCRIPT
    
    resize_application( "Mail", { 0, 22, 934, 900 } )
    set_spaces_binding( "com.apple.mail", 4 )
    
    resize_application( "iCal", { 0, 22, 934, 900 } )
    set_spaces_binding( "com.apple.ical", 4 )
    
    resize_application( "Adium", { 735, 350, 1440, 900 } )
    
    
    
    to resize_application ( app_name, size )
        tell application app_name to ¬
            set the bounds of the first window to size
        do shell script "/bin/sleep 1"
    end resize_application
    
    to set_spaces_binding ( identifier, binding ) 
        set new_binding to ¬
            (run script "{|" & identifier & "|:" & binding & "}")
        tell application "System Events"
            tell expose preferences
                tell spaces preferences
                    set spaces_bindings to get application bindings
                    set application bindings ¬
                        to new_binding & spaces_bindings
                end tell
            end tell
        end tell
        do shell script "/bin/sleep 1"
    end set_spaces_binding
APPLESCRIPT
