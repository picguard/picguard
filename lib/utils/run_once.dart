class RunOnce {
  bool _hasRun = false;
  void call(void Function() function) {
    if (_hasRun) return;
    // Set after calling if you don't want a throw to count as a run.
    _hasRun = true;
    function();
  }
}
