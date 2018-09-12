# export PS1="\u@\h : \w \n> \[$(tput sgr0)\]"

function _update_ps1() {
    PS1="$(powerline-shell $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

alias gst="git status"
alias ga="git add"
alias gc="git commit -v"
alias gb="git branch"
alias grb="git rebase"
alias gco="git checkout"

alias clear-sim="xcrun simctl erase all"
alias clear-build="rm -rf ios/build && rm -rf ios/Pods && pod cache clean --all && watchman watch-del-all && rm -rf node_modules/ && yarn cache clean && yarn install && cd ios && sudo gem install cocoapods && pod repo update && pod install && cd .."
alias sim-ipad="DRIVER_APP_REGION=us yarn set-firebase-env local && react-native run-ios --simulator='iPad Pro (12.9-inch) (2nd generation)'"
alias sim-iphone="DRIVER_APP_REGION=us yarn set-firebase-env local && react-native run-ios --simulator='iPhone 7 Plus'"
alias sim-ipad-cn="DRIVER_APP_REGION=cn yarn set-firebase-env local && react-native run-ios --simulator='iPad Pro (12.9-inch) (2nd generation)'"
alias sim-iphone-cn="DRIVER_APP_REGION=cn yarn set-firebase-env local && react-native run-ios --simulator='iPhone 7 Plus'"
alias sim-android="emulator -no-boot-anim -avd Pixel_API_23"
