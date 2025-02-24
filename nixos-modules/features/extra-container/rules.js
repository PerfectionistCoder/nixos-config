polkit.addRule(function (action, subject) {
    if (
        subject.isInGroup("machine")
        && action.id.indexOf("org.freedesktop.machine1.")
    )
        return polkit.Result.YES;
});