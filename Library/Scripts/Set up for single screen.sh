#!/bin/sh

osascript <<APPLESCRIPT
    set_spaces_binding( "com.apple.mail", 4 )
    resize_application( "Mail", { 0, 22, 934, 900 } )
    
    
    
    to resize_application ( app_name, size )
        tell application app_name to ¬
            set the bounds of the first window to size
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
    end set_spaces_binding
APPLESCRIPT
