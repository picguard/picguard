// Copyright 2023 Insco. All rights reserved.
// This source code is licensed under the GNU General Public License v3.0.
// See the LICENSE file in the project root for full license information.

class RunOnce {
  bool _hasRun = false;
  void call(void Function() function) {
    if (_hasRun) return;
    // Set after calling if you don't want a throw to count as a run.
    _hasRun = true;
    function();
  }
}
