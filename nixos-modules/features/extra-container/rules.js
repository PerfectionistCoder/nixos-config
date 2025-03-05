polkit.addRule(function (action, subject) {
  if (
    subject.isInGroup("machine") &&
    (((action.id == "org.freedesktop.systemd1.manage-units" ||
      action.id == "org.freedesktop.systemd1.manage-unit-files") &&
      action.lookup("unit").indexOf("container@") == 0) ||
      action.id == "org.freedesktop.machine1.shell")
  )
    return polkit.Result.YES;
});
